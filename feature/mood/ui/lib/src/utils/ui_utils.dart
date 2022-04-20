//HEX color converter
int convertColor(String? color) {
  if (color == null) {
    return int.parse('0XFFFFFFFF');
  }
  final cleanColor = color.replaceAll('#', '');
  return int.parse('0XFF$cleanColor');
}

//Emoji to unicode converter
String getEmoji(String emoji) =>
  String.fromCharCode(int.parse(emoji, radix: 16));
