// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutApiResponse _$WorkoutApiResponseFromJson(Map<String, dynamic> json) =>
    WorkoutApiResponse(
      pagesCount: json['pagesCount'] as int,
      totalElements: json['totalElements'] as String,
      workouts: (json['objects'] as List<dynamic>)
          .map((e) => WorkoutDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
