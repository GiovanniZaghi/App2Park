import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/moduleoff/park_service_inner_join_service_additional_model.dart';
import 'package:mobx/mobx.dart';

part 'service_additional_store.g.dart';

class ServiceAdditionalStore = _ServiceAdditionalStore with _$ServiceAdditionalStore;

abstract class _ServiceAdditionalStore with Store {

  ParkServiceInnerJoinServiceAdditionalModel parkServiceInnerJoinServiceAdditionalModel;

  ParkServiceAdditionalDao parkServiceAdditionalDao = ParkServiceAdditionalDao();

  @observable
  ObservableList<ParkServiceInnerJoinServiceAdditionalModel> parkServiceInnerJoinServiceAdditionalList =  ObservableList<ParkServiceInnerJoinServiceAdditionalModel>();


  @action
  getparkServiceInnerJoinServiceAdditional([id = 0]) async {
    await parkServiceAdditionalDao.getParkServicesJoin(id).then((List servicesItems) {
      servicesItems.forEach((element) {
        parkServiceInnerJoinServiceAdditionalList.add(element);
      });
    });
  }

  @action
  updateparkServiceInnerJoinServiceAdditional(int index, double price, String tolerance, String observation, String jusfication) async {
    parkServiceInnerJoinServiceAdditionalModel = parkServiceInnerJoinServiceAdditionalList[index];
    parkServiceInnerJoinServiceAdditionalList.removeAt(index);
    parkServiceInnerJoinServiceAdditionalModel.price = price;
    parkServiceInnerJoinServiceAdditionalModel.tolerance = tolerance;
    parkServiceInnerJoinServiceAdditionalList.insert(index, parkServiceInnerJoinServiceAdditionalModel);
  }
}