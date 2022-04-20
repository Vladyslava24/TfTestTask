import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/exercise_category.dart';
import 'package:totalfit/redux/states/app_state.dart';
import '../ui/screen/main/workout/main/list_category_header.dart';

class PageHeaderItem {
  final WorkoutDto workout;
  final List<String> equipment;
  final String theme;
  final String difficultyLevel;

  PageHeaderItem(
      {@required this.workout,
      @required this.equipment,
      @required this.theme,
      @required this.difficultyLevel});

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageHeaderItem &&
          runtimeType == other.runtimeType &&
          workout == other.workout &&
          theme == other.theme &&
          difficultyLevel == other.difficultyLevel;

  @override
  int get hashCode =>
      workout.hashCode ^ theme.hashCode ^ difficultyLevel.hashCode;
}

class SingleWorkoutListItem {
  final List<WorkoutDto> workouts;

  SingleWorkoutListItem({@required this.workouts});
}

class ExercisesItem {
  final List<ExerciseCategory> exercises;

  ExercisesItem({@required this.exercises});
}

class ExerciseCategoryListWidget extends StatelessWidget {
  final ExercisesItem item;
  final Function(ExerciseCategory) onCategorySelected;
  final Function onSeeAllPressed;

  ExerciseCategoryListWidget(
      {@required this.item,
      @required this.onCategorySelected,
      @required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    final columnItems = <Widget>[];
    columnItems.add(
      ListCategoryHeaderWidget(
        title: S.of(context).exercises,
        navigateToWorkoutSelectionPage: () => onSeeAllPressed(),
      ),
    );
    columnItems.addAll(item.exercises
        .map((e) => _buildContent(e, onCategorySelected))
        .toList());
    return Container(
      color: AppColorScheme.colorBlack,
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnItems,
      ),
    );
  }

  Widget _buildContent(ExerciseCategory exerciseCategory, Function onTap) =>
      Container(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 16, right: 16),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TfImage(
                    url: exerciseCategory.image,
                    fit: BoxFit.fitHeight,
                    height: 65,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: exerciseCategory.image == null
                      ? Container(width: 250, height: 65)
                      : Container(
                          width: 250,
                          height: 65,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppColorScheme.colorBlack,
                                AppColorScheme.colorBlack2,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    exerciseCategory.tag.replaceAll('_', ' '),
                    textAlign: TextAlign.left,
                    style: title20.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: new BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(exerciseCategory),
                    splashColor: AppColorScheme.colorYellow.withOpacity(0.3),
                    highlightColor: AppColorScheme.colorYellow.withOpacity(0.1),
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class StubItem {
  final String title;

  StubItem({@required this.title});
}

class SingleWorkoutListWidget extends StatefulWidget {
  final SingleWorkoutListItem item;
  final VoidCallback navigateToWorkoutSelectionPage;
  final Function(WorkoutDto) onWorkoutSelected;

  SingleWorkoutListWidget(
      {@required this.item,
      @required this.navigateToWorkoutSelectionPage,
      @required this.onWorkoutSelected,
      @required Key key})
      : super(key: key);

  @override
  _SingleWorkoutListWidgetState createState() =>
      _SingleWorkoutListWidgetState();
}

class _SingleWorkoutListWidgetState extends State<SingleWorkoutListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListCategoryHeaderWidget(
            title: S.of(context).single_workouts,
            navigateToWorkoutSelectionPage: () {
              widget.navigateToWorkoutSelectionPage();
            },
          ),
          Container(
            height: 146,
            margin: EdgeInsets.only(top: 12),
            child: ListView.builder(
              itemCount: widget.item.workouts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final workout = widget.item.workouts[index];
                return _buildContent(
                    workout, index == widget.item.workouts.length - 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(WorkoutDto workout, bool isLast) => GestureDetector(
        onTap: () {
          print(workout.image);
          widget.onWorkoutSelected(workout);
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: isLast ? 16 : 0),
          width: 246,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(cardBorderRadius),
                child: TfImage(
                  url: workout.image,
                  width: 246,
                  height: 144,
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(cardBorderRadius),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            color: AppColorScheme.colorYellow,
                            child: Text(
                              workout.estimatedTime == null
                                  ? ""
                                  : "${workout.estimatedTime} ${S.of(context).min}",
                              textAlign: TextAlign.left,
                              style: textRegular12.copyWith(
                                color: AppColorScheme.colorPrimaryBlack,
                              ),
                            ),
                          ),
                        ),
                        Container(width: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            color: AppColorScheme.colorOrange,
                            child: Text(
                              workout.difficultyLevel == null
                                  ? ""
                                  : workout.difficultyLevel,
                              textAlign: TextAlign.left,
                              style: textRegular12.copyWith(
                                color: AppColorScheme.colorPrimaryBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 4),
                    Container(
                      child: Text(
                        workout.theme == null
                            ? ""
                            : workout.theme.toUpperCase(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: title20.copyWith(
                          color: AppColorScheme.colorPrimaryWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class PageHeaderWidget extends StatefulWidget {
  final PageHeaderItem item;
  final VoidCallback onWorkoutSelected;

  PageHeaderWidget({@required this.item, @required this.onWorkoutSelected});

  @override
  _PageHeaderWidgetState createState() => _PageHeaderWidgetState();
}

class _PageHeaderWidgetState extends State<PageHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) => _buildContent(vm),
    );
  }

  Widget _buildContent(_ViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: <Widget>[
          _buildTitle(vm),
          _buildSubTitle(),
          _buildImage(),
        ],
      ),
    );
  }

  Widget _buildTitle(_ViewModel vm) => Row(
        children: <Widget>[
          Text(
            S.of(context).ready_to_rock_title,
            textAlign: TextAlign.left,
            style: title20.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ],
      );

  Widget _buildSubTitle() => Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).ready_to_rock_subtitle,
            textAlign: TextAlign.left,
            style: textRegular16.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ),
      );

  Widget _buildImage() => Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.circular(10),
            child: widget.item.workout == null
                ? Container()
                : TfImage(
                    url: widget.item.workout.image,
                    width: double.infinity,
                    height: 212,
                  ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(4),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    color: AppColorScheme.colorYellow,
                    child: Text(
                      widget.item.difficultyLevel ?? "",
                      textAlign: TextAlign.left,
                      style: textRegular12.copyWith(
                        color: AppColorScheme.colorPrimaryBlack,
                      ),
                    ),
                  ),
                ),
                Container(height: 4),
                Text(
                  widget.item.theme != null
                      ? widget.item.theme.toUpperCase()
                      : "",
                  textAlign: TextAlign.left,
                  style: title20.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                Container(height: 4),
                Text(
                  widget.item.equipment == null
                      ? ""
                      : widget.item.equipment.join(", ").toUpperCase(),
                  textAlign: TextAlign.left,
                  style: textRegular10.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onWorkoutSelected,
                  splashColor: AppColorScheme.colorYellow.withOpacity(0.3),
                  highlightColor: AppColorScheme.colorYellow.withOpacity(0.1),
                  child: Container(),
                ),
              ),
            ),
          ),
        ],
      );
}

class _ViewModel {
  bool workoutsLoaded = false;

  _ViewModel({@required this.workoutsLoaded});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        workoutsLoaded: store.state.mainPageState.workouts != null &&
            store.state.mainPageState.workouts.isNotEmpty);
  }
}
