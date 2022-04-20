import 'package:mood_usecase/model/feeling_item.dart';

class FeelingGroup {
  final int id;
  final String name;
  final String color;
  final String image;
  final List<FeelingItem> feelings;

  const FeelingGroup({
    required this.id,
    required this.name,
    required this.color,
    required this.image,
    required this.feelings
  });
}