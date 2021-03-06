import 'package:flutter_test/flutter_test.dart';
import 'package:paragone/app/state.dart';
import 'package:paragone/app/reducer.dart';
import 'package:paragone/menu_list/menu_list_actions.dart';
import 'package:paragone/menu_list/model/menu_item.dart';
import 'package:paragone/menu_list/model/menu_list_middleware.dart';
import 'package:paragone/menu_list/model/menu_list_repository.dart';
import 'package:redux/redux.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks_menu_list.dart';

void main() {

  Store<AppState> store;
  MenuListRepository repository;

  setUp(() {
    repository = MockMenuListRepository();
    store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: [MenuListMiddleware(repository)],
    );
  });

  group('Menu List Middleware', () {
    test('should load menu items in response to a FetchMenuAction', () {
      final menuItems = [MenuItem('test')];
      when(repository.fetchMenuItems()).thenReturn(Future.value(menuItems));

      store.dispatch(FetchMenuAction());

      verify(repository.fetchMenuItems());
    });
  });
}
