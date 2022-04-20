// import 'package:flutter/cupertino.dart';
//
// class Exercise {
//   String type;
//   final String name;
//   final String image;
//   final int quantity;
//   String video480;
//   String video720;
//   String video1080;
//   String videoVertical;
//   String tag;
//   String metrics;
//
//   Exercise({@required this.name, @required this.quantity, @required this.image, this.videoVertical});
//
//   Exercise.fromJson(jsonMap)
//       : type = jsonMap["type"],
//         name = jsonMap["name"],
//         image = jsonMap["previewImage"],
//         quantity = jsonMap["quantity"],
//         video480 = jsonMap["video480"],
//         video720 = jsonMap["video720"],
//         video1080 = jsonMap["video1080"],
//         videoVertical = jsonMap["videoVertical"],
//         metrics = jsonMap["metrics"],
//         tag = jsonMap["tag"];
//
//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "name": name,
//         "previewImage": image,
//         "quantity": quantity,
//         "video480": video480,
//         "video720": video720,
//         "video1080": video1080,
//         "videoVertical": videoVertical,
//         "metrics": metrics,
//         "tag": tag
//       };
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Exercise &&
//           runtimeType == other.runtimeType &&
//           image == other.image &&
//           metrics == other.metrics &&
//           quantity == other.quantity &&
//           name == other.name;
//
//   @override
//   int get hashCode => image.hashCode ^ name.hashCode ^ quantity.hashCode ^ metrics.hashCode;
//
//   String getMetricQuantity() {
//     if (metrics == 'MIN') {
//       return '$quantity min';
//     }
//     if (metrics == 'SEC') {
//       return '$quantity sec';
//     }
//     if (metrics == 'REPS') {
//       return 'x$quantity';
//     }
//     return quantity.toString();
//   }
//
//   factory Exercise.clearStateStub() {
//     return Exercise(name: null, quantity: null, image: null);
//   }
// }
//

