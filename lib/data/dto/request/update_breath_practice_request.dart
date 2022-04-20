import 'package:flutter/material.dart';

class UpdateBreathPracticeRequest {
  final String breathPracticeId;
  final String date;
  final String createdAt;

  const UpdateBreathPracticeRequest({
    @required this.breathPracticeId,
    @required this.date,
    @required this.createdAt
  });
}