class WisdomDto {
  String name;
  String id;
  String text;
  String image;
  int estimatedReadingTime;

  WisdomDto();

  static const String table_name = "wisdomDto";

  ///PRIMARY KEY
  static const String field_name = "name";
  static const String field_id = "id";
  static const String field_text = "text";
  static const String field_image = "image";
  static const String field_estimated_reading_time = "estimatedReadingTime";

  WisdomDto.fromMap(jsonMap)
      : name = jsonMap[field_name],
        image = jsonMap[field_image],
        id = jsonMap[field_id],
        text = jsonMap[field_text],
        estimatedReadingTime = jsonMap[field_estimated_reading_time];

  Map<String, dynamic> toJson() => {
        field_name: name,
        field_text: text,
        field_image: image,
        field_estimated_reading_time: estimatedReadingTime
      };

  int get hashCode =>
      name.hashCode ^
      image.hashCode ^
      estimatedReadingTime.hashCode ^
      text.hashCode;

  @override
  bool operator ==(Object other) =>
      other is WisdomDto &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      text == other.text &&
      image == other.image &&
      estimatedReadingTime == other.estimatedReadingTime;
}
