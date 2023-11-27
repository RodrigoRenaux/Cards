import 'package:mobx/mobx.dart';
import 'package:target_cards/values/helpers/shared_preferencers_manager.dart';

part 'cards.g.dart';

class Cards = _Cards with _$Cards;

abstract class _Cards with Store {
  final SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager();

  String defaultText = "Digite no campo abaixo para atualizar o card";

  @observable
  ObservableList<String> items = ObservableList.of([]);

  @action
  Future<void> initialize() async {
    await sharedPreferencesManager.initializeSharedPreferences();
    var result = sharedPreferencesManager.prefs.getStringList('cards') ?? [];
    print("lista salva: $result");

    //lista inicial apresentada para o usuario
    result.add(defaultText);
    items = ObservableList.of(result);
  }

  @action
  void add(String value) {
    //atribuicao
    var result = items;

    //ultimo elemento - texto padrao - é atualizado
    result[items.length - 1] = value;

    //salva no cache
    sharedPreferencesManager.updateCache('cards', result);

    //lista final apresentada para o usuario
    result.add(defaultText);
    items = result;
  }

  @action
  void update(int index, String newValue) {
    //atribuicao
    var result = items;

    //atualiza
    result[index] = newValue;

    //remover texto padrao - salva no cache apenas o que foi digitado pelo usuario
    result.removeLast();

    //salva no cache
    sharedPreferencesManager.updateCache('cards', result);

    //lista final apresentada para o usuario
    result.add(defaultText);
    items = ObservableList.of(result);  }

  @action
  void remove(int index) {
    //atribuicao
    var result = items;

    //remove
    result.removeAt(index);

    //remover texto padrao - salva no cache apenas o que foi digitado pelo usuario
    result.removeLast();

    //salva no cache
    sharedPreferencesManager.updateCache('cards', result);


    //lista final apresentada para o usuario
    result.add(defaultText);
    items = ObservableList.of(result);
  }
}
