import 'package:intl/intl.dart';

const DAY_IN_MILLIS = 1000 * 60 * 60 * 24;

const String SERVER_DATE_FORMAT = 'yyyy-MM-dd';

String formattedDateTime(DateTime dateTime) {
  String formattedDate = DateFormat(SERVER_DATE_FORMAT).format(dateTime);
  return formattedDate;
}

String unifiedUiDateFormat(DateTime dateTime) {
  final formattedDate = DateFormat('MM-dd-yyyy').format(dateTime);
  return formattedDate;
}

String twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}

String timeFromDuration(Duration duration) {
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  return "$twoDigitMinutes:$twoDigitSeconds";
}

String timeFromMilliseconds(int millis) {
  final duration = Duration(milliseconds: millis);
  return timeFromDuration(duration);
}

bool isToday(String date) {
  return date == today();
}

bool isTodayDate(int date) {
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dateTime);
  return formatted == today();
}

String today() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  return formatted;
}

DateTime todayDateTime() {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  return date;
}

bool isTodayOrAfter(DateTime dt) {
  DateTime comparable = new DateTime(dt.year, dt.month, dt.day);

  DateTime now = new DateTime.now();
  DateTime today = new DateTime(now.year, now.month, now.day);
  return comparable == today || comparable.isAfter(today);
}

bool beforeToday(DateTime dt) {
  DateTime comparable = DateTime(dt.year, dt.month, dt.day);

  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  return comparable.isBefore(today);
}

String specificDate({required int year, required int month, required int day}) {
  final DateTime now = DateTime(year, month, day, 0, 0);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  return formatted;
}

String getDayFromMillis(int date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted =
      formatter.format(DateTime.fromMillisecondsSinceEpoch(date));
  return formatted;
}

bool isOneMonthAgo(String formattedDate) {
  var diff = DateTime.now().difference(DateTime.parse(formattedDate));
  return diff.inDays > 30;
}

String workoutTitleFormatted(int date) {
  final DateFormat formatter = DateFormat('dd MMMM');
  final String formatted =
      formatter.format(DateTime.fromMillisecondsSinceEpoch(date));
  return formatted;
}

String formatDateTime(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date);
  return formatted;
}

String dayMonthFormat(DateTime date) {
  final DateFormat formatter = DateFormat('MMM d');
  final String formatted = formatter.format(date);
  return formatted;
}

String toServerDateFormat(String date) {
  date = ensureValidFormat(date);
  final dt = DateTime.parse(date);
  String formattedDate = DateFormat(SERVER_DATE_FORMAT).format(dt);
  return formattedDate;
}

String ensureValidFormat(String date) {
  List<String> arr = date.split('-');
  if (arr[0].length == 4) {
    return date;
  }
  arr.insert(0, arr.last);
  arr.removeLast();
  String formatted = arr.join('-');
  return formatted;
}

DateTime todayDate = DateTime.now();
