import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_data/data.dart';
import 'package:profile_ui/src/screen/profile_cubit.dart';
import 'package:profile_ui/src/screen/profile_state.dart';
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
  Widget buildPage(
      BuildContext context, ProfileCubit bloc, ProfileState state) {
    return _buildContent(user.firstName, bloc, context);
  }

  Widget _buildContent(String name, ProfileCubit bloc, BuildContext context) =>
      Scaffold(
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
            value: SystemUiOverlayStyle.light, child: _buildItemList(bloc)),
      );

  Widget _buildItemList(ProfileCubit bloc) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: _listMapper.listLength(),
          itemBuilder: (context, i) {
            final item = _listMapper.getItem(i, bloc.state);

            if (item is HeaderItem) {
              return ProfileHeaderWidget(
                  user: item.user,
                  navigateToEditProfile: () {},
                  navigateToSettings: () {});
            }
            if (item is TestButtonItem) {
              return ElevatedButton(
                  onPressed: () {
                    bloc.getBodyMindSpiritStatistic(5);
                  },
                  child: Text(
                    'Fetch BodyMindSpiritStatistic',
                  ));
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
      1: TestButtonItem,
    };
  }

  dynamic getItem(int position, ProfileState state) {
    final itemType = _itemOrder[position];
    switch (itemType) {
      case HeaderItem:
        return state.headerItem;
      case TestButtonItem:
        return state.testButtonItem;
    }
  }

  int listLength() => _itemOrder.length;
}
