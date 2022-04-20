import 'package:totalfit/model/sign_up_type.dart';

class SignUpRequest implements SignUpType {
  final String lastName;
  final String birthday;
  final String email;
  final String password;
  final String confirmPassword;
  final bool emailSubscription;

  SignUpRequest(this.emailSubscription,
      {this.lastName, this.birthday, this.email, this.password, this.confirmPassword});

  Map<String, dynamic> toMap() => {
        "lastName": lastName,
        "email": email,
        "birthday": birthday,
        "password": password,
        "confirmPassword": password,
        "emailSubscription": emailSubscription,
      };
}
