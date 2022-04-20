import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_ui/src/model/workout_settings_item.dart';
import 'package:workout_ui/src/model/workout_status.dart';
import 'package:workout_ui/src/preview/list_item/list_items.dart';
import 'package:workout_ui/src/preview/widget/workout_actions_widget.dart';
import 'package:workout_ui/src/preview/widget/workout_sliver_app_bar.dart';
import 'package:workout_use_case/use_case.dart';
import 'exercise_category_item_widget.dart';
import 'info_widget.dart';

class WorkoutPreviewCustomScroll extends StatefulWidget {
  final HeaderItem headerItem;
  final List<dynamic> bodyItemList;
  final VoidCallback onStartPressed;
  final WorkoutFixedActionsWidget fixedActions;
  final List<String> detailsTitle;
  final List<WorkoutSettingsItem>? listWorkoutSettingItems;

  const WorkoutPreviewCustomScroll({
    required this.listWorkoutSettingItems,
    required this.headerItem,
    required this.bodyItemList,
    required this.onStartPressed,
    required this.fixedActions,
    this.detailsTitle = const [],
    Key? key,
  }) : super(key: key);

  @override
  _WorkoutPreviewCustomScrollState createState() =>
      _WorkoutPreviewCustomScrollState();
}

class _WorkoutPreviewCustomScrollState
    extends State<WorkoutPreviewCustomScroll> {
  late ScrollController _customScrollController;
  late ScrollController _bodyScrollController;
  bool isChangedAppBarToMin = false;

  @override
  void initState() {
    _customScrollController = ScrollController();
    _bodyScrollController = ScrollController();
    _customScrollController.addListener(_customScrollHandler);
    super.initState();
  }

  @override
  void dispose() {
    _customScrollController.dispose();
    _bodyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _customScrollController,
      slivers: [
        WorkoutSliverAppBar(
          isChangedAppBarToMin: isChangedAppBarToMin,
          data: widget.headerItem,
          fixedActions: widget.fixedActions,
          key: const ValueKey('WorkoutSliverAppBar'),
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 0),
            itemCount: widget.bodyItemList.length,
            controller: _bodyScrollController,
            itemBuilder: (context, index) {
              final item = widget.bodyItemList[index];
              if (item is InfoItem) {
                return InfoWidget(
                  detailsTitle: widget.detailsTitle.isNotEmpty ?
                    widget.detailsTitle.first : '',
                  equipmentTitle: widget.detailsTitle.isNotEmpty ?
                    widget.detailsTitle.last : '',
                  item: item
                );
              }
              if (item is ExerciseItem) {
                if(item.workoutStatus == WorkoutStatus.warmup){
                  for(var settingItem in widget.listWorkoutSettingItems!){
                    if(settingItem.id == WorkoutSettingsIds.turnOffWarmUp && settingItem.value == true){
                      return const SizedBox();
                    }
                  }
                }else if(item.workoutStatus == WorkoutStatus.cooldown){
                  for(var settingItem in widget.listWorkoutSettingItems!){
                    if(settingItem.id == WorkoutSettingsIds.turnOffCoolDown && settingItem.value == true){
                      return const SizedBox();
                    }
                  }
                }
                return ExerciseCategoryItemWidget(
                    title: item.title,
                    subTitle: item.subTitle,
                    onExerciseSelected: (exercise) {},
                    exercises: item.exercises
                );
              }
              if (item is SpaceWorkoutListItem) {
                return const SizedBox(height: 80.0);
              }
              return const SizedBox(height: 16.0);
            }
          ),
        ),
      ],
    );
  }

  void _customScrollHandler() {
    _customScrollController.offset < 120
        ? setState(() {
            isChangedAppBarToMin = false;
          })
        : setState(() {
            isChangedAppBarToMin = true;
          });
  }
}
