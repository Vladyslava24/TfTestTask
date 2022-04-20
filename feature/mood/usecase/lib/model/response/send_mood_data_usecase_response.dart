class SendMoodDataUseCaseResponse {
  final String feelingName;
  final String emoji;
  final String time;

  const SendMoodDataUseCaseResponse({
    required this.feelingName,
    required this.emoji,
    required this.time
  });
}