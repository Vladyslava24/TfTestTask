part of 'entry_bloc.dart';

@immutable
class EntryState extends Equatable {
  final bool privacyChecked;
  final bool emailNotificationAllowed;
  final bool showTooltip;
  final FormStatus formStatus;
  final User user;
  final SignUpType type;
  final TfException error;

  const EntryState._(
      {this.privacyChecked,
      this.emailNotificationAllowed,
      this.showTooltip,
      this.formStatus,
      this.user,
      this.type,
      this.error});

  EntryState copyWith(
      {bool privacyChecked,
      bool emailNotificationAllowed,
      bool showTooltip,
      FormStatus formStatus,
      User user,
      SignUpType type,
      TfException error}) {
    return EntryState._(
        privacyChecked: privacyChecked ?? this.privacyChecked,
        emailNotificationAllowed: emailNotificationAllowed ?? this.emailNotificationAllowed,
        showTooltip: showTooltip ?? this.showTooltip,
        formStatus: formStatus ?? this.formStatus,
        user: user ?? this.user,
        type: type ?? this.type,
        error: error ?? this.error);
  }

  factory EntryState.initial() => EntryState._(
      privacyChecked: false,
      emailNotificationAllowed: false,
      showTooltip: false,
      formStatus: FormStatus.pure,
      user: null,
      type: null,
      error: null);

  @override
  List<Object> get props => [privacyChecked, emailNotificationAllowed, showTooltip, formStatus, user, type, error];
}
