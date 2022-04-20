import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/model/tutorial_model.dart';
import 'package:workout_ui/src/tutorial/utils/enable_rotation.dart';
import 'package:workout_ui/src/tutorial/utils/set_portrait_orientation.dart';
import 'package:workout_ui/src/tutorial/widget/skill_video_widget.dart';

class WorkoutTutorialScreen extends StatefulWidget {
  final TutorialModel tutorial;

  const WorkoutTutorialScreen({
    required this.tutorial,
    Key? key
  }) : super(key: key);

  @override
  State<WorkoutTutorialScreen> createState() => _WorkoutTutorialScreenState();
}

class _WorkoutTutorialScreenState extends State<WorkoutTutorialScreen> {

  late Future<void> _setRotationFuture;

  @override
  void initState() {
    _setRotationFuture = enableRotation();
    super.initState();
  }

  @override
  void dispose() {
    setPortraitOrientation();
    super.dispose();
  }

  Future<bool> _moveBack(BuildContext context) {
    Navigator.of(context).pop();
    return Future.sync(() => true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _moveBack(context),
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Scaffold(
            backgroundColor: AppColorScheme.colorPrimaryBlack,
            body: FutureBuilder(
              future: _setRotationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }

                return SafeArea(
                  child: SkillVideoWidget(
                    orientation: orientation,
                    url: widget.tutorial.url,
                    onEndVideoAction: () => _moveBack(context)
                  ),
                );
              },
            ),
          );
        }
      ),
    );
  }
}