class AnsweredQuestionDto {
  String id;
  String answer;
  String question;
  String questionId;

  AnsweredQuestionDto();

  AnsweredQuestionDto.fromMap(jsonMap)
      : id = jsonMap["id"],
        answer = jsonMap["answer"],
        question = jsonMap["question"],
        questionId = jsonMap["questionId"];

  int get hashCode => id.hashCode ^ answer.hashCode ^ question.hashCode ^ questionId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is AnsweredQuestionDto &&
      id == other.id &&
      answer == other.answer &&
      question == other.question &&
      questionId == other.questionId;
}
