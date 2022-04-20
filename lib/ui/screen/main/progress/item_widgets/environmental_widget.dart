import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/environment_model.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/ui/widgets/measure_size.dart';
import 'package:ui_kit/ui_kit.dart';

class EnvironmentalListItemWidget extends StatefulWidget {
  final EnvironmentalListItem item;
  final Function(int) onSaveValue;

  EnvironmentalListItemWidget({
    @required this.item,
    @required this.onSaveValue,
    @required key,
  }) : super(key: key);

  @override
  EnvironmentalListItemWidgetState createState() =>
      EnvironmentalListItemWidgetState();
}

class EnvironmentalListItemWidgetState
    extends State<EnvironmentalListItemWidget> {
  bool isCollapsed = false;

  @override
  void initState() {
    isCollapsed = widget.item.environmentModel.isDisabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      duration: Duration(milliseconds: 200),
      child: isCollapsed
          ? CollapsedStateWidget(
              item: widget.item,
              onSwitchState: () {
                setState(() {
                  if (widget.item.environmentModel.isEnable) {
                    isCollapsed = !isCollapsed;
                  }
                });
              })
          : ExpandedStateWidget(
              item: widget.item,
              onSaveValue: (value) {
                setState(
                  () {
                    if (widget.item.environmentModel.isEnable) {
                      isCollapsed = !isCollapsed;
                    }
                    widget.onSaveValue(value);
                  },
                );
              },
            ),
    );
  }
}

class CollapsedStateWidget extends StatefulWidget {
  final EnvironmentalListItem item;
  final VoidCallback onSwitchState;

  CollapsedStateWidget({
    @required this.item,
    @required this.onSwitchState,
  });

  @override
  CollapsedStateWidgetState createState() => CollapsedStateWidgetState();
}

class CollapsedStateWidgetState extends State<CollapsedStateWidget> {
  double _imageHeight;

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 16, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColorScheme.colorYellow,
                    border: Border.all(
                      color: AppColorScheme.colorYellow,
                      width: 2,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 2.5,
                  child: Opacity(
                    opacity: 1.0,
                    child: SvgPicture.asset(
                      checkIc,
                      width: 12,
                      height: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            key: ValueKey<int>(2),
            child: InkWell(
              borderRadius: BorderRadius.circular(cardBorderRadius),
              onTap: widget.onSwitchState,
              child: MeasureSize(
                onChange: (size) {
                  setState(() {
                    _imageHeight = size.height;
                  });
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                AppColorScheme.colorPrimaryBlack,
                                BlendMode.saturation,
                              ),
                              child: TfImage(
                                url: widget
                                    .item.environmentModel.collapsedStateImage,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 105,
                              ),
                            ),
                            Container(
                              height: 105,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColorScheme.colorBlack2.withOpacity(0.1),
                                    AppColorScheme.colorBlack2,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 12, left: 16, right: 16, bottom: 16),
                          color: AppColorScheme.colorBlack2,
                          child: Text(
                            S.of(context).your_environmental_life,
                            textAlign: TextAlign.left,
                            style: title16.copyWith(
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedStateWidget extends StatefulWidget {
  final EnvironmentalListItem item;
  final Function(int) onSaveValue;

  ExpandedStateWidget({
    @required this.item,
    @required this.onSaveValue,
  });

  @override
  ExpandedStateWidgetState createState() => ExpandedStateWidgetState();
}

class ExpandedStateWidgetState extends State<ExpandedStateWidget> {
  double _currentSliderValue;
  double _selectedValue;
  bool _showActionButton = false;

  @override
  void initState() {
    var model = widget.item.environmentModel;
    _selectedValue = model.environmentalRecord == null
        ? model.maxValue.toDouble()
        : model.environmentalRecord.duration.toDouble();
    _currentSliderValue = _selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(widget.item.environmentModel);
  }

  Widget _buildHeader(EnvironmentModel model) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 105,
            alignment: Alignment.bottomCenter,
            child: TfImage(
              url: model.expandedStateImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: 105,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _selectedValue != model.minValue
                        ? AppColorScheme.colorBlack2.withOpacity(0.5)
                        : Colors.transparent,
                    AppColorScheme.colorBlack2,
                  ]),
            ),
          ),
          Text(
            _formatSelectedTime(_selectedValue.toInt()),
            textAlign: TextAlign.center,
            style: title30.copyWith(
              letterSpacing: 0.42,
              color: AppColorScheme.colorPrimaryWhite,
            ),
          ),
        ],
      );

  Widget _buildQuestion() => Row(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                S.of(context).how_long_outside,
                textAlign: TextAlign.left,
                style: title16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildActionButtons() => Padding(
        key: ValueKey<int>(0),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 7.5,
                        horizontal: 5,
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(AppColorScheme.colorBlack3)),
                child: Text(
                  S.of(context).change_capitalize,
                  style:
                      title14.copyWith(color: AppColorScheme.colorPrimaryWhite),
                ),
                onPressed: () {
                  setState(
                    () {
                      _showActionButton = false;
                    },
                  );
                },
              ),
            ),
            Container(width: 12),
            Flexible(
              fit: FlexFit.tight,
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 7.5,
                        horizontal: 5,
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(AppColorScheme.colorYellow)),
                child: Text(
                  S.of(context).all__save,
                  style: title14.copyWith(color: AppColorScheme.colorBlack),
                ),
                onPressed: () => widget.onSaveValue(_selectedValue.toInt()),
              ),
            ),
          ],
        ),
      );

  Widget _buildSlider(EnvironmentModel model) => Padding(
        key: ValueKey<int>(1),
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            Container(
              height: 18,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoSlider(
                      value: _currentSliderValue,
                      min: model.minValue.toDouble(),
                      max: model.maxValue.toDouble(),
                      activeColor: AppColorScheme.colorYellow,
                      thumbColor: AppColorScheme.colorYellow,
                      divisions: (model.maxValue - model.minValue).toInt(),
                      onChangeEnd: (double newValue) {
                        setState(() {
                          _selectedValue = newValue;
                          _showActionButton = true;
                        });
                      },
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                          _selectedValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.minValueTitle.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: textRegular10.copyWith(
                    color: AppColorScheme.colorBlack6,
                  ),
                ),
                Text(
                  model.maxValueTitle.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: textRegular10.copyWith(
                    color: AppColorScheme.colorBlack6,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildBodyContent(EnvironmentModel model) => Column(
        children: <Widget>[
          _buildQuestion(),
          Container(height: 11),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child:
                _showActionButton ? _buildActionButtons() : _buildSlider(model),
          ),
        ],
      );

  Widget _buildContent(EnvironmentModel model) {
    return Padding(
      key: ValueKey<int>(3),
      padding: const EdgeInsets.only(left: 12, right: 16, bottom: 12, top: 12),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppColorScheme.colorYellow,
                      width: 2,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 2.5,
                  child: Opacity(
                    opacity: 0.0,
                    child: SvgPicture.asset(
                      checkIc,
                      width: 12,
                      height: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cardBorderRadius),
              child: Container(
                color: AppColorScheme.colorBlack2,
                child: Column(
                  children: <Widget>[
                    _buildHeader(model),
                    _buildBodyContent(model),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSelectedTime(int totalMinutes) {
    if (totalMinutes == widget.item.environmentModel.minValue) return "";
    if (totalMinutes == widget.item.environmentModel.maxValue)
      return widget.item.environmentModel.maxValueTitle;

    int hours = totalMinutes ~/ 60;
    var minutes = totalMinutes - hours * 60;
    String minutesText = minutes.toString();
    if (minutes < 10) {
      minutesText = "0$minutes";
    }
    return "$hours:$minutesText ${S.of(context).hours}";
  }
}
