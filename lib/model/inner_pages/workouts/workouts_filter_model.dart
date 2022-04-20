import 'package:equatable/equatable.dart';

class ChipData extends Equatable {
  final String value;
  final String label;
  final String icon;
  final String iconSelected;
  bool isSelected;
  final String filter;

  ChipData({
    this.label = '',
    this.value = '',
    this.icon = '',
    this.iconSelected = '',
    this.isSelected = false,
    this.filter = '',
  });

  ChipData copyWith({
    String value,
    String label,
    String icon,
    String iconSelected,
    bool isSelected,
    String filter,
  }) =>
      ChipData(
        value: value ?? this.value,
        label: label ?? this.label,
        icon: icon ?? this.icon,
        iconSelected: iconSelected ?? this.iconSelected,
        isSelected: isSelected ?? this.isSelected,
        filter: filter ?? this.filter,
      );

  Map toJson() => {
        'value': value,
        'label': label,
        'icon': icon,
        'iconSelected': iconSelected,
        'isSelected': isSelected,
        'filter': filter,
      };

  factory ChipData.fromJson(Map<String, dynamic> json) {
    return ChipData(
      value: json['value'] as String,
      label: json['label'] as String,
      icon: json['icon'] as String,
      iconSelected: json['iconSelected'] as String,
      isSelected: json['isSelected'] as bool,
      filter: json['filter'] as String,
    );
  }

  @override
  List<Object> get props =>
      [value, label, icon, iconSelected, isSelected, filter];
}
