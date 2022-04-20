import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totalfit/model/inner_pages/workouts/workouts_filter_model.dart';
import 'package:ui_kit/ui_kit.dart';

class TsFilterChip extends StatefulWidget {
  TsFilterChip({
    Key key,
    @required this.currentItem,
    @required this.onSelected,
  }) : super(key: key);

  final ChipData currentItem;
  final Function onSelected;

  @override
  _TsFilterChipState createState() => _TsFilterChipState();
}

class _TsFilterChipState extends State<TsFilterChip> {
  @override
  Widget build(BuildContext context) {
    if (widget.currentItem.icon != null && widget.currentItem.icon.isNotEmpty) {
      return FilterChip(
        padding: EdgeInsets.symmetric(horizontal: 4),
        label: Text(widget.currentItem.label),
        labelStyle: TextStyle(
          color: widget.currentItem.isSelected
              ? AppColorScheme.colorBlack
              : AppColorScheme.colorBlack9,
          fontSize: 16,
        ),
        labelPadding: EdgeInsets.only(
          top: 2,
          bottom: 2,
          right: 8,
          left: 0,
        ),
        backgroundColor: AppColorScheme.colorBlack4,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: widget.currentItem.isSelected
                  ? AppColorScheme.colorBlack9
                  : AppColorScheme.colorBlack4,
              width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
        avatar: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            widget.currentItem.isSelected
                ? widget.currentItem.iconSelected
                : widget.currentItem.icon,
          ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onSelected: widget.onSelected,
        selected: widget.currentItem.isSelected,
        selectedColor: AppColorScheme.colorBlack9,
        showCheckmark: false,
      );
    }

    return FilterChip(
      padding: EdgeInsets.all(0),
      label: Text(widget.currentItem.label),
      labelStyle: TextStyle(
        color: widget.currentItem.isSelected
            ? AppColorScheme.colorBlack
            : AppColorScheme.colorBlack9,
        fontSize: 16,
        height: 1,
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      backgroundColor: AppColorScheme.colorBlack4,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: widget.currentItem.isSelected
                ? AppColorScheme.colorBlack9
                : AppColorScheme.colorBlack4,
            width: 0),
        borderRadius: BorderRadius.circular(8),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onSelected: widget.onSelected,
      selected: widget.currentItem.isSelected,
      selectedColor: AppColorScheme.colorBlack9,
      showCheckmark: false,
    );
  }
}
