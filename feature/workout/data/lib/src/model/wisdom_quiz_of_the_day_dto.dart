class WisdomQuizOfTheDayDto {
  WisdomQuizOfTheDayDto({
    this.id,
    this.text,
    this.finishDate,
    this.done,
    this.success,
  });

  String? id;
  String? text;
  dynamic finishDate;
  bool? done;
  dynamic success;

  factory WisdomQuizOfTheDayDto.fromJson(Map<String, dynamic> json) => WisdomQuizOfTheDayDto(
    id: json["id"],
    text: json["text"],
    finishDate: json["finishDate"],
    done: json["done"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "finishDate": finishDate,
    "done": done,
    "success": success,
  };
}