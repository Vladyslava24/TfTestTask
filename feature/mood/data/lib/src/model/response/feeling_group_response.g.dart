// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeling_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeelingGroupResponse _$FeelingGroupResponseFromJson(
        Map<String, dynamic> json) =>
    FeelingGroupResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      colour: json['colour'] as String,
      image: json['image'] as String,
      feelings: (json['feelings'] as List<dynamic>)
          .map((e) => FeelingItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
