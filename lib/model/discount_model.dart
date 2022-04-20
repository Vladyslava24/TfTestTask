import 'package:equatable/equatable.dart';

class DiscountModel extends Equatable {
  final bool isShowing;

  const DiscountModel({
    this.isShowing = true
  });

  DiscountModel copyWith({
    bool isShowing
  }) => DiscountModel(
    isShowing: isShowing ?? this.isShowing
  );

  @override
  List<Object> get props => [isShowing];
}