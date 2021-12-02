import 'package:app2park/app/helpers/price/preco_avulso_item.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/moduleoff/price_helper.dart';
import 'package:path/path.dart';

import 'extrato.dart';

class PriceHelperClass {
  calcularPreco(String ent, String sai, int id_price_detached, int horas, int minutos, int segundos, int hr, int min, int sec) async {
    var entrada = DateTime.parse(ent);
    print('Entrada = $entrada');
    var saida = DateTime.parse(sai);
    print('Saída   = $saida');
    print('Permanência = ' + saida.difference(entrada).toString());
    print('-------------------------------');
    print('hr : $hr');
    print('min : $min');
    print('sec : $sec');

    print('-------------------------------');

    var extratoList = List<Extrato>();

    // Somatório das tolerâncias dos serviços adicionais contratos neste ticket.
    //   Ex.: Contratou higienização, que tem tolerência (dá direito de estacionamento grátis) por 2h.
    //        Então só começa a cobrar 2h depois da entrada do veículo.
    //        Se o veículo sair antes destas 2h, não paga o estacionamento.

    var toleranciaServicosAdicionais =
        new Duration(hours: horas, minutes: minutos, seconds: segundos);
    print(toleranciaServicosAdicionais);
    if (toleranciaServicosAdicionais.inSeconds > 0) {
      print('Total de tolerância de Serviços Adicionais: ' +
          toleranciaServicosAdicionais.toString());
      entrada = entrada.add(toleranciaServicosAdicionais);

      if (entrada.compareTo(saida) < 0) {
        print('Início da cobrança do estacionamento: ' + entrada.toString());
      } else {
        print('Estacionamento sem custo!');
        Extrato e = Extrato();
        e.nome = "Estacionamento sem custo!";
        e.preco = 0.0;
        e.quantidade = 0;
        extratoList.add(e);
        return extratoList;
      }
    }

    // Diárias que não começam meia noite. Ex,: Hoteis diária começa meio dia.
    var finalDaDiaria =
        DateTime(entrada.year, entrada.month, entrada.day + 1, hr, min, sec);

    print('-------------------------------');

    var datahoraSemTolerancia;
    var datahoraComTolerancia;
    int achouAdicionais = 0;
    var precoUltimo = PrecoAvulsoItem();
    var precoSelecionado = PrecoAvulsoItem();
    var precoProximo = PrecoAvulsoItem();
    var arredondamento = PrecoAvulsoItem();

    var precos = List<PrecoAvulsoItem>();
    TicketHistoricDao ticketDao = TicketHistoricDao();

    List<PriceHelper> priceHelperlist =
        await ticketDao.getPriceHelper(id_price_detached);
    for (int i = 0; i < priceHelperlist.length; i++) {
      PriceHelper priceHelper = priceHelperlist[i];
      var p = PrecoAvulsoItem();
      p.precoAvulsoItemId = priceHelper.id_price_detached_item_app;
      p.precoAvulsoItemBaseId = priceHelper.id_price_detached_item_base;
      p.nome = priceHelper.name;
      p.tempo = priceHelper.time;
      p.preco = priceHelper.price;
      p.tolerancia = priceHelper.tolerance;
      p.tipo = int.parse(priceHelper.type);
      p.level = priceHelper.level;
      List datas = priceHelper.time.split(' ');
      print(datas);
      String data = datas[0];
      String tempo = datas[1];
      List datalist = data.split("-");
      List tempolist = tempo.split(':');
      print(datalist);
      print(tempolist);
      p.tempoYear = int.parse(datalist[0]);
      p.tempoMonth = int.parse(datalist[1]);
      p.tempoDay = int.parse(datalist[2]);
      p.tempoHour = int.parse(tempolist[0]);
      p.tempoMinute = int.parse(tempolist[1]);
      p.tempoSecond = int.parse(tempolist[2]);
      List toleranceList = priceHelper.tolerance.split(':');
      print(toleranceList);
      p.toleranciaHour = int.parse(toleranceList[0]);
      p.toleranciaMinute = int.parse(toleranceList[1]);
      p.toleranciaSecond = int.parse(toleranceList[2]);
      precos.add(p);
    }

    for (var i = 0; i < precos.length; i++) {
      datahoraSemTolerancia = DateTime(entrada.year   + precos[i].tempoYear,
          entrada.month  + precos[i].tempoMonth,
          entrada.day    + precos[i].tempoDay,
          entrada.hour   + precos[i].tempoHour,
          entrada.minute + precos[i].tempoMinute,
          entrada.second + precos[i].tempoSecond);

      datahoraComTolerancia = DateTime(entrada.year   + precos[i].tempoYear,
        entrada.month  + precos[i].tempoMonth,
        entrada.day    + precos[i].tempoDay,
        entrada.hour   + precos[i].tempoHour + precos[i].toleranciaHour,
        entrada.minute + precos[i].tempoMinute + precos[i].toleranciaMinute,
        entrada.second + precos[i].tempoSecond + precos[i].toleranciaSecond,);

      //print(precos[i].nome + ' = ' + precos[i].tempo + ' (Tolerância: ' + precos[i].tolerancia + ')');

      if ( precos[i].tipo == 0 ) {
        if ( achouAdicionais == 1 ) {
          if ( saida.isBefore(datahoraSemTolerancia) ) {

            precoSelecionado = precoUltimo;
            break;
          }
        } else {
          if ( saida.isBefore(datahoraComTolerancia) || saida.isAtSameMomentAs(datahoraComTolerancia)) {

            precoSelecionado = precos[i];
            break;
          }
        }

        precoUltimo = precos[i];

        achouAdicionais = 0;

      } else {
        achouAdicionais = 1;
      }
    }

    print('');
    if ( precoSelecionado.precoAvulsoItemId == 0 ) {
      precoSelecionado = precoUltimo;
    }


    // $preco_proximo
    for (var i = 0; i < precos.length; i++) {
      if ( precos[i].tipo == 0 ) {
        if ( precos[i].precoAvulsoItemBaseId > precoSelecionado.precoAvulsoItemBaseId ) {
          precoProximo = precos[i];
          break;
        }
      }
    }




    // Cálculo de Diárias
    int diaria =0 ;
    if ( precoSelecionado.precoAvulsoItemBaseId == 10000 ) {
      diaria = 1;
    } else {
      if ( (precoProximo.precoAvulsoItemId > 0)
          && (precoProximo.precoAvulsoItemBaseId == 10000)
          && (finalDaDiaria.isBefore(saida)) ) {

        precoSelecionado = precoProximo;
        precoProximo = PrecoAvulsoItem();

        // precoProximo
        for (var i = 0; i < precos.length; i++) {
          if ( precos[i].tipo == 0 ) {
            if ( precos[i].precoAvulsoItemBaseId > precoSelecionado.precoAvulsoItemBaseId ) {
              precoProximo = precos[i];
              break;
            }
          }
        }

        diaria = 1;
      }
    }

    // Em Dart, saldo passa a ser entrada SOMADO o tempo do preço ou do adicional.
    // saldo não é mais o saldo em segundos da entrada SUBTRAIDO do tempo do preço ou do adicional.
    var saldo;
    if ( diaria == 1 ) {
      print('Término da Diária = $finalDaDiaria');
      saldo = finalDaDiaria;
    } else {
      saldo =             DateTime(entrada.year   + precoSelecionado.tempoYear,
          entrada.month  + precoSelecionado.tempoMonth,
          entrada.day    + precoSelecionado.tempoDay,
          entrada.hour   + precoSelecionado.tempoHour,
          entrada.minute + precoSelecionado.tempoMinute,
          entrada.second + precoSelecionado.tempoSecond);
      print('Saldo sem Diária = ' + saldo.toString());
    }
    // Cálculo de Diárias

    double valor = precoSelecionado.preco;

    //var extratos = List<Extrato>();
    var extratos = Map();
    var e = Extrato();
    e.nome              = precoSelecionado.nome;
    e.quantidade        = 1;
    e.preco             = precoSelecionado.preco;
    e.tempo             = precoSelecionado.tempo;
    e.tolerancia        = precoSelecionado.tolerancia;
    e.tempoYear         = precoSelecionado.tempoYear;
    e.tempoMonth        = precoSelecionado.tempoMonth;
    e.tempoDay          = precoSelecionado.tempoDay;
    e.tempoHour         = precoSelecionado.tempoHour;
    e.tempoMinute       = precoSelecionado.tempoMinute;
    e.tempoSecond       = precoSelecionado.tempoSecond;
    e.toleranciaHour    = precoSelecionado.toleranciaHour;
    e.toleranciaMinute  = precoSelecionado.toleranciaMinute;
    e.toleranciaSecond  = precoSelecionado.toleranciaSecond;
    extratos[precoSelecionado.precoAvulsoItemBaseId] = e;




    // Tolerância da Faixa de Preço
    var saldoSomandoTolerancia =          DateTime(saldo.year   ,
        saldo.month  ,
        saldo.day    ,
        saldo.hour   + precoSelecionado.toleranciaHour,
        saldo.minute + precoSelecionado.toleranciaMinute,
        saldo.second + precoSelecionado.toleranciaSecond);
    //print('');
    //print('saldoSomandoTolerancia = ' + saldoSomandoTolerancia.toString());


    //print('');
    //print("saldo= " + saldo.toString());
    //print("saida= " + saida.toString());
    //print("saldo isBefore saida= " + saldo.isBefore(saida).toString() );
    print('');


    //if ( $saldo > 0 && ($saldo - $preco_selecionado['tolerancia_segundos']) <= 0 ) {
    // "$saldo > 0" => ainda existe saldo!
    // e
    // "($saldo - $preco_selecionado['tolerancia_segundos']) <= 0 )"  => saldo acaba se descontar a tolerância!
    if ( saldo.isBefore(saida)
        && (saldoSomandoTolerancia.isAfter(saida) || saldoSomandoTolerancia.isAtSameMomentAs(saida)) ) {

      e = Extrato();
      e.nome              = 'Tolerância faixa de ' + precoSelecionado.tolerancia;
      e.quantidade        = 1;
      e.preco             = 0;
      e.tempo             = precoSelecionado.tempo;
      e.tempoYear         = precoSelecionado.tempoYear;
      e.tempoMonth        = precoSelecionado.tempoMonth;
      e.tempoDay          = precoSelecionado.tempoDay;
      e.tempoHour         = precoSelecionado.tempoHour;
      e.tempoMinute       = precoSelecionado.tempoMinute;
      e.tempoSecond       = precoSelecionado.tempoSecond;
      e.toleranciaHour    = precoSelecionado.toleranciaHour;
      e.toleranciaMinute  = precoSelecionado.toleranciaMinute;
      e.toleranciaSecond  = precoSelecionado.toleranciaSecond;
      extratos['Tolerandia'] = e;


      saldo = saida;

      print('Saldo depois da tolerência do preco_selecionado = ' + saldo.toString() );
    }


    // Adicionais

    int i;
    var adicionais = List<PrecoAvulsoItem>();
    var adicionalProximo = PrecoAvulsoItem();

    if ( saldo.isBefore(saida)  ) {
      // Carregando os adiconais deste $precoSelecionado.

      for (var i = 0; i < precos.length; i++) {
        if ( precos[i].precoAvulsoItemBaseId <= precoSelecionado.precoAvulsoItemBaseId ) {
          continue;
        }

        if ( precos[i].tipo == 1 && precos[i].level == precoSelecionado.level ) {
          adicionais.add(precos[i]);
        }
      }

      // Inverte a ordem da matriz de adicionais. Ex.: de minuto, hora, dia para dia, hora, minuto, para ir descontando primeiro os dias, depois as hora, e depois os minutos se houver.
      //$adicionais = array_reverse($adicionais);
      // i = 0; // Índice de adicionais. No arredondamento_adicionais verifica se é o último adicional. Se for último, verifica se o $valor, com  $qtd+1, é maior que $proximo_adicional['valor']. Se for, já arredonda para o $proximo_adicional.

      var saldoSomandoAdicional;
      var diferencaEmSegundos;
      var adicionalEmSegundos;

      // Os adicionais do $precoSelecionado são adicionandos do saldo.

      for (i = (adicionais.length - 1); i >= 0 ; i--) {

        saldoSomandoAdicional = DateTime(saldo.year   + adicionais[i].tempoYear,
            saldo.month  + adicionais[i].tempoMonth,
            saldo.day    + adicionais[i].tempoDay,
            saldo.hour   + adicionais[i].tempoHour,
            saldo.minute + adicionais[i].tempoMinute,
            saldo.second + adicionais[i].tempoSecond);


        //if ( ($adicional['tempo_segundos'] <= $saldo) || ( $saldo > 0 && $i == count($adicionais)) ) {
        if ( (saldoSomandoAdicional.isBefore(saida)) || ( saldo.isBefore(saida) && i == 0) ) {

          //print('Saldo antes dos adicionais=' + saldo.toString() + ' ----- Adicional: ' + adicionais[i].nome);
          //print('saldoSomandoAdicional=' + saldoSomandoAdicional.toString());

          diferencaEmSegundos = saida.difference(saldo).inSeconds;
          adicionalEmSegundos = saldoSomandoAdicional.difference(saldo).inSeconds;
          //print('diferencaEmSegundos = $diferencaEmSegundos');
          //print('adicionalEmSegundos = $adicionalEmSegundos');

          //$qtd_aux = max(floor($saldo / (strtotime($adicional['tempo']) - strtotime('0000-00-00 00:00:00'))) - 1, 1);
          //var qtdAux = max((diferencaEmSegundos ~/ adicionalEmSegundos) -1, 1);
          //var qtd = max((diferencaEmSegundos ~/ adicionalEmSegundos) -1, 1);
          int qtd = ((diferencaEmSegundos ~/ adicionalEmSegundos) -1).compareTo(1) > 1 ? ((diferencaEmSegundos ~/ adicionalEmSegundos) -1) : 1;
          //print('qtdAux= $qtdAux');
          //print('qtd inicial= $qtd');

          var saldoSomandoAdicionalComTolerancia;
          do {
            //saldoSomandoAdicional = DateTime(saldo.year   + (adicionais[i].tempoYear   * qtd),
            //                                 saldo.month  + (adicionais[i].tempoMonth  * qtd),
            //                                 saldo.day    + (adicionais[i].tempoDay    * qtd),
            //                                 saldo.hour   + (adicionais[i].tempoHour   * qtd),
            //                                 saldo.minute + (adicionais[i].tempoMinute * qtd),
            //                                 saldo.second + (adicionais[i].tempoSecond * qtd) );

            saldoSomandoAdicionalComTolerancia =
                DateTime(saldo.year   + (adicionais[i].tempoYear   * qtd),
                    saldo.month  + (adicionais[i].tempoMonth  * qtd),
                    saldo.day    + (adicionais[i].tempoDay    * qtd),
                    saldo.hour   + (adicionais[i].tempoHour   * qtd) + adicionais[i].toleranciaHour,
                    saldo.minute + (adicionais[i].tempoMinute * qtd) + adicionais[i].toleranciaMinute,
                    saldo.second + (adicionais[i].tempoSecond * qtd) + adicionais[i].toleranciaSecond);

            //print('qtd= $qtd' + ' saldoSomandoAdicionalComTolerancia=' + saldoSomandoAdicionalComTolerancia.toString());

            //if (saldoSomandoAdicional.isBefore(saida)) {
            if (saldoSomandoAdicionalComTolerancia.isBefore(saida)) {
              qtd++;
            } else {
              //if (saldoSomandoAdicional.isAfter(saida)) {
              //  qtd--;
              //}
              saldoSomandoAdicional = DateTime(saldo.year + (adicionais[i].tempoYear   * qtd),
                  saldo.month  + (adicionais[i].tempoMonth  * qtd),
                  saldo.day    + (adicionais[i].tempoDay    * qtd),
                  saldo.hour   + (adicionais[i].tempoHour   * qtd),
                  saldo.minute + (adicionais[i].tempoMinute * qtd),
                  saldo.second + (adicionais[i].tempoSecond * qtd) );
              break;
            }

            //} while ( saldoSomandoAdicional.isBefore(saida) );
          } while ( true );


          print('qtd final= $qtd');
          print('saldoSomandoAdicional = ' + saldoSomandoAdicional.toString());


          // Arredondamento para próximo adicinal. saldo.isBefore(saida) &&
          if ( adicionalProximo.precoAvulsoItemId > 0 ) {
            var saldoSomandoAdicionalComTolerancia = DateTime(saldoSomandoAdicional.year,
                saldoSomandoAdicional.month,
                saldoSomandoAdicional.day,
                saldoSomandoAdicional.hour   + adicionais[i].toleranciaHour,
                saldoSomandoAdicional.minute + adicionais[i].toleranciaMinute,
                saldoSomandoAdicional.second + adicionais[i].toleranciaSecond);

            if ( ((adicionais[i].preco * qtd) >= adicionalProximo.preco)
                ||
                ( i == 0
                    // (prévia do saldo depois de qtd) > $adicional['tolerancia_segundos']
                    //&& saldoSomandoAdicional > saldoSomandoAdicionalComTolerancia
                    // saldoSomandoAdicionalComTolerancia não seja >= saída
                    && saldoSomandoAdicionalComTolerancia.isBefore(saida)
                    && ((adicionais[i].preco * (qtd+1)) >= adicionalProximo.preco)
                )
            )   {

              //if ( isset($extratos[$adicional_proximo['preco_avulso_item_base_id']]) ) {
              //if ( extratos[adicionalProximo.precoAvulsoItemBaseId]. > 0 ) {}
              if ( extratos.containsKey(adicionalProximo.precoAvulsoItemBaseId) ) {
                //$extratos[$adicional_proximo['preco_avulso_item_base_id']]['quantidade']++;
                extratos[adicionalProximo.precoAvulsoItemBaseId].quantidade++;
              } else {
                e = Extrato();
                e.nome              = adicionalProximo.nome;
                e.quantidade        = 1;
                e.preco             = adicionalProximo.preco;
                e.tempo             = adicionalProximo.tempo;
                e.tempoYear         = adicionalProximo.tempoYear;
                e.tempoMonth        = adicionalProximo.tempoMonth;
                e.tempoDay          = adicionalProximo.tempoDay;
                e.tempoHour         = adicionalProximo.tempoHour;
                e.tempoMinute       = adicionalProximo.tempoMinute;
                e.tempoSecond       = adicionalProximo.tempoSecond;
                e.toleranciaHour    = adicionalProximo.toleranciaHour;
                e.toleranciaMinute  = adicionalProximo.toleranciaMinute;
                e.toleranciaSecond  = adicionalProximo.toleranciaSecond;
                extratos[adicionalProximo.precoAvulsoItemBaseId] = e;
              }
              //$saldo -= $adicional_proximo['tempo_segundos'];
              saldo =           DateTime(saldo.year   + adicionalProximo.tempoYear,
                  saldo.month  + adicionalProximo.tempoMonth,
                  saldo.day    + adicionalProximo.tempoDay,
                  saldo.hour   + adicionalProximo.tempoHour,
                  saldo.minute + adicionalProximo.tempoMinute,
                  saldo.second + adicionalProximo.tempoSecond   );
              valor += adicionalProximo.preco;

              print('Saldo depois do arredondamento próximo adicional=' + saldo.toString() + ' -----');

              break;

            }

          }

          e = Extrato();
          e.nome              = adicionais[i].nome;
          e.quantidade        = qtd;
          e.preco             = adicionais[i].preco;
          e.tempo             = adicionais[i].tempo;
          e.tempoYear         = adicionais[i].tempoYear;
          e.tempoMonth        = adicionais[i].tempoMonth;
          e.tempoDay          = adicionais[i].tempoDay;
          e.tempoHour         = adicionais[i].tempoHour;
          e.tempoMinute       = adicionais[i].tempoMinute;
          e.tempoSecond       = adicionais[i].tempoSecond;
          e.toleranciaHour    = adicionais[i].toleranciaHour;
          e.toleranciaMinute  = adicionais[i].toleranciaMinute;
          e.toleranciaSecond  = adicionais[i].toleranciaSecond;
          extratos[adicionais[i].precoAvulsoItemBaseId] = e;

          saldo =                   DateTime(saldo.year   + (adicionais[i].tempoYear * qtd),
              saldo.month  + (adicionais[i].tempoMonth * qtd),
              saldo.day    + (adicionais[i].tempoDay * qtd),
              saldo.hour   + (adicionais[i].tempoHour * qtd),
              saldo.minute + (adicionais[i].tempoMinute * qtd),
              saldo.second + (adicionais[i].tempoSecond * qtd)   );

          valor += adicionais[i].preco * qtd;

          saldoSomandoTolerancia =  DateTime(saldo.year,
              saldo.month,
              saldo.day,
              saldo.hour   + adicionais[i].toleranciaHour,
              saldo.minute + adicionais[i].toleranciaMinute,
              saldo.second + adicionais[i].toleranciaSecond   );

          print('Saldo após Arredondamento do Adicional: ' + saldo.toString());


          // Tolerância do adicional
          //if ( $saldo > 0 && $adicional['tolerancia_segundos'] && ($saldo - $adicional['tolerancia_segundos']) <= 0 ) {
          if ( saldo.isBefore(saida)
              && (adicionais[i].toleranciaHour   > 0 ||
                  adicionais[i].toleranciaMinute > 0 ||
                  adicionais[i].toleranciaSecond > 0)
              && !saida.isAfter(saldoSomandoTolerancia) )
          {
            e = Extrato();
            e.nome              = 'Tolerância do adiconal de ' + adicionais[i].tolerancia;
            e.quantidade        = 1;
            e.preco             = 0;
            e.tempo             = adicionais[i].tempo;
            e.tempoYear         = adicionais[i].tempoYear;
            e.tempoMonth        = adicionais[i].tempoMonth;
            e.tempoDay          = adicionais[i].tempoDay;
            e.tempoHour         = adicionais[i].tempoHour;
            e.tempoMinute       = adicionais[i].tempoMinute;
            e.tempoSecond       = adicionais[i].tempoSecond;
            e.toleranciaHour    = adicionais[i].toleranciaHour;
            e.toleranciaMinute  = adicionais[i].toleranciaMinute;
            e.toleranciaSecond  = adicionais[i].toleranciaSecond;
            extratos['ArredondamentoAdicional'] = e;

            //$saldo = 0;
            saldo = saida;

            break;
          }


        }

        adicionalProximo = adicionais[i];
      }


    } // /Adicionais


    // $saldo > 0 significa que não encontrou $adicional['tempo_segundos'] <= $saldo.
    // Ex.: No foreach acima o $saldo era de 45 minutos, e os adiconais são dia e hora. Dia e hora não são <= a 45 minutos.
    //      Então o último adicional, hora, é descontado. Ou seja, é descontado 1 hora do $saldo.
    if ( adicionais.length > 0 && saldo.isBefore(saida) ) {
      i = (i >= 0 ? i : 0);

      //if ( !isset($extratos[$adicional['preco_avulso_item_base_id']]) ) {
      if ( !(adicionais.length > i) || !extratos.containsKey(adicionais[i].precoAvulsoItemBaseId) ) {
        //if ( !adicionais[i].precoAvulsoItemBaseId || !extratos.containsKey(adicionais[i].precoAvulsoItemBaseId) ) {
        e = Extrato();
        e.nome              = adicionais[i].nome;
        e.quantidade        = 1;
        e.preco             = adicionais[i].preco;
        e.tempo             = adicionais[i].tempo;
        e.tempoYear         = adicionais[i].tempoYear;
        e.tempoMonth        = adicionais[i].tempoMonth;
        e.tempoDay          = adicionais[i].tempoDay;
        e.tempoHour         = adicionais[i].tempoHour;
        e.tempoMinute       = adicionais[i].tempoMinute;
        e.tempoSecond       = adicionais[i].tempoSecond;
        e.toleranciaHour    = adicionais[i].toleranciaHour;
        e.toleranciaMinute  = adicionais[i].toleranciaMinute;
        e.toleranciaSecond  = adicionais[i].toleranciaSecond;
        extratos[adicionais[i].precoAvulsoItemBaseId] = e;
      } else {
        extratos[adicionais[i].precoAvulsoItemBaseId].quantidade += 1;
      }
      saldo =                       DateTime(saldo.year   + adicionais[i].tempoYear,
          saldo.month  + adicionais[i].tempoMonth,
          saldo.day    + adicionais[i].tempoDay,
          saldo.hour   + adicionais[i].tempoHour,
          saldo.minute + adicionais[i].tempoMinute,
          saldo.second + adicionais[i].tempoSecond   );

      valor += adicionais[i].preco;
    }



    // Arredondamento para próxima faixa de preço.
    // Se $preco_proximo['preco'] é maior que o preço calculado até agora nesta faixa de preço mais os adicionais.
    // Então é cobrado apenas a próxima faixa de preço.
    //if ( isset($preco_proximo) && $valor > $preco_proximo['preco'] ) {
    if ( precoProximo.precoAvulsoItemId > 0 && valor > precoProximo.preco ) {
      arredondamento = precoProximo;
    }


    double total = 0;
    var saldoFinal = entrada;

    extratos.forEach((key, e) {
      total += e.quantidade * e.preco;
      saldoFinal = DateTime(saldoFinal.year   + (e.tempoYear   * e.quantidade),
        saldoFinal.month  + (e.tempoMonth  * e.quantidade),
        saldoFinal.day    + (e.tempoDay    * e.quantidade),
        saldoFinal.hour   + (e.tempoHour   * e.quantidade),
        saldoFinal.minute + (e.tempoMinute * e.quantidade),
        saldoFinal.second + (e.tempoSecond * e.quantidade),   );
    });


    if ( arredondamento.precoAvulsoItemId > 0 ) {
      //e = Extrato();
      //e.nome              = 'Sub-Total';
      //e.quantidade        = 0;
      //e.preco             = total;
      //e.tempo             = '';
      //extratos.add(e);
      //extratos['Sub-Total'] = e;
      total = arredondamento.preco;
      //e = Extrato();
      //e.nome              = 'Desconto por cobrar ' + arredondamento.nome + '!!! (' + valor.toString() + ' - ' + arredondamento.preco.toString() + ') =' ;
      //e.quantidade        = 0;
      //e.preco             = valor - arredondamento.preco;
      //e.tempo             = '';
      //extratos.add(e);
      //extratos['DescontoArredondamento'] = e;
      extratos = Map();
      e = Extrato();
      //e.nome              = arredondamento.nome + ' (1 X ' + arredondamento.preco.toString() + ')';
      e.nome              = arredondamento.nome;
      e.quantidade        = 1;
      e.preco             = arredondamento.preco;
      e.tempo             = '';
      extratos['Arredondamento'] = e;
      e = Extrato();
      e.nome              = 'Total';
      e.quantidade        = 0;
      e.preco             = total;
      e.tempo             = '';
      extratos['Total'] = e;
    } else {

      e = Extrato();
      e.nome              = 'Total';
      e.quantidade        = 0;
      e.preco             = total;
      e.tempo             = '';
      extratos['Total'] = e;

      if (saldo.isAfter(saida)) {
        e = Extrato();
        e.nome              = 'Mesmo preço até: ' ;
        e.quantidade        = 0;
        e.preco             = 0;
        e.tempo             = saldo;
        extratos['PodeFicarAte'] = e;
      }

    }
    print('Extrato____________________________');
    extratos.forEach((key, e) {
      if (e.quantidade > 0) {
        print(e.nome + ' (' + e.quantidade.toString() + ' X ' + e.preco.toString() + ') = ' + (e.quantidade * e.preco).toString());
      } else {
        if ( e.preco > 0 ) {
          print(e.nome + '  ' + e.preco.toString());
        } else {
          print(e.nome + saldo.toString());
        }
      }
      extratoList.add(e);
    });


    return extratoList;
  }
}
