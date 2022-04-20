import 'package:core/generated/l10n.dart';
import 'package:totalfit/ui/widgets/cards/card_chip_widget.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/utils/string_extensions.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/widgets/premium_indicator.dart';

class RelativeWorkoutsPage extends StatefulWidget {
  final List<WorkoutDto> workouts;
  RelativeWorkoutsPage({@required this.workouts, Key key}) : super(key: key);

  @override
  _RelativeWorkoutsPageState createState() => _RelativeWorkoutsPageState();
}

class _RelativeWorkoutsPageState extends State<RelativeWorkoutsPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      onInit: (store) {},
      builder: (context, vm) => _buildContent(vm)
    );
  }

  Widget _buildContent(_ViewModel vm) => Container(
    color: AppColorScheme.colorBlack,
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: _controller,
      itemCount: widget.workouts.length,
      itemBuilder: (context, index) {
        return Material(
          color: AppColorScheme.colorBlack,
          child: InkWell(
            splashColor: AppColorScheme.colorYellow.withOpacity(0.7),
            highlightColor: AppColorScheme.colorYellow.withOpacity(0.5),
            onTap: () {},
            child: Center(
              child: _WorkoutItemWidget(
                workout: widget.workouts[index],
                isPremiumUser: vm.isPremiumUser,
                onWorkoutSelected: () {
                  vm.onWorkoutSelected(widget.workouts[index]);
                }),
            ),
          ),
        );
      }),
  );

  @override
  bool get wantKeepAlive => true;
}

class _ViewModel {
  final Function(WorkoutDto) onWorkoutSelected;
  final bool isPremiumUser;

  _ViewModel({this.onWorkoutSelected, this.isPremiumUser});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isPremiumUser: store.state.isPremiumUser(),
      onWorkoutSelected: (workout) => store.dispatch(
        NavigateToWorkoutPreviewPageAction(workout),
      ),
    );
  }
}

class _WorkoutItemWidget extends StatefulWidget {
  final WorkoutDto workout;
  final bool isPremiumUser;

  final VoidCallback onWorkoutSelected;

  _WorkoutItemWidget(
      {@required this.workout,
      @required this.isPremiumUser,
      @required this.onWorkoutSelected});

  @override
  _WorkoutItemWidgetState createState() => _WorkoutItemWidgetState();
}

class _WorkoutItemWidgetState extends State<_WorkoutItemWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: bottomListCardsMargin / 2,
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            child: TfImage(
              url: widget.workout.image,
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
                Row(
                  children: [
                    CardChipWidget(
                      label: widget.workout.getWorkoutTime,
                      withSeparator: true
                    ),
                    CardChipWidget(
                      label: widget.workout.difficultyLevel,
                      withSeparator: false
                    ),
                  ],
                ),
                Container(height: 4.0),
                Text(
                  widget.workout.theme.capitalize(),
                  textAlign: TextAlign.left,
                  style: title20.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                Container(height: 6.0),
                Text(
                  widget.workout.equipment.isEmpty
                      ? S.of(context).no_equipment.toUpperCase()
                      : widget.workout.equipment.join(", ").toUpperCase(),
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
              borderRadius: BorderRadius.circular(cardBorderRadius),
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
          !widget.isPremiumUser && widget.workout.isPremium()
              ? premiumIndicator(leftPositioned: true)
              : Container()
        ],
      ),
    );
  }
}
