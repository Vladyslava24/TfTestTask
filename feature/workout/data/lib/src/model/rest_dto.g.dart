// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestDto _$RestDtoFromJson(Map<String, dynamic> json) => RestDto(
      order: json['order'] as int,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$RestDtoToJson(RestDto instance) => <String, dynamic>{
      'order': instance.order,
      'quantity': instance.quantity,
    };
