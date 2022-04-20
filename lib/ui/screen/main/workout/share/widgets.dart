// import 'package:workout_data_legacy/data.dart';
// import 'package:flutter/material.dart';
// import 'package:core/core.dart';
// import 'package:core/generated/l10n.dart';
// import 'package:ui_kit/ui_kit.dart';
// import 'package:totalfit/model/workout_preview_list_items.dart';
// import 'package:totalfit/ui/widgets/grid_items.dart';
//
// class ResultWidget extends StatefulWidget {
//   final String imageUrl;
//   final GlobalKey shareContentKey;
//   final ExerciseCategoryItem wod;
//   final int workoutDuration;
//   final String wodType;
//   final String workoutName;
//   final int totalExercises;
//   final int wodResult;
//   final int roundCount;
//
//   ResultWidget(
//       {@required this.wod,
//       @required this.shareContentKey,
//       @required this.imageUrl,
//       @required this.workoutDuration,
//       @required this.wodType,
//       @required this.workoutName,
//       @required this.totalExercises,
//       @required this.wodResult,
//       @required this.roundCount});
//
//   @override
//   _ResultWidgetState createState() => _ResultWidgetState();
// }
//
// class _ResultWidgetState extends State<ResultWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size.width;
//     return RepaintBoundary(
//       key: widget.shareContentKey,
//       child: Stack(
//         children: <Widget>[
//           Container(
//               width: size,
//               height: size,
//               child: TfImage(
//                   url: widget.imageUrl, dim: AppColorScheme.colorPrimaryBlack)),
//           Container(
//               width: size, height: size, child: _buildWorkoutResult(size)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPointsRow(double size) => Positioned(
//         left: 16,
//         bottom: 16,
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: _buildExercisesList()),
//       );
//
//   List<Widget> _buildExercisesList() {
//     final children = <Widget>[];
//     final workout = widget.wod.workout;
//     children.add(
//       Text(
//         "${S.of(context).workout.toUpperCase()} / " +
//             widget.workoutName.toUpperCase(),
//         style: title14.copyWith(
//           color: AppColorScheme.colorPrimaryWhite,
//         ),
//       ),
//     );
//     children.add(Container(height: 2));
//     children.add(
//       Text(
//         S
//             .of(context)
//             .exercise_category_subtitle_wod(
//                 workout.wodType.replaceAll('_', ' '),
//                 workout.quantity,
//                 workout.metrics.toLowerCase(),
//                 workout.wod.length)
//             .toUpperCase(),
//         style: textRegular10.copyWith(
//           color: AppColorScheme.colorBlack9,
//         ),
//       ),
//     );
//     children.add(Container(height: 4));
//
//     widget.wod.exercises.forEach((e) {
//       children.add(_buildExercisesListItem(e));
//     });
//
//     return children;
//   }
//
//   Widget _buildExercisesListItem(Exercise exercise) => Row(
//         children: <Widget>[
//           Text(
//             exercise.type == 'SKILL' ? 'x10' : exercise.getMetricQuantity(),
//             style: textMedium12.copyWith(
//               color: AppColorScheme.colorPrimaryWhite,
//             ),
//           ),
//           Container(width: 16),
//           Text(
//             exercise.name,
//             style: textRegular10.copyWith(
//               color: AppColorScheme.colorPrimaryWhite,
//             ),
//           ),
//         ],
//       );
//
//   Widget _buildTotalTimeItem() => Positioned(
//         top: 16,
//         left: 16,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               S.of(context).final_time,
//               style: textRegular10.copyWith(
//                 color: AppColorScheme.colorBlack9,
//               ),
//             ),
//             Text(
//               timeFromMilliseconds(widget.workoutDuration),
//               style: textMedium12.copyWith(
//                 color: AppColorScheme.colorPrimaryWhite,
//               ),
//             ),
//           ],
//         ),
//       );
//
//   Widget _buildTotalWorkoutResultInRounds() => Positioned(
//         bottom: 16,
//         right: 16,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               S.of(context).wod_result,
//               style: title14.copyWith(
//                 color: AppColorScheme.colorPrimaryWhite,
//               ),
//             ),
//             Text(
//               "${widget.roundCount}",
//               style: title20.copyWith(
//                 color: AppColorScheme.colorPrimaryWhite,
//               ),
//             ),
//             Text(
//               widget.roundCount == 1
//                   ? S.of(context).round
//                   : S.of(context).rounds,
//               style: textRegular10.copyWith(
//                 color: AppColorScheme.colorBlack9,
//               ),
//             ),
//           ],
//         ),
//       );
//
//   Widget _buildTotalWorkoutResultInMinutes() => Positioned(
//         bottom: 16,
//         right: 16,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               S.of(context).wod_result,
//               style: title14.copyWith(
//                 color: AppColorScheme.colorPrimaryWhite,
//               ),
//             ),
//             Text(
//               timeFromMilliseconds(widget.wodResult),
//               style: title20.copyWith(
//                 color: AppColorScheme.colorPrimaryWhite,
//               ),
//             ),
//             Text(
//               S.of(context).minutes,
//               style: textRegular10.copyWith(
//                 color: AppColorScheme.colorBlack9,
//               ),
//             ),
//           ],
//         ),
//       );
//
//   Widget _buildWorkoutResult(double size) => Stack(
//         children: <Widget>[
//           Positioned(
//             top: 16,
//             right: 16,
//             child: Container(
//               width: 60,
//               child: AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: Duration(milliseconds: 200),
//                 child: Image.asset(
//                   imLogo,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               width: size,
//               height: size / 2.5,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.transparent,
//                       AppColorScheme.colorPrimaryBlack
//                     ]),
//               ),
//             ),
//           ),
//           _buildTotalTimeItem(),
//           _buildPointsRow(size),
//           widget.wodType == "FOR_TIME"
//               ? _buildTotalWorkoutResultInMinutes()
//               : _buildTotalWorkoutResultInRounds()
//         ],
//       );
// }
//

import 'package:flutter/material.dart';
import 'package:totalfit/ui/widgets/grid_items.dart';
import 'package:ui_kit/ui_kit.dart';

class ImageItemWidget extends StatefulWidget {
  final ImageItem item;
  final bool isSelected;
  final Function(ImageItem) onSelected;

  ImageItemWidget(
      {@required this.item,
      @required this.isSelected,
      @required this.onSelected,
      Key key})
      : super(key: key);

  @override
  _ImageItemWidgetState createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        key: ObjectKey(widget.item.url),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: AppColorScheme.colorBlack2,
          child: Stack(
            children: <Widget>[
              TfImage(url: widget.item.url, dim: Colors.transparent),
              ClipRRect(
                borderRadius: new BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => widget.onSelected(widget.item),
                    splashColor:
                        AppColorScheme.colorPrimaryWhite.withOpacity(0.3),
                    highlightColor:
                        AppColorScheme.colorPrimaryWhite.withOpacity(0.1),
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
