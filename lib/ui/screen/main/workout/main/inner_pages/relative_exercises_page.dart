import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/states/app_state.dart';

import 'simple_exercise_item.dart';

class RelativeExercisesPage extends StatefulWidget {
  final String exerciseTag;

  const RelativeExercisesPage({@required this.exerciseTag, Key key})
      : super(key: key);

  @override
  _RelativeExercisesPageState createState() => _RelativeExercisesPageState();
}

class _RelativeExercisesPageState extends State<RelativeExercisesPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller;
  List<Exercise> _exercises;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          _exercises = [];

          _exercises.addAll(
              store.state.mainPageState.sortedExercises[widget.exerciseTag]);

          _controller = ScrollController();
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Container(
        color: AppColorScheme.colorBlack,
        child: ListView.builder(
            controller: _controller,
            itemCount: _exercises.length,
            itemBuilder: (context, index) {
              return Material(
                color: AppColorScheme.colorBlack,
                child: InkWell(
                  splashColor: AppColorScheme.colorYellow.withOpacity(0.7),
                  highlightColor: AppColorScheme.colorYellow.withOpacity(0.5),
                  onTap: () {
                    vm.showExerciseVideoPage(_exercises[index]);
                  },
                  child: Center(
                    child: SimpleExerciseItem(exercise: _exercises[index]),
                  ),
                ),
              );
            }),
      );

  @override
  bool get wantKeepAlive => true;
}

class _ViewModel {
  final Function showExerciseVideoPage;

  _ViewModel({this.showExerciseVideoPage});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        showExerciseVideoPage: (exercise) =>
            store.dispatch(NavigateToExerciseVideoPage(exercise)));
  }
}
