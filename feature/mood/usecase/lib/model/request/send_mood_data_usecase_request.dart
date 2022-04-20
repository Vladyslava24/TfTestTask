class SendMoodDataUseCaseRequest {
  final int feelingsGroupId;
  final int feelingId;
  final List<int> moodReasonsIds;

  const SendMoodDataUseCaseRequest({
    required this.feelingsGroupId,
    required this.feelingId,
    required this.moodReasonsIds
  });
}