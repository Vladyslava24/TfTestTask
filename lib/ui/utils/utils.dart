import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';

Function deepEquals = const DeepCollectionEquality.unordered().equals;
Function deepHash = const DeepCollectionEquality.unordered().hash;

class UniqueColorGenerator {
  static Random random = new Random();

  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}
String correctDateTimeWithZero(int item) {
  return item < 10 ? '0$item' : '$item';
}

String correctMillisecondsWithZero(int item) {
  if (item < 10) return '00$item';
  return item < 100 ? '0$item' : '$item';
}

DateTime convertServerDateToCorrect(String date) {
  final reversedArrayTime = date.split('-').reversed.toList();
  final month = reversedArrayTime.last;
  final day = reversedArrayTime[reversedArrayTime.length - 2];
  reversedArrayTime[reversedArrayTime.length - 2] = month;
  reversedArrayTime.last = day;
  final reversedStringTime = reversedArrayTime.join('-');
  return DateTime.parse(reversedStringTime);
}