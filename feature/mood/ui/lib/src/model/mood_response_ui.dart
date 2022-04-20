class MoodResponse {
  final String feelingName;
  final String emoji;
  final String time;

  const MoodResponse({
    required this.feelingName,
    required this.emoji,
    required this.time
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'feelingName': feelingName,
      'emoji': emoji,
      'time': time,
    };
  }
}