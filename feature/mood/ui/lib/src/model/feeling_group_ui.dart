import 'package:mood_ui/src/model/feeling_item_ui.dart';

class FeelingGroupUI {
  final int id;
  final String name;
  final String color;
  final String image;
  final List<FeelingItemUI> feelings;

  const FeelingGroupUI({
    required this.id,
    required this.name,
    required this.color,
    required this.image,
    required this.feelings
  });
}