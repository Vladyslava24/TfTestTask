import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_ui/src/preview/list_item/list_items.dart';
import 'package:workout_ui/src/preview/widget/workout_actions_widget.dart';

class WorkoutSliverAppBar extends StatefulWidget {
  final HeaderItem data;
  final bool isChangedAppBarToMin;
  final WorkoutFixedActionsWidget fixedActions;

  const WorkoutSliverAppBar({
    required this.isChangedAppBarToMin,
    required this.data,
    required this.fixedActions,
    Key? key
  }) : super(key: key);

  @override
  _WorkoutSliverAppBarState createState() => _WorkoutSliverAppBarState();
}

class _WorkoutSliverAppBarState extends State<WorkoutSliverAppBar> {
  double flexibleOpacityLevel = 1.0;
  double titleOpacityLevel = 0.0;

  static const int _animationDuration = 150;

  final localization = DependencyProvider.get<WorkoutLocalizations>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WorkoutSliverAppBar oldWidget) {
    flexibleOpacityLevel = widget.isChangedAppBarToMin ? 0.0 : 1.0;
    titleOpacityLevel = widget.isChangedAppBarToMin ? 1.0 : 0.0;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: 360.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light
      ),
      leading: IconBackCircleWidget(
        margin: const EdgeInsets.only(left: 12.0),
        action: () => Navigator.of(context).pop()),
      actions: [
        widget.fixedActions
      ],
      automaticallyImplyLeading: false,
      centerTitle: true,
      backwardsCompatibility: false,
      title: _buildTitle(),
      flexibleSpace: _buildFlexibleSpaceBar());
  }

  Widget _buildTitle() => AnimatedOpacity(
    opacity: titleOpacityLevel,
    duration: const Duration(milliseconds: _animationDuration),
    child: Text(
      widget.data.title.capitalize(),
      style: title20,
      textAlign: TextAlign.center,
    ),
  );

  FlexibleSpaceBar _buildFlexibleSpaceBar() => FlexibleSpaceBar(
    titlePadding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
    centerTitle: false,
    collapseMode: CollapseMode.pin,
    stretchModes: const [
      StretchMode.zoomBackground, // zoom effect
      StretchMode.fadeTitle, // fade effect
    ],
    title: AnimatedOpacity(
      opacity: flexibleOpacityLevel,
      duration: const Duration(milliseconds: _animationDuration),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.title.capitalize(),
            style: title30,
            textAlign: TextAlign.left,
          ),
        ],
      ),

    ),
    background: Container(
      color: AppColorScheme.colorBlack,
      child: Stack(
        fit: StackFit.expand,
        children: [
          TfImage(url: widget.data.image),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 16.0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColorScheme.colorBlack,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                border: Border.all(
                  color: AppColorScheme.colorBlack,
                  width: 0,
                ),
              ),
            ),
          ),
        ]
      ),
    ),
  );
}