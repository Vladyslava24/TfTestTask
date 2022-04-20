import 'package:flutter/cupertino.dart';
import 'package:totalfit/model/statement.dart';
import 'package:totalfit/data/dto/story_dto.dart';
import 'package:totalfit/ui/utils/utils.dart';

class StoryModel {
  final String id;
  final bool isRead;
  final String name;
  final String story;
  final String image;
  final int estimatedReadingTime;
  List<Statement> statements;

  StoryModel(
      {@required this.id,
      @required this.isRead,
      @required this.name,
      @required this.story,
      @required this.image,
      @required this.estimatedReadingTime,
      @required this.statements});

  factory StoryModel.fromDto(StoryDto dto, bool isRead, List<Statement> statements) {
    final storyId = dto.id;
    final name = dto.name;
    final story = dto.story;
    final image = dto.image;
    final estimatedReadingTime = dto.estimatedReadingTime;

    return StoryModel(
        id: storyId,
        story: story,
        isRead: isRead,
        name: name,
        image: image,
        statements: statements,
        estimatedReadingTime: estimatedReadingTime);
  }

  factory StoryModel.fromDtoNotToday(List<Statement> statements) {

    return StoryModel(
      id: null,
      story: null,
      isRead: false,
      name: null,
      image: null,
      statements: statements,
      estimatedReadingTime: null
    );
  }

  StoryModel copyWith({
    String id,
    bool isRead,
    String name,
    String story,
    String image,
    int estimatedReadingTime,
    List<Statement> statements,
  }) {
    return StoryModel(
      id: id ?? this.id,
      isRead: isRead ?? this.isRead,
      name: name ?? this.name,
      story: story ?? this.story,
      image: image ?? this.image,
      estimatedReadingTime: estimatedReadingTime ?? this.estimatedReadingTime,
      statements: statements ?? this.statements,
    );
  }

 // int get hashCode => id.hashCode ^ isRead.hashCode ^ deepHash(statements);
  int get hashCode => id.hashCode ^ isRead.hashCode;

  @override
  bool operator ==(Object other) =>
      other is StoryModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      deepEquals(statements, other.statements) &&
      isRead == other.isRead;
}
