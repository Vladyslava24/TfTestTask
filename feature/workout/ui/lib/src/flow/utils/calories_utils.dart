class CaloriesUtils {
  static String calculateCalories(int timeInMilliseconds, int userWeightInKg) =>
    ((timeInMilliseconds / (60 * 1000)) * ((5 * 3.5 * userWeightInKg)) ~/ 200)
      .toString();
}