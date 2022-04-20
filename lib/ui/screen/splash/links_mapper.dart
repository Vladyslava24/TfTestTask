import 'package:totalfit/data/dto/response/parse_url_response.dart';
import 'package:totalfit/model/link/app_links.dart';
import 'package:totalfit/model/link/deep_link_type.dart';

class LinksMapper {
  Link mapLink(ParseUrlResponse response) {
    switch (response.type) {
      case DeepLinkType.RESET_PASSWORD: // Enter this block if mark == 0
        return ResetPasswordLink(userTokenUuid: response.payload.userTokenUuid);
      default:
        return EmptyLink();
    }
  }
}
