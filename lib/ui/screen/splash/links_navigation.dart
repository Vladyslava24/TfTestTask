import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/model/link/app_links.dart';

class LinksNavigator {

  void navigate(Link link, Store<AppState> store) {
    switch (link.runtimeType) {
      case ResetPasswordLink:
        store.dispatch(NavigateToResetPasswordAction(deepLink: link));
        break;
      default :
        store.dispatch(NavigateToMainScreenAction());
        break;
    }
  }
}
