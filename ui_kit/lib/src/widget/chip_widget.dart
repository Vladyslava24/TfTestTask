import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/src/chip_pointer/chip_pointer.dart';
import 'package:ui_kit/ui_kit.dart';

class ChipWidget extends StatefulWidget {
  final ChipData chipData;
  final Function(bool)? onSelected;
  final bool isSelected;

  const ChipWidget({
    required this.chipData,
    required this.isSelected,
    this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  _ChipWidgetState createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    return _showImage()
        ? FilterChip(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            label: Text(widget.chipData.name),
            labelStyle: TextStyle(
              color: widget.isSelected
                  ? AppColorScheme.colorBlack
                  : AppColorScheme.colorBlack9,
              fontSize: 16,
            ),
            labelPadding: const EdgeInsets.only(
              top: 2,
              bottom: 2,
              right: 8,
              left: 0,
            ),
            backgroundColor: AppColorScheme.colorBlack4,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: widget.isSelected
                      ? AppColorScheme.colorBlack9
                      : AppColorScheme.colorBlack4,
                  width: 0),
              borderRadius: BorderRadius.circular(8),
            ),
            avatar: _showImage()
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      widget.isSelected
                          ? widget.chipData.selectedIcon!
                          : widget.chipData.unselectedIcon!,
                    ),
                  )
                : const SizedBox.shrink(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onSelected: widget.onSelected,
            selected: widget.isSelected,
            selectedColor: AppColorScheme.colorBlack9,
            showCheckmark: false,
          )
        : FilterChip(
            padding: const EdgeInsets.all(0),
            label: Text(widget.chipData.name),
            labelStyle: TextStyle(
              color: widget.isSelected
                  ? AppColorScheme.colorBlack
                  : AppColorScheme.colorBlack9,
              fontSize: 16,
              height: 1,
            ),
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            backgroundColor: AppColorScheme.colorBlack4,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: widget.isSelected
                      ? AppColorScheme.colorBlack9
                      : AppColorScheme.colorBlack4,
                  width: 0),
              borderRadius: BorderRadius.circular(8),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onSelected: widget.onSelected,
            selected: widget.isSelected,
            selectedColor: AppColorScheme.colorBlack9,
            showCheckmark: false,
          );
  }

  bool _showImage() {
    return (widget.isSelected && widget.chipData.selectedIcon != null) ||
        (!widget.isSelected && widget.chipData.unselectedIcon != null);
  }
}
/*
    return FilterChip(
      padding: EdgeInsets.all(0),
      label: Text(widget.equipmentItem.getName(context)),
      labelStyle: TextStyle(
        color: widget.isSelected ? AppColorScheme.colorBlack : AppColorScheme.colorBlack9,
        fontSize: 16,
        height: 1,
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      backgroundColor: AppColorScheme.colorBlack4,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: widget.isSelected ? AppColorScheme.colorBlack9 : AppColorScheme.colorBlack4, width: 0),
        borderRadius: BorderRadius.circular(8),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onSelected: widget.onSelected,
      selected: widget.isSelected,
      selectedColor: AppColorScheme.colorBlack9,
      showCheckmark: false,
    );
* */
