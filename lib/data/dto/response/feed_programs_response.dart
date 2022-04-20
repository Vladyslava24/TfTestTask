
import 'feed_program_list_item_response.dart';

class FeedProgramsResponse {
  final List<FeedProgramItemResponse> objects;
  final int pagesCount;
  final String totalElements;

  FeedProgramsResponse({
    this.objects,
    this.pagesCount,
    this.totalElements,
  });

  FeedProgramsResponse.fromJson(json)
      : objects = (json["objects"] as List).map((e) => FeedProgramItemResponse.fromJson(e)).toList(),
        pagesCount = json["pagesCount"],
        totalElements = json["totalElements"];
}