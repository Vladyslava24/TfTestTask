class BreathingDto {
  String id;
  String video;
  bool done;

  BreathingDto();

  static const String table_name = "breathingDto";

  ///PRIMARY KEY
  static const String field_id = "id";
  static const String field_video = "video";
  static const String field_done = "done";

  BreathingDto.fromMap(jsonMap)
    : id = jsonMap['breathPracticeId'],
      video = jsonMap['video'],
      done = jsonMap['done'];

  Map<String, dynamic> toJson() => {
    field_id: id,
    field_video: video,
    field_done: done
  };

  int get hashCode =>
    id.hashCode ^
    video.hashCode ^
    done.hashCode;

  @override
  bool operator ==(Object other) =>
    other is BreathingDto &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      video == other.video &&
      done == other.done;
}
