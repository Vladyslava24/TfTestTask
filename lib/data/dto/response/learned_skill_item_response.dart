

class LearnedSkillItemResponse {
  final String metrics;
  final String previewImage;
  final String name;
  final int quantity;
  final String tag;
  final String type;
  final String video1080;
  final String video480;
  final String video720;
  final String videoVertical;

  LearnedSkillItemResponse({
    this.metrics,
    this.previewImage,
    this.quantity,
    this.name,
    this.tag,
    this.type,
    this.video1080,
    this.video480,
    this.video720,
    this.videoVertical,
  });

  LearnedSkillItemResponse.fromJson(json)
      : metrics = json["metrics"],
        name = json["name"],
        previewImage = json["previewImage"],
        tag = json["tag"],
        type = json["type"],
        video1080 = json["video1080"],
        video480 = json["video480"],
        video720 = json["video720"],
        videoVertical = json["videoVertical"],
        quantity = json["quantity"];
}
