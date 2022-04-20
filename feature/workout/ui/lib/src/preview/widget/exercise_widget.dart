/*
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_use_case/use_case.dart';

class ExerciseWidget extends StatefulWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;
  final Function(bool) onExpansionChanged;
  final bool isInPreview;

  const ExerciseWidget(
      {Key? key,
      required this.exercise,
      required this.isInPreview,
      required this.onExpansionChanged,
      required this.onTap})
      : super(key: key);

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.transparent,
            accentColor: Colors.transparent),
        child: Container(
          child: AppExpansionTile(
            isExpanded: widget.isInPreview,
            onExpansionChanged: widget.onExpansionChanged,
            key: PageStorageKey<Exercise>(widget.exercise),
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  vm.pauseSelectedVideo(!vm.isPreviewingExercisePlaying);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 12),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(10),
                    child: ExerciseVideoWidget(
                        height: 200,
                        isPlaying: vm.isPreviewingExercisePlaying,
                        showProgress: false,
                        url: widget.exercise.video480),
                  ),
                ),
              )
            ],
            title: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: new BorderRadius.circular(10),
                      child: TfImage(
                          url: widget.exercise.image, width: 75, height: 54)),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.exercise.name,
                            style: title14.copyWith(
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          ),
                          Container(height: 4),
                          widget.exercise.type ==
                                  S.of(context).all__skill.toUpperCase()
                              ? Container(height: 0)
                              : Text(
                                  widget.exercise.getMetricQuantity(),
                                  style: textRegular12.copyWith(
                                    color: AppColorScheme.colorBlack7,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
*/
