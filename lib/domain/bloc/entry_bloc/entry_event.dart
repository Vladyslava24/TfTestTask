part of 'entry_bloc.dart';

abstract class EntryEvent extends Equatable {
  const EntryEvent();
}

class ChangePrivacyChecked extends EntryEvent {
  final bool checked;
  const ChangePrivacyChecked(this.checked);

  @override
  List<Object> get props => [checked];
}

class ChangeEmailNotificationAllowance extends EntryEvent {
  final bool checked;
  const ChangeEmailNotificationAllowance(this.checked);

  @override
  List<Object> get props => [checked];
}

class ChangeShowTooltip extends EntryEvent {
  final bool value;
  const ChangeShowTooltip(this.value);

  @override
  List<Object> get props => [value];
}

class SignUpWithSocial extends EntryEvent {
  final SignUpType type;
  const SignUpWithSocial(this.type);

  @override
  List<Object> get props => [type];
}
