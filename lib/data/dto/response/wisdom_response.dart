import 'package:totalfit/data/dto/wisdom_dto.dart';

class WisdomResponse {
  int pagesCount;
  String totalElements;
  List<WisdomDto> wisdomList;

  WisdomResponse.fromMap(jsonMap)
      : pagesCount = jsonMap["pagesCount"],
        totalElements = jsonMap["totalElements"],
        wisdomList = (jsonMap["objects"] as List)
            .map((e) => WisdomDto.fromMap(e))
            .toList();
}
