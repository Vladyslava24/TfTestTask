class Environmental {
  Environmental({
    this.environmentalRecord,
    this.widgetConfig,
  });

  EnvironmentalRecordDto? environmentalRecord;
  WidgetConfig? widgetConfig;

  factory Environmental.fromJson(Map<String, dynamic> json) => Environmental(
        environmentalRecord:
            EnvironmentalRecordDto.fromMap(json["environmentalRecord"]),
        widgetConfig: WidgetConfig.fromJson(json["widgetConfig"]),
      );

  Map<String, dynamic> toJson() => {
        "environmentalRecord": environmentalRecord,
        "widgetConfig": widgetConfig!.toJson(),
      };
}

class WidgetConfig {
  WidgetConfig({
    this.minValue,
    this.maxValue,
    this.step,
    this.minValueTitle,
    this.maxValueTitle,
    this.collapsedStateImage,
    this.expandedStateImage,
  });

  int? minValue;
  int? maxValue;
  int? step;
  String? minValueTitle;
  String? maxValueTitle;
  String? collapsedStateImage;
  String? expandedStateImage;

  factory WidgetConfig.fromJson(Map<String, dynamic> json) => WidgetConfig(
        minValue: json["minValue"],
        maxValue: json["maxValue"],
        step: json["step"],
        minValueTitle: json["minValueTitle"],
        maxValueTitle: json["maxValueTitle"],
        collapsedStateImage: json["collapsedStateImage"],
        expandedStateImage: json["expandedStateImage"],
      );

  Map<String, dynamic> toJson() => {
        "minValue": minValue,
        "maxValue": maxValue,
        "step": step,
        "minValueTitle": minValueTitle,
        "maxValueTitle": maxValueTitle,
        "collapsedStateImage": collapsedStateImage,
        "expandedStateImage": expandedStateImage,
      };
}

// class EnvironmentDto {
//   EnvironmentalRecordDto? environmentalRecord;
//   String? collapsedStateImage;
//   String? expandedStateImage;
//   int? maxValue;
//   int? minValue;
//   int? step;
//   String? minValueTitle;
//   String? maxValueTitle;
//
//
//   EnvironmentDto(
//       this.environmentalRecord,
//       this.collapsedStateImage,
//       this.expandedStateImage,
//       this.maxValue,
//       this.minValue,
//       this.step,
//       this.minValueTitle,
//       this.maxValueTitle);
//
//   static const String _field_widget_config = "widgetConfig";
//   static const String _field_environmental_record = "environmentalRecord";
//   static const String _field_collapsed_state_image = "collapsedStateImage";
//   static const String _field_expanded_state_image = "expandedStateImage";
//   static const String _field_max_value = "maxValue";
//   static const String _field_max_value_title = "maxValueTitle";
//   static const String _field_min_value_title = "minValueTitle";
//   static const String _field_min_value = "minValue";
//   static const String _field_step = "step";
//
//   EnvironmentDto.fromMap(jsonMap) {
//     var eRecord = jsonMap[_field_environmental_record];
//     if (eRecord != null) {
//       environmentalRecord = EnvironmentalRecordDto.fromMap(eRecord);
//     }
//
//     var widgetConfig = jsonMap[_field_widget_config];
//     if (widgetConfig != null) {
//       collapsedStateImage = widgetConfig[_field_collapsed_state_image];
//       expandedStateImage = widgetConfig[_field_expanded_state_image];
//       maxValueTitle = widgetConfig[_field_max_value_title];
//       minValueTitle = widgetConfig[_field_min_value_title];
//       maxValue = widgetConfig[_field_max_value];
//       minValue = widgetConfig[_field_min_value];
//       step = widgetConfig[_field_step];
//     }
//   }
//
//   int get hashCode =>
//       environmentalRecord.hashCode ^
//       expandedStateImage.hashCode ^
//       maxValueTitle.hashCode ^
//       minValueTitle.hashCode ^
//       maxValue.hashCode ^
//       minValue.hashCode ^
//       step.hashCode ^
//       collapsedStateImage.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       other is EnvironmentDto &&
//           runtimeType == other.runtimeType &&
//           environmentalRecord == other.environmentalRecord &&
//           maxValueTitle == other.maxValueTitle &&
//           minValueTitle == other.minValueTitle &&
//           maxValue == other.maxValue &&
//           minValue == other.minValue &&
//           step == other.step &&
//           collapsedStateImage == other.collapsedStateImage &&
//           expandedStateImage == other.expandedStateImage;
// }
//
class EnvironmentalRecordDto {
  String? createdAt;
  int? duration;
  String? id;

  EnvironmentalRecordDto({this.createdAt, this.duration, this.id});

  static const String _field_created_at = "createdAt";
  static const String _field_duration = "duration";
  static const String _field_id = "id";

  EnvironmentalRecordDto.fromMap(jsonMap) {
    createdAt = jsonMap[_field_created_at];
    duration = jsonMap[_field_duration];
    id = jsonMap[_field_id];
  }

  Map<String, dynamic> toJson() => {
        _field_created_at: createdAt,
        _field_duration: duration?.toString(),
        _field_id: id,
      };

  int get hashCode => createdAt.hashCode ^ duration.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      other is EnvironmentalRecordDto &&
      runtimeType == other.runtimeType &&
      createdAt == other.createdAt &&
      duration == other.duration &&
      id == other.id;
}
