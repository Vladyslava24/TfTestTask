import 'package:flutter/cupertino.dart';

import '../data/dto/enviromental_dto.dart';

class EnvironmentModel {
  EnvironmentalRecordDto environmentalRecord;

  String collapsedStateImage;
  String expandedStateImage;
  int maxValue;
  int minValue;
  int step;
  String minValueTitle;
  String maxValueTitle;
  final bool isEnable;

  EnvironmentModel({
    @required this.environmentalRecord,
    @required this.collapsedStateImage,
    @required this.expandedStateImage,
    @required this.maxValue,
    @required this.minValue,
    @required this.step,
    @required this.minValueTitle,
    @required this.maxValueTitle,
    @required this.isEnable,
  });

  bool isDone() {
    return environmentalRecord != null;
  }

  bool isDisabled() {
    return environmentalRecord != null || !isEnable;
  }

  factory EnvironmentModel.fromDto(EnvironmentDto dto, bool isEnable) {
    return EnvironmentModel(
      environmentalRecord: dto.environmentalRecord,
      collapsedStateImage: dto.collapsedStateImage,
      expandedStateImage: dto.expandedStateImage,
      maxValue: dto.maxValue,
      minValue: dto.minValue,
      step: dto.step,
      minValueTitle: dto.minValueTitle,
      maxValueTitle: dto.maxValueTitle,
      isEnable: isEnable,
    );
  }

  EnvironmentModel copyWith({
    EnvironmentalRecordDto environmentalRecord,
    String collapsedStateImage,
    String expandedStateImage,
    int maxValue,
    int minValue,
    int step,
    int minValueTitle,
    int maxValueTitle,
    bool isEnable,
  }) {
    return EnvironmentModel(
      environmentalRecord: environmentalRecord ?? this.environmentalRecord,
      collapsedStateImage: collapsedStateImage ?? this.collapsedStateImage,
      expandedStateImage: expandedStateImage ?? this.expandedStateImage,
      maxValue: maxValue ?? this.maxValue,
      minValue: minValue ?? this.minValue,
      step: step ?? this.step,
      minValueTitle: minValueTitle ?? this.minValueTitle,
      maxValueTitle: maxValueTitle ?? this.maxValueTitle,
      isEnable: isEnable ?? this.isEnable,
    );
  }

  int get hashCode =>
      environmentalRecord.hashCode ^
      expandedStateImage.hashCode ^
      maxValueTitle.hashCode ^
      minValueTitle.hashCode ^
      maxValue.hashCode ^
      minValue.hashCode ^
      step.hashCode ^
      isEnable.hashCode ^
      collapsedStateImage.hashCode;

  @override
  bool operator ==(Object other) =>
      other is EnvironmentModel &&
      runtimeType == other.runtimeType &&
      environmentalRecord == other.environmentalRecord &&
      maxValueTitle == other.maxValueTitle &&
      minValueTitle == other.minValueTitle &&
      maxValue == other.maxValue &&
      minValue == other.minValue &&
      step == other.step &&
      collapsedStateImage == other.collapsedStateImage &&
      isEnable == other.isEnable &&
      expandedStateImage == other.expandedStateImage;
}
