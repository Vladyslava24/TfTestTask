import 'package:totalfit/model/link/deep_link_type.dart';

class ParseUrlResponse {
  DeepLinkType type;
  Payload payload;

  ParseUrlResponse.fromMap(jsonMap)
      : type = DeepLinkType.fromMap(jsonMap["linkType"]),
        payload = Payload.fromMap(jsonMap["payload"]);
}

class Payload {
  String userTokenUuid;

  Payload.fromMap(jsonMap) : userTokenUuid = jsonMap["userTokenUuid"];
}
