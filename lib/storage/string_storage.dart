import 'package:core/generated/l10n.dart';
import 'package:totalfit/ui/widgets/keys.dart';

class StringStorage {
  const StringStorage();

  // Do to call in init state method
  S of() {
    return S.of(Keys.navigatorKey.currentContext);
  }
}
