import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/utils/locales_service.dart';
import 'package:ui_kit/ui_kit.dart';

import 'profile_statistics.dart';

final LocalesService _localesService = DependencyProvider.get<LocalesService>();

class FeedItem {}

class ProfileHeaderListItem extends FeedItem {
  User user;
  final ProfileStatisticsState profileStatistics;

  ProfileHeaderListItem({
    @required this.user,
    @required this.profileStatistics,
  });

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileHeaderListItem &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          profileStatistics == other.profileStatistics;

  @override
  int get hashCode => user.hashCode ^ profileStatistics.hashCode;
}

class CompletedWorkoutListItem extends FeedItem {
  final String workoutProgressId;
  final String dateForUI;
  final DateTime originDate;
  final String name;
  final String month;
  final String workoutDuration;
  final String roundCount;
  final String wodType;

  CompletedWorkoutListItem({
    @required this.workoutProgressId,
    @required this.dateForUI,
    @required this.originDate,
    @required this.name,
    @required this.workoutDuration,
    @required this.month,
    @required this.roundCount,
    @required this.wodType,
  });

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedWorkoutListItem &&
          runtimeType == other.runtimeType &&
          workoutProgressId == other.workoutProgressId &&
          originDate == other.originDate &&
          workoutDuration == other.workoutDuration &&
          month == other.month &&
          roundCount == other.roundCount &&
          dateForUI == other.dateForUI &&
          wodType == other.wodType &&
          name == other.name;

  @override
  int get hashCode =>
      workoutProgressId.hashCode ^
      workoutDuration.hashCode ^
      dateForUI.hashCode ^
      name.hashCode ^
      originDate.hashCode ^
      roundCount.hashCode ^
      wodType.hashCode ^
      month.hashCode;
}

class ProfileHeaderWidget extends StatelessWidget {
  final ProfileHeaderListItem item;
  final VoidCallback navigateToEditProfile;
  final VoidCallback navigateToSettings;

  ProfileHeaderWidget({
    @required this.item,
    @required this.navigateToEditProfile,
    @required this.navigateToSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                      width: 86,
                      height: 86,
                      margin: EdgeInsets.only(top: 12),
                      child: CircleAvatar(
                        child: item.user.photo == null
                            ? Text(
                                _getInitials(),
                                style: title30.copyWith(
                                  color: AppColorScheme.colorPrimaryWhite,
                                ),
                              )
                            : null,
                        backgroundColor:
                            AppColorScheme.colorBlack3.withOpacity(0.9),
                        radius: 35,
                        backgroundImage: item.user.photo != null
                            ? NetworkImage(item.user.photo)
                            : null,
                      )),
                  Container(height: 12),
                ],
              ),
            ),
          ],
        ),
        Container(height: 18),
        _buildPointsRow(item.profileStatistics, context),
        Container(height: 24),
        Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).completed_workouts,
              style: title20.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ),
        ),
        Container(height: 6),
      ],
    );
  }

  String _getInitials() {
    return '${item.user.firstName == null || item.user.firstName.isEmpty ?
      '' : item.user.firstName.substring(0, 1).toUpperCase()}';
  }

  Widget _buildPointsRow(
          ProfileStatisticsState profileStatistics, BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Container(
          height: 70,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: _getProfileStatisticsState(profileStatistics, context),
          ),
        ),
      );

  Widget _getProfileStatisticsState(
      ProfileStatisticsState profileStatistics, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildPointItem(
            profileStatistics.totalTime.toString(), S.of(context).total_time),
        Container(width: 8),
        _buildPointItem(profileStatistics.totalWorkouts.toString(),
            S.of(context).bottom_menu__workouts),
        Container(width: 8),
        _buildPointItem(profileStatistics.totalPoints.toString(),
            S.of(context).points_upper),
      ],
    );
  }

  Widget _buildPointItem(String count, String title) => Expanded(
        child: ClipRRect(
          borderRadius: new BorderRadius.all(Radius.circular(8)),
          child: Container(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            color: AppColorScheme.colorBlack2,
            child: Column(
              children: [
                Text(
                  count.toString(),
                  style: title20.copyWith(
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                ),
                Container(height: 4),
                Text(
                  title,
                  style: textRegular12.copyWith(
                    color: AppColorScheme.colorBlack9,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class CompletedWorkoutWidget extends StatelessWidget {
  final CompletedWorkoutListItem item;
  final VoidCallback onShare;
  final VoidCallback onView;
  final VoidCallback onDelete;

  CompletedWorkoutWidget(
      {@required this.item,
      @required this.onShare,
      @required this.onView,
      @required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 6,
        bottom: 6,
        left: 12,
        right: 12,
      ),
      child: ClipRRect(
        borderRadius: new BorderRadius.all(Radius.circular(8)),
        child: GestureDetector(
          onTap: () {
            onView();
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 12.0,
              right: 12.0,
            ),
            color: AppColorScheme.colorBlack2,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildDate(),
                Container(width: 12),
                Container(
                  width: 1,
                  height: 50,
                  color: AppColorScheme.colorBlack4,
                ),
                Container(width: 12),
                _buildTexts(),
                Expanded(
                  child: Container(width: 8),
                ),
                PopupMenuButton<String>(
                  color: AppColorScheme.colorBlack3,
                  icon: Icon(
                    Icons.more_horiz,
                    color: AppColorScheme.colorPrimaryWhite,
                  ),
                  onSelected: (value) {
                    if (value == ProgressMenuItems.shareResults) {
                      onShare();
                      return;
                    }
                    if (value == ProgressMenuItems.view) {
                      onView();
                      return;
                    }
                    if (value == ProgressMenuItems.delete) {
                      onDelete();
                      return;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return ProgressMenuItems.list.map((item) {
                      return PopupMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: textRegular16.copyWith(
                            color: AppColorScheme.colorPrimaryWhite,
                          ),
                        ),
                      );
                    }).toList();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDate() => Container(
        width: 30,
        child: Column(
          children: <Widget>[
            Text(
              item.month,
              style: textRegular12.copyWith(
                color: AppColorScheme.colorBlack7,
              ),
            ),
            SizedBox(height: 8),
            Text(
              item.dateForUI,
              style: textRegular12.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ],
        ),
      );

  Widget _buildTexts() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.name,
            style: title16.copyWith(
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
          SizedBox(height: 8),
          Text(
            item.wodType == "FOR_TIME" ? item.workoutDuration : item.roundCount,
            style: textRegular14.copyWith(
              color: AppColorScheme.colorBlack6,
            ),
          ),
        ],
      );
}

class ProgressMenuItems {
  static String shareResults = _localesService.locales.share_results;
  static String view = _localesService.locales.view;
  static String delete = _localesService.locales.delete;

  static List<String> list = <String>[shareResults, view, delete];
}
