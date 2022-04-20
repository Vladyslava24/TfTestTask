import 'package:flutter/cupertino.dart';
import 'package:totalfit/data/dto/mood_dto.dart';

class MoodTrackingProgressResponse {
  final int pagesCount;
  final String totalElements;
  final List<MoodDTO> objects;

  MoodTrackingProgressResponse({
    @required this.pagesCount,
    @required this.totalElements,
    @required this.objects
  });

  MoodTrackingProgressResponse.fromJson(Map<String, dynamic> jsonMap) :
    objects = (jsonMap['objects'] as List).map((e) =>
      MoodDTO.fromJson(e)).toList(),
    pagesCount = jsonMap['pagesCount'],
    totalElements = jsonMap["totalElements"];
}