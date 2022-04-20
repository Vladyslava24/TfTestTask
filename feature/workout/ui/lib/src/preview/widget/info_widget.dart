import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/preview/list_item/list_items.dart';

class InfoWidget extends StatelessWidget {
  final String detailsTitle;
  final String equipmentTitle;
  final InfoItem item;

  const InfoWidget({
    required this.item,
    this.detailsTitle = '',
    this.equipmentTitle = '',
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(detailsTitle, style: title20),
          const SizedBox(height: 12.0),
          Wrap(
            verticalDirection: VerticalDirection.down,
            runSpacing: 12.0,
            spacing: 8.0,
            children: WorkoutDetail.values.map((e) {
              return IgnorePointer(
                child: ChipWidget(
                  isSelected: false,
                  chipData: WorkoutChipData(
                    e,
                    e == WorkoutDetail.level ?
                      item.level :
                    e == WorkoutDetail.duration ?
                      item.duration : ''
                  ),
                  onSelected: (selected) {},
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32.0),
          Text(equipmentTitle, style: title20),
          const SizedBox(height: 12.0),
          Wrap(
            verticalDirection: VerticalDirection.down,
            runSpacing: 12.0,
            spacing: 8.0,
            children: item.equipment
              .map((e) => equipmentPointerFromServerName(e))
              .whereType<Equipment>()
              .map((item) {
                return IgnorePointer(
                  child: ChipWidget(
                    isSelected: false,
                    chipData: EquipmentChipData(item, item.getName(context)),
                    onSelected: (selected) {},
                  ),
                );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
