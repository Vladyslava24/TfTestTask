class WorkoutEntryDto {
  String id;
  String image;
  String theme;
  String wodType;
  String skillImage;
  String difficultyLevel;
  int estimatedTime;
  List<String> equipment;

  WorkoutEntryDto();

  WorkoutEntryDto.fromMap(jsonMap)
      : id = jsonMap["id"],
        image = jsonMap["image"],
        theme = jsonMap["theme"],
        wodType = jsonMap["wodType"],
        skillImage = jsonMap["skillImage"],
        estimatedTime = jsonMap["estimatedTime"],
        equipment = (jsonMap["equipment"] as List).map((e) => e as String).toList(),
        difficultyLevel = jsonMap["difficultyLevel"];

  int get hashCode => id.hashCode ^ image.hashCode ^ theme.hashCode ^ wodType.hashCode ^ difficultyLevel.hashCode;

  @override
  bool operator ==(Object other) =>
      other is WorkoutEntryDto &&
      id == other.id &&
      image == other.image &&
      theme == other.theme &&
      wodType == other.wodType &&
      difficultyLevel == other.difficultyLevel;
}
