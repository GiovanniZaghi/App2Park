// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PriceStore on _PriceStore, Store {
  final _$listPriceItemInnerJoinBaseAtom =
      Atom(name: '_PriceStore.listPriceItemInnerJoinBase');

  @override
  ObservableList<PriceItemInnerJoinBase> get listPriceItemInnerJoinBase {
    _$listPriceItemInnerJoinBaseAtom.reportRead();
    return super.listPriceItemInnerJoinBase;
  }

  @override
  set listPriceItemInnerJoinBase(ObservableList<PriceItemInnerJoinBase> value) {
    _$listPriceItemInnerJoinBaseAtom
        .reportWrite(value, super.listPriceItemInnerJoinBase, () {
      super.listPriceItemInnerJoinBase = value;
    });
  }

  final _$getPricesItemInnerJoinBaseAsyncAction =
      AsyncAction('_PriceStore.getPricesItemInnerJoinBase');

  @override
  Future getPricesItemInnerJoinBase([dynamic id = 0]) {
    return _$getPricesItemInnerJoinBaseAsyncAction
        .run(() => super.getPricesItemInnerJoinBase(id));
  }

  final _$updatePriceItemAsyncAction =
      AsyncAction('_PriceStore.updatePriceItem');

  @override
  Future updatePriceItem(int index, double price, String tolerance) {
    return _$updatePriceItemAsyncAction
        .run(() => super.updatePriceItem(index, price, tolerance));
  }

  @override
  String toString() {
    return '''
listPriceItemInnerJoinBase: ${listPriceItemInnerJoinBase}
    ''';
  }
}
