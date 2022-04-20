import 'package:flutter/cupertino.dart';
import 'package:totalfit/data/dto/wisdom_dto.dart';

class WisdomModel {
  String id;
  String name;
  String text;
  String image;
  int estimatedReadingTime;
  bool isRead;

  WisdomModel({
    @required this.id,
    @required this.name,
    @required this.text,
    @required this.image,
    @required this.estimatedReadingTime,
    @required this.isRead,
  });

  factory WisdomModel.fromDto(WisdomDto dto, bool isRead) {
    final id = dto.id;
    final name = dto.name;
    final text = dto.text;
    final image = dto.image;
    final estimatedReadingTime = dto.estimatedReadingTime;
    return WisdomModel(
        id: id, name: name, text: text, image: image, isRead: isRead, estimatedReadingTime: estimatedReadingTime);
  }

  WisdomModel copyWith({
    String id,
    String name,
    String text,
    String image,
    int estimatedReadingTime,
    bool isRead,
  }) {
    return WisdomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      text: text ?? this.text,
      image: image ?? this.image,
      estimatedReadingTime: estimatedReadingTime ?? this.estimatedReadingTime,
      isRead: isRead ?? this.isRead,
    );
  }

  int get hashCode =>
      id.hashCode ^ name.hashCode ^ text.hashCode ^ isRead.hashCode ^ image.hashCode ^ estimatedReadingTime.hashCode;

  @override
  bool operator ==(Object other) =>
      other is WisdomModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      name == other.name &&
      text == other.text &&
      image == other.image &&
      estimatedReadingTime == other.estimatedReadingTime &&
      isRead == other.isRead;
}
