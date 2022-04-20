import 'package:totalfit/data/dto/story_dto.dart';

class StoryResponse {
  int pagesCount;
  String totalElements;
  List<StoryDto> storyList;

  StoryResponse.fromMap(jsonMap)
      : pagesCount = jsonMap["pagesCount"],
        totalElements = jsonMap["totalElements"],
        storyList = (jsonMap["objects"] as List)
            .map((e) => StoryDto.fromMap(e))
            .toList();
}