import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/moduleoff/park/park_off_join.dart';
import 'package:mobx/mobx.dart';

part 'signature_store.g.dart';

class SignatureStore = _SignatureStore with _$SignatureStore;

abstract class _SignatureStore with Store {
  ParkOffJoin parkOffJoinBase;

  ParkDao parkDao = ParkDao();

  @observable
  ObservableList<ParkOffJoin> listParkOffJoinBase =  ObservableList<ParkOffJoin>();

  @action
  getPricesItemInnerJoinBase(int id_user) async {
    await parkDao.findAllParksbyCart(id_user).then((List pricesItem) {
      pricesItem.forEach((element) {
        listParkOffJoinBase.add(element);
      });
    });
  }

  @action
  updatePriceItem(int index, int tickado) async {
    parkOffJoinBase = listParkOffJoinBase[index];
    listParkOffJoinBase.removeAt(index);
    parkOffJoinBase.tickado = tickado;
    listParkOffJoinBase.insert(index, parkOffJoinBase);
  }


}