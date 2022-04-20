import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/model/choose_program/feed_program_list_item.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/workout/widgets/summary_progress_indicator.dart';
import 'package:totalfit/ui/widgets/premium_indicator.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramListItemWidget extends StatefulWidget {
  final FeedProgramListItem item;
  final Function(FeedProgramListItem) onProgramClick;

  ProgramListItemWidget({
    @required this.item,
    @required this.onProgramClick,
  });

  @override
  _ProgramListItemWidgetState createState() => _ProgramListItemWidgetState();
}

class _ProgramListItemWidgetState extends State<ProgramListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  _buildBadge(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 8,
            top: 4,
            right: 8,
            bottom: 4,
          ),
          color: AppColorScheme.colorBlack5,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: textRegular12.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(_ViewModel vm) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.transparent,
                BlendMode.multiply,
              ),
              child: TfImage(
                url: widget.item.image,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // _buildBadge(item.name),
                    // const SizedBox(width: 4),
                    _buildBadge(widget.item.levelsForFeedUI),
                  ],
                ),
                const SizedBox(width: 0, height: 4),
                Text(
                  widget.item.name.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: title20.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.item.equipmentForFeedUI.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: textRegular10.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                widget.item.isActive
                    ? Container(
                        padding:
                            const EdgeInsets.only(top: 12, left: 4, right: 4),
                        width: double.infinity,
                        child: StaticCustomLinearProgressIndicator(
                          0.0,
                          value: widget.item.programProgress.workoutsDone /
                              widget.item.programProgress.workoutsQuantity,
                          color: AppColorScheme.colorYellow,
                          idleColor:
                              AppColorScheme.colorBlack7.withOpacity(0.7),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(const Radius.circular(10)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => {widget.onProgramClick(widget.item)},
                  splashColor: AppColorScheme.colorYellow.withOpacity(0.3),
                  highlightColor: AppColorScheme.colorYellow.withOpacity(0.1),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          vm.isPremiumUser
              ? Container()
              : premiumIndicator(leftPositioned: true)
        ],
      ),
    );
  }
}

class _ViewModel {
  final bool isPremiumUser;

  _ViewModel({@required this.isPremiumUser});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(isPremiumUser: store.state.isPremiumUser());
  }
}
