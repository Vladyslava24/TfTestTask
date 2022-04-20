import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/src/widget/icon_button/icon_back_widget.dart';
import 'package:ui_kit/src/widget/app_bar/app_bar_button_widget.dart';
import 'package:ui_kit/src/widget/app_bar/app_bar_description_widget.dart';
import 'package:ui_kit/src/widget/app_bar/app_bar_title_widget.dart';
import 'package:ui_kit/src/widget/icon_button/icon_close_circle_widget.dart';
import 'package:ui_kit/src/widget/icon_button/icon_settings_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double mainAppBarH = 56.0;

  final String? title;
  final String? description;
  final LeadingType leadingType;
  final String? leadingText;
  final Function? leadingAction;
  final Color? leadingColor;
  final ActionType actionType;
  final ButtonType buttonType;
  final Function? actionFunction;
  final String? actionButtonText;
  final bool buttonWithArrow;
  final PreferredSizeWidget? bottom;
  final Color backgroundColor;

  const SimpleAppBar({
    this.title,
    this.description,
    this.leadingText,
    this.leadingType = LeadingType.empty,
    this.leadingAction,
    this.actionType = ActionType.empty,
    this.buttonType = ButtonType.text,
    this.actionFunction,
    this.actionButtonText,
    this.buttonWithArrow = false,
    this.leadingColor,
    this.bottom,
    this.backgroundColor = Colors.transparent,
    Key? key
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(mainAppBarH);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      leadingWidth: leadingType == LeadingType.button ? 120.0 : 56.0,
      leading:
        leadingType == LeadingType.back ?
          IconBackWidget(action: leadingAction, iconColor: leadingColor) :
        leadingType == LeadingType.backCircle ?
          IconBackCircleWidget(action: leadingAction) :
        leadingType == LeadingType.button ? AppBarButtonWidget(
          text: leadingText,
          action: leadingAction,
          buttonType: buttonType,
        ) :
        leadingType == LeadingType.settings ?
        IconSettingsWidget.leading(action: leadingAction) : null,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBarTitleWidget(title: title),
          AppBarDescriptionWidget(description: description)
        ],
      ),
      actions: [
        actionType == ActionType.lock ?
          const IconLockWidget() :
        actionType == ActionType.close ?
          IconCloseWidget(action: actionFunction) :
        actionType == ActionType.closeCircle ?
          IconCloseCircleWidget(action: actionFunction!) :
        actionType == ActionType.closeCircleLight ?
          IconCloseCircleWidget(
            action: actionFunction!,
            backgroundColor: AppColorScheme.colorPrimaryWhite,
            iconColor: AppColorScheme.colorBlack3,
          ) :
        actionType == ActionType.settings ?
          IconSettingsWidget.actions(action: actionFunction) :
        actionType == ActionType.button ?
          AppBarButtonWidget(
            text: actionButtonText,
            action: actionFunction,
            withArrow: buttonWithArrow,
            buttonType: buttonType,
          ) : const SizedBox()
      ],
      bottom: bottom,
    );
  }
}

enum LeadingType { back, backCircle, button, settings, empty }
enum ActionType { settings, closeCircle, closeCircleLight, close, lock, empty, button }