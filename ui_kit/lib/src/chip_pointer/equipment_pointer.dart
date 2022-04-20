import 'package:flutter/cupertino.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';
import 'chip_pointer.dart';

enum Equipment {
  noEquipment,
  kettleBell,
  barbell,
  airBike,
  rowingMachine,
  pullUpBar,
  dumbbells,
  bench,
  box
}

class EquipmentChipData extends ChipData {
  final Equipment equipment;

  EquipmentChipData(this.equipment, String name)
      : super(
            name: name,
            selectedIcon: null,//equipment.getSelectedIcon(),
            unselectedIcon: null);//equipment.getUnselectedIcon());
}

extension EquipmentItemX on Equipment {
  String getName(BuildContext context) {
    switch (this) {
      case Equipment.noEquipment:
        return S.of(context).equipment_item_no_equipment;
      case Equipment.kettleBell:
        return S.of(context).equipment_item_kettlebell;
      case Equipment.barbell:
        return S.of(context).equipment_item_barbell;
      case Equipment.airBike:
        return S.of(context).equipment_item_air_bike;
      case Equipment.rowingMachine:
        return S.of(context).equipment_item_rowing_machine;
      case Equipment.pullUpBar:
        return S.of(context).equipment_item_pull_up_bar;
      case Equipment.dumbbells:
        return S.of(context).equipment_item_dumbbells;
      case Equipment.bench:
        return S.of(context).equipment_item_bench;
      case Equipment.box:
        return S.of(context).equipment_item_box;
      default:
        return "";
    }
  }

  String? getUnselectedIcon() {
    switch (this) {
      case Equipment.noEquipment:
        return null;
      case Equipment.kettleBell:
        return kettlebellIcon;
      case Equipment.barbell:
        return barbellIcon;
      case Equipment.airBike:
        return stationaryBikeIcon;
      case Equipment.rowingMachine:
        return rowingMachineIcon;
      case Equipment.pullUpBar:
        return pullUpBarIcon;
      case Equipment.dumbbells:
        return dumbbellIcon;
      case Equipment.bench:
        return benchUnSelectedIcon;
      case Equipment.box:
        return boxSelectedIcon;
      default:
        return null;
    }
  }

  String? getSelectedIcon() {
    switch (this) {
      case Equipment.noEquipment:
        return null;
      case Equipment.kettleBell:
        return kettlebellSelectedIcon;
      case Equipment.barbell:
        return barbellSelectedIcon;
      case Equipment.airBike:
        return stationaryBikeSelectedIcon;
      case Equipment.rowingMachine:
        return rowingMachineSelectedIcon;
      case Equipment.pullUpBar:
        return pullUpBarSelectedIcon;
      case Equipment.dumbbells:
        return dumbbellSelectedIcon;
      case Equipment.bench:
        return benchSelectedIcon;
      case Equipment.box:
        return boxSelectedIcon;
      default:
        return null;
    }
  }

  String? getServerName() {
    switch (this) {
      case Equipment.noEquipment:
        return 'No equipment';
      case Equipment.kettleBell:
        return 'Kettlebell';
      case Equipment.barbell:
        return 'Barbell';
      case Equipment.airBike:
        return 'Air Bike';
      case Equipment.rowingMachine:
        return 'Rowing Machine';
      case Equipment.pullUpBar:
        return 'Pull-up Bar';
      case Equipment.dumbbells:
        return 'Dumbbells';
      case Equipment.bench:
        return 'Bench';
      case Equipment.box:
        return 'Box';
      default:
        return null;
    }
  }
}

Equipment? equipmentPointerFromServerName(String name) {
  switch (name) {
    case 'No equipment':
      return Equipment.noEquipment;
    case 'Kettlebell':
      return Equipment.kettleBell;
    case 'Barbell':
      return Equipment.barbell;
    case 'Air Bike':
      return Equipment.airBike;
    case 'Rowing Machine':
      return Equipment.rowingMachine;
    case 'Pull-up Bar':
      return Equipment.pullUpBar;
    case 'Dumbbells':
      return Equipment.dumbbells;
    case 'Bench':
      return Equipment.bench;
    case 'Box':
      return Equipment.box;
    default:
      return null;
  }
}
