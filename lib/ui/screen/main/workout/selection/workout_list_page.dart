import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/states/app_state.dart';

class WorkoutListPage extends StatefulWidget {
  final WorkoutListType type;

  const WorkoutListPage({@required this.type, @required Key key})
      : super(key: key);

  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  ScrollController _controller;

  @override
  void initState() {
    ScrollPosition initialPosition =
        PageStorage.of(context).readState(context, identifier: "scroll");
    double initialOffset = 0;
    if (initialPosition != null) {
      initialOffset = initialPosition.pixels ?? 0;
    }
    _controller = ScrollController(initialScrollOffset: initialOffset);
    _controller.addListener(() {
      PageStorage.of(context)
          .writeState(context, _controller.position, identifier: "scroll");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Container(
        color: AppColorScheme.colorBlack,
        child: ListView.builder(
          controller: _controller,
          itemCount: vm.workouts.length,
          itemBuilder: (context, index) {
            return Material(
              color: AppColorScheme.colorBlack,
              child: InkWell(
                splashColor: AppColorScheme.colorYellow.withOpacity(0.7),
                highlightColor: AppColorScheme.colorYellow.withOpacity(0.5),
                onTap: () => vm.onWorkoutSelected(vm.workouts[index]),
                child: Center(
                  child: WorkoutWidget(
                    type: widget.type,
                    workout: vm.workouts[index],
                  ),
                ),
              ),
            );
          },
        ),
      );
}

class _ViewModel {
  List<WorkoutDto> workouts;
  final Function(WorkoutDto) onWorkoutSelected;

  _ViewModel({@required this.workouts, @required this.onWorkoutSelected});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        workouts: store.state.mainPageState.workouts,
        onWorkoutSelected: (workout) =>
            store.dispatch(NavigateToWorkoutPreviewPageAction(workout)));
  }
}

class WorkoutWidget extends StatefulWidget {
  final WorkoutDto workout;
  final WorkoutListType type;

  WorkoutWidget({@required this.workout, @required this.type});

  @override
  _WorkoutWidgetState createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.circular(10),
            child: TfImage(
              url: widget.workout.image,
              width: 75,
              height: 54,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.workout.theme,
                    style: title14.copyWith(
                        color: AppColorScheme.colorPrimaryWhite),
                  ),
                  Container(height: 4),
                  Text(
                    _getSubtitle(widget.type),
                    style: textMedium12.copyWith(
                      color: AppColorScheme.colorBlack7,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _getSubtitle(WorkoutListType type) {
    switch (type) {
      case WorkoutListType.Time:
        return "${widget.workout.estimatedTime} min";
        break;
      case WorkoutListType.Equipment:
        return widget.workout.equipment.join(', ');
        break;
      case WorkoutListType.Level:
        return "${widget.workout.difficultyLevel}";
        break;
    }
  }
}

enum WorkoutListType { Time, Equipment, Level }
