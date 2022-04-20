import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/breathing_dto.dart';

class BreathingModel extends Equatable {
  final String id;
  final String video;
  final bool done;

  const BreathingModel({
    @required this.id,
    @required this.video,
    @required this.done
  });

  BreathingModel copyWith({
    String  id,
    String video,
    bool done
  }) => BreathingModel(
    id: id ?? this.id,
    video: video ?? this.video,
    done: done ?? this.done
  );

  factory BreathingModel.fromDto(BreathingDto dto) {
    final id = dto?.id;
    final video = dto?.video;
    final done = dto?.done;
    return BreathingModel(id: id, video: video, done: done);
  }

  @override
  List<Object> get props => [id, video, done];
}