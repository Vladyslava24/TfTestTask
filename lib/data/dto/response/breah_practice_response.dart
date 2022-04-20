import 'package:flutter/material.dart';

class BreathPracticeResponse {
  BreathPracticeResponse({
    this.breathPracticeId,
    this.video,
    this.done,
  });

  String breathPracticeId;
  String video;
  bool done;

  factory BreathPracticeResponse.fromJson(Map<String, dynamic> json) => BreathPracticeResponse(
    breathPracticeId: json["breathPracticeId"],
    video: json["video"],
    done: json["done"],
  );

  Map<String, dynamic> toJson() => {
    "breathPracticeId": breathPracticeId,
    "video": video,
    "done": done,
  };
}