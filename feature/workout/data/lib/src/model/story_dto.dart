class StoryDto {
  String id;
  String name;
  String story;
  String truthToRemember;
  String image;
  int estimatedReadingTime;

  static const String table_name = "story_dto";

  static const String field_id = "id";
  static const String field_name = "name";
  static const String field_story = "story";
  static const String field_truthToRemember = "truthToRemember";
  static const String field_image = "image";
  static const String field_estimatedReadingTime = "estimatedReadingTime";

  StoryDto.fromMap(jsonMap)
      : id = jsonMap["id"].toString(),
        name = jsonMap[field_name],
        story = jsonMap[field_story],
        truthToRemember = jsonMap[field_truthToRemember],
        estimatedReadingTime = jsonMap[field_estimatedReadingTime],
        image = jsonMap[field_image];

  Map<String, dynamic> toJson() => {
        field_id: id,
        field_name: name,
        field_story: story,
        field_truthToRemember: truthToRemember,
        field_image: image,
        field_estimatedReadingTime: estimatedReadingTime
      };

  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      story.hashCode ^
      truthToRemember.hashCode ^
      image.hashCode ^
      estimatedReadingTime.hashCode;

  @override
  bool operator ==(Object other) =>
      other is StoryDto &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      name == other.name &&
      story == other.story &&
      truthToRemember == other.truthToRemember &&
      image == other.image &&
      estimatedReadingTime == other.estimatedReadingTime;
}
