// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodDataResponse _$MoodDataResponseFromJson(Map<String, dynamic> json) =>
    MoodDataResponse(
      feelingsGroups: (json['feelingsGroups'] as List<dynamic>)
          .map((e) => FeelingGroupResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      reasons: (json['reasons'] as List<dynamic>)
          .map((e) => FeelingItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
