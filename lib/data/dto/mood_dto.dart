import 'package:flutter/material.dart';

class MoodDTO {
  final String feelingName;
  final String emoji;
  final String time;

  MoodDTO({
    @required this.feelingName,
    @required this.emoji,
    @required this.time
  });

  MoodDTO.fromJson(Map<String, dynamic> json) :
    feelingName = json["feelingName"],
    emoji = json["emoji"],
    time = json["time"];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodDTO &&
          runtimeType == other.runtimeType &&
          feelingName == other.feelingName &&
          emoji == other.emoji &&
          time == other.time;

  @override
  int get hashCode => feelingName.hashCode ^ emoji.hashCode ^ time.hashCode;
}