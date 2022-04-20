class Question {
  int id;
  int order;
  int reward;
  String question;

  /// 'TEXT' | 'RATE'
  String questionType;

  Question(
      {required this.id,
      required this.order,
      required this.reward,
      required this.question,
      required this.questionType});

  Question.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap["id"],
        order = jsonMap["order"],
        reward = jsonMap["reward"],
        question = jsonMap["question"],
        questionType = jsonMap["questionType"];

  Map<String, dynamic> toJson() =>
      {"id": id, "order": order, "reward": reward, "question": question, "questionType": questionType};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question && runtimeType == other.runtimeType && id == other.id && question == other.question;

  @override
  int get hashCode => question.hashCode ^ id.hashCode;
}

class Answer {
  int questionId;
  String answer;

  Answer({required this.questionId, required this.answer});

  Map toJson() => {
        'questionId': questionId,
        'answer': answer,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Answer && runtimeType == other.runtimeType && questionId == other.questionId;

  @override
  int get hashCode => questionId.hashCode;
}
