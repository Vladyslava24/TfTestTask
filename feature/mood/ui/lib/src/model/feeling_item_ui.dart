class FeelingItemUI {
  final int id;
  final String name;
  final String emoji;
  bool selected;

  FeelingItemUI({
    required this.id,
    required this.name,
    required this.emoji,
    this.selected = false
  });
}
