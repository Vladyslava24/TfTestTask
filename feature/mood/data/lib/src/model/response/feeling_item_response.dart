import 'package:json_annotation/json_annotation.dart';

part 'feeling_item_response.g.dart';

@JsonSerializable(createToJson: false)
class FeelingItemResponse {
  final String id;
  final String name;
  final String emoji;

  const FeelingItemResponse({
    required this.id,
    required this.name,
    required this.emoji
  });

  factory FeelingItemResponse.fromJson(Map<String, dynamic> json) =>
    _$FeelingItemResponseFromJson(json);
}