// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Cards on _Cards, Store {
  late final _$itemsAtom = Atom(name: '_Cards.items', context: context);

  @override
  ObservableList<String> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<String> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('_Cards.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$_CardsActionController =
      ActionController(name: '_Cards', context: context);

  @override
  void add(String value) {
    final _$actionInfo =
        _$_CardsActionController.startAction(name: '_Cards.add');
    try {
      return super.add(value);
    } finally {
      _$_CardsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(int index, String newValue) {
    final _$actionInfo =
        _$_CardsActionController.startAction(name: '_Cards.update');
    try {
      return super.update(index, newValue);
    } finally {
      _$_CardsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(int index) {
    final _$actionInfo =
        _$_CardsActionController.startAction(name: '_Cards.remove');
    try {
      return super.remove(index);
    } finally {
      _$_CardsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items}
    ''';
  }
}
