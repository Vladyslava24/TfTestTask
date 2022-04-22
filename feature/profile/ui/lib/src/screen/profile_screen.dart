import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_ui/profile.dart';
import 'package:profile_ui/src/screen/profile_state.dart';
import 'package:profile_ui/src/screen/screen_item/health_balance_item.dart';
import 'package:profile_ui/src/screen/widgets/health_balance_widget.dart';
import 'package:profile_ui/src/screen/widgets/profile_header_widget.dart';
import 'package:profile_ui/src/screen/screen_item/header_item.dart';
import 'package:profile_ui/src/screen/screen_item/test_button_item.dart';
import 'package:ui_kit/ui_kit.dart';

class ProfileScreen extends BasePage<ProfileState, ProfileCubit> {
  static final _StateToListMapper _listMapper = _StateToListMapper();
  final User user;

  const ProfileScreen({required this.user, Key? key}) : super(key: key);

  @override
  ProfileCubit createBloc() => DependencyProvider.get<ProfileCubit>();

  @override
  initBloc(ProfileCubit bloc) {
    bloc.init(user);
  }

  @override
  Widget buildPage(BuildContext context, ProfileCubit bloc, ProfileState state) {
    return _buildContent(user.firstName, bloc, context, state);
  }

  Widget _buildContent(String name, ProfileCubit bloc, BuildContext context, ProfileState state) {
    return Scaffold(
      appBar: SimpleAppBar(
        leadingType: LeadingType.settings,
        leadingAction: bloc.navigateToSettings,
        title: name,
        actionType: ActionType.button,
        actionButtonText: S.of(context).edit_profile,
        actionFunction: bloc.navigateToEditProfile,
      ),
      backgroundColor: AppColorScheme.colorBlack,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _buildItemList(bloc, state.bodyMindSpiritStatistic),
      ),
    );
  }

  Widget _buildItemList(ProfileCubit bloc, BodyMindSpiritStatistic statistic) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: _listMapper.listLength(),
          itemBuilder: (context, i) {
            final item = _listMapper.getItem(i, bloc.state);

            if (item is HeaderItem) {
              return ProfileHeaderWidget(
                  user: item.user, navigateToEditProfile: () {}, navigateToSettings: () {});
            }
            if (item is HealthBalanceItem) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(TextConstants.healthBalance, style: title20),
                        Text(TextConstants.lastMonth, style: textRegular16),
                      ],
                    ),
                    const SizedBox(height: 12),
                    HealthBalanceWidget(
                      body: statistic.body,
                      mind: statistic.mind,
                      spirit: statistic.spirit,
                    ),
                  ],
                ),
              );
            }
            if (item is TestButtonItem) {
              return Padding(
                padding: const EdgeInsets.only(top: 64.0, left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: () {
                    bloc.getBodyMindSpiritStatistic(5);
                  },
                  child: Text(
                    'Fetch BodyMindSpiritStatistic',
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _StateToListMapper {
  late Map<int, dynamic> _itemOrder;

  _StateToListMapper() {
    _itemOrder = {
      0: HeaderItem,
      1: HealthBalanceItem,
      2: TestButtonItem,
    };
  }

  dynamic getItem(int position, ProfileState state) {
    final itemType = _itemOrder[position];
    switch (itemType) {
      case HeaderItem:
        return state.headerItem;
      case HealthBalanceItem:
        return state.healthBalanceItem;
      case TestButtonItem:
        return state.testButtonItem;
    }
  }

  int listLength() => _itemOrder.length;
}
