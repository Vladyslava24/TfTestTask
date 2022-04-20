import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class UserEquipmentScreen extends StatefulWidget {
  final Function(List<Equipment>) onNext;

  UserEquipmentScreen({@required this.onNext});

  @override
  _UserEquipmentScreenState createState() => _UserEquipmentScreenState();
}

class _UserEquipmentScreenState extends State<UserEquipmentScreen> {
  Set<Equipment> _selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorScheme.colorPrimaryBlack,
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(S.of(context).onboarding_user_equipment_screen_title,
                style: title30, textAlign: TextAlign.left),
          ),
        ),
        SizedBox(height: 24),
        Expanded(child: SizedBox.shrink()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            verticalDirection: VerticalDirection.down,
            runSpacing: 12,
            spacing: 8,
            children:
                Equipment.values.map((e) => EquipmentChipData(e, e.getName(context))).map((data) {
              return ChipWidget(
                isSelected: _selectedItems.contains(data.equipment),
                chipData: data,
                onSelected: (isSelected) {
                  if (isSelected) {
                    _selectedItems.add(data.equipment);
                  } else {
                    _selectedItems.remove(data.equipment);
                  }
                  setState(() {});
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
          child: BaseElevatedButton(
            text: S.of(context).all__continue,
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Future.delayed(Duration(milliseconds: 100), () {
                if (mounted) {
                  widget.onNext(_selectedItems.toList());
                }
              });
            },
            isEnabled: _selectedItems.isNotEmpty,
          ),
        )
      ]),
    );
  }
}


