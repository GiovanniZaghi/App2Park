// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_additional_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceAdditionalStore on _ServiceAdditionalStore, Store {
  final _$parkServiceInnerJoinServiceAdditionalListAtom = Atom(
      name:
          '_ServiceAdditionalStore.parkServiceInnerJoinServiceAdditionalList');

  @override
  ObservableList<ParkServiceInnerJoinServiceAdditionalModel>
      get parkServiceInnerJoinServiceAdditionalList {
    _$parkServiceInnerJoinServiceAdditionalListAtom.reportRead();
    return super.parkServiceInnerJoinServiceAdditionalList;
  }

  @override
  set parkServiceInnerJoinServiceAdditionalList(
      ObservableList<ParkServiceInnerJoinServiceAdditionalModel> value) {
    _$parkServiceInnerJoinServiceAdditionalListAtom.reportWrite(
        value, super.parkServiceInnerJoinServiceAdditionalList, () {
      super.parkServiceInnerJoinServiceAdditionalList = value;
    });
  }

  final _$getparkServiceInnerJoinServiceAdditionalAsyncAction = AsyncAction(
      '_ServiceAdditionalStore.getparkServiceInnerJoinServiceAdditional');

  @override
  Future getparkServiceInnerJoinServiceAdditional([dynamic id = 0]) {
    return _$getparkServiceInnerJoinServiceAdditionalAsyncAction
        .run(() => super.getparkServiceInnerJoinServiceAdditional(id));
  }

  final _$updateparkServiceInnerJoinServiceAdditionalAsyncAction = AsyncAction(
      '_ServiceAdditionalStore.updateparkServiceInnerJoinServiceAdditional');

  @override
  Future updateparkServiceInnerJoinServiceAdditional(int index, double price,
      String tolerance, String observation, String jusfication) {
    return _$updateparkServiceInnerJoinServiceAdditionalAsyncAction.run(() =>
        super.updateparkServiceInnerJoinServiceAdditional(
            index, price, tolerance, observation, jusfication));
  }

  @override
  String toString() {
    return '''
parkServiceInnerJoinServiceAdditionalList: ${parkServiceInnerJoinServiceAdditionalList}
    ''';
  }
}
