import 'package:core/generated/l10n.dart';
enum FieldError { Empty, InvalidEmail, InvalidPassword }
final s = S();

String generateErrorText(FieldError error) {
  switch (error) {
    case FieldError.Empty:
      return s.errors_field_empty;
    case FieldError.InvalidEmail:
      return s.errors_field_invalid_email;
    case FieldError.InvalidPassword:
      return s.errors_field_invalid_password;
    default:
      return '';
  }
}