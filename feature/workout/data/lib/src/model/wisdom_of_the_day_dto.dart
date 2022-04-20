class WisdomOfTheDayDto {
  WisdomOfTheDayDto({
    this.id,
    this.name,
    this.text,
    this.image,
    this.estimatedReadingTime,
    this.done,
  });

  String? id;
  String? name;
  String? text;
  String? image;
  int? estimatedReadingTime;
  bool? done;

  factory WisdomOfTheDayDto.fromJson(Map<String, dynamic> json) => WisdomOfTheDayDto(
    id: json["id"],
    name: json["name"],
    text: json["text"],
    image: json["image"],
    estimatedReadingTime: json["estimatedReadingTime"],
    done: json["done"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "text": text,
    "image": image,
    "estimatedReadingTime": estimatedReadingTime,
    "done": done,
  };
}