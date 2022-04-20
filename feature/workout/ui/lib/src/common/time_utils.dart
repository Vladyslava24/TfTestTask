class TimeUtils {
  static String formatExerciseDuration(int time) {
    int min = time ~/ (1000 * 60);

    if (min >= 1) {
      int sec = (time % (1000 * 60)) ~/ 1000;
      return '$min min $sec sec';
    } else {
      int sec = time ~/ 1000;
      return '$sec sec';
    }
  }

  static String formatWorkoutDuration(int? totalDuration) {
    if (totalDuration == null) {
      return '-1';
    }
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = totalDuration ~/ (1000 * 60);
    int sec = (totalDuration % (1000 * 60)) ~/ 1000;

    String parsedTime =
        getParsedTime(min.toString()) + ":" + getParsedTime(sec.toString());

    return parsedTime;
  }
}
