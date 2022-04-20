class ExerciseModel {
  final String type;
  final String name;
  final String image;
  final int? quantity;
  final String video480;
  final String video720;
  final String video1080;
  final String videoVertical;
  final String tag;
  final String metrics;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
         name == other.name ;

  @override
  int get hashCode {
   return type.hashCode ^ name.hashCode;
  }


  const ExerciseModel({
    required this.type,
    required this.video480,
    required this.video720,
    required this.video1080,
    required this.tag,
    required this.metrics,
    required this.name,
    required this.quantity,
    required this.image,
    required this.videoVertical,
  });
}
