import 'package:json_annotation/json_annotation.dart';
import 'package:mood_data/src/model/response/feeling_item_response.dart';

part 'feeling_group_response.g.dart';

@JsonSerializable(createToJson: false)
class FeelingGroupResponse {
  final String id;
  final String name;
  final String colour;
  final String image;
  final List<FeelingItemResponse> feelings;

  const FeelingGroupResponse({
    required this.id,
    required this.name,
    required this.colour,
    required this.image,
    required this.feelings
  });

  factory FeelingGroupResponse.fromJson(Map<String, dynamic> json) =>
    _$FeelingGroupResponseFromJson(json);
}