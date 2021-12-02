import 'package:app2park/db/dao/payment/price_detached_item_dao.dart';
import 'package:app2park/moduleoff/payment/price_item_inner_join_item_base.dart';
import 'package:mobx/mobx.dart';

part 'price_store.g.dart';

class PriceStore = _PriceStore with _$PriceStore;

abstract class _PriceStore with Store {
  PriceItemInnerJoinBase priceItemInnerJoinBase;

  PriceDetachedItemDao priceDetachedItemDao = PriceDetachedItemDao();

  @observable
  ObservableList<PriceItemInnerJoinBase> listPriceItemInnerJoinBase =  ObservableList<PriceItemInnerJoinBase>();

  @action
  getPricesItemInnerJoinBase([id = 0]) async {
    await priceDetachedItemDao.getPriceInnerJoin(id).then((List pricesItem) {
      pricesItem.forEach((element) {
        listPriceItemInnerJoinBase.add(element);
      });
    });
  }

  @action
  updatePriceItem(int index, double price, String tolerance) async {
    priceItemInnerJoinBase = listPriceItemInnerJoinBase[index];
    listPriceItemInnerJoinBase.removeAt(index);
    priceItemInnerJoinBase.price = price;
    priceItemInnerJoinBase.tolerance = tolerance;
    listPriceItemInnerJoinBase.insert(index, priceItemInnerJoinBase);
  }


}