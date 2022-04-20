import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/common/strings.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:totalfit/ui/widgets/country_picker_field.dart';
import 'package:totalfit/ui/widgets/date_picker_input_field.dart';
import 'package:totalfit/ui/widgets/gender_picker_field.dart';
import 'package:totalfit/ui/widgets/input_field_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  ScrollController _controller;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final ValueNotifier<DateTime> _birthDayNotifier = ValueNotifier<DateTime>(DateTime.now());

  FocusNode _firstNameNode = FocusNode();
  FocusNode _lastNameNode = FocusNode();
  FocusNode _birthdayNode = FocusNode();
  FocusNode _genderNode = FocusNode();
  FocusNode _heightNode = FocusNode();
  FocusNode _weightNode = FocusNode();
  FocusNode _countryNode = FocusNode();
  FocusNode _cityNode = FocusNode();
  String _firstNameError;
  String _lastNameError;
  String _birthdayError;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.fromStore,
        onInit: (store) {
          _controller = ScrollController();
          final user = store.state.loginState.user;
          _firstNameController.text = user.firstName;
          _lastNameController.text = user.lastName;
          _birthdayController.text = user.birthday != null ? unifiedUiDateFormat(DateTime.parse(user.birthday)) : '';
          _genderController.text = user.gender == null ? '' : user.gender.toString();
          _heightController.text = user.height;
          _weightController.text = user.weight;
          _countryController.text = user.country;
          _cityController.text = user.city;

          _birthDayNotifier.value =
              user.birthday != null && user.birthday.isNotEmpty ? DateTime.parse(user.birthday) : null;
          _birthDayNotifier.addListener(() {
            setState(() {
              validateBirthday();
            });
          });
        },
        onDispose: (store) {
          _controller.dispose();
          _firstNameController.dispose();
          _lastNameController.dispose();
          _birthdayController.dispose();
          _genderController.dispose();
          _heightController.dispose();
          _weightController.dispose();
          _countryController.dispose();
          _cityController.dispose();
          _firstNameNode.dispose();
          _lastNameNode.dispose();
          _birthdayNode.dispose();
          _genderNode.dispose();
          _heightNode.dispose();
          _weightNode.dispose();
          _countryNode.dispose();
          _cityNode.dispose();
        },
        onWillChange: (oldVm, newVm) async {
          if (newVm.error is! IdleException) {
            _handleError(newVm);
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Future<void> _handleError(_ViewModel vm) async {
    _firstNameNode.unfocus();
    _lastNameNode.unfocus();
    _birthdayNode.unfocus();
    _genderNode.unfocus();
    _heightNode.unfocus();
    _weightNode.unfocus();
    _countryNode.unfocus();
    _cityNode.unfocus();
    vm.clearSavingException();

    if (vm.error != null && vm.error is! IdleException) {
      final attrs = TfDialogAttributes(
        title: S.of(context).filed_to_update_profile,
        description: vm.error.getMessage(context),
        negativeText: S.of(context).dialog_error_recoverable_negative_text,
        positiveText: S.of(context).all__retry,
      );
      final result = await TfDialog.show(context, attrs);
      if (result is Confirm) {
        _updateProfile(vm);
      }
    }
  }

  void _updateProfile(_ViewModel vm) {
    setState(() {
      validateTextFields();
    });
    if (_firstNameError == null && _lastNameError == null && _birthdayError == null) {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final birthday = _birthdayController.text.isNotEmpty ? toServerDateFormat(_birthdayController.text) : null;
      final height = _heightController.text;
      final weight = _weightController.text;
      final country = _countryController.text;
      final city = _cityController.text;
      final gender = _genderController.text.isEmpty ? Gender.MALE : Gender.fromString(_genderController.text);

      final updatedUser = vm.user.copyWith(
          firstName: firstName,
          lastName: lastName,
          birthday: birthday,
          height: height,
          weight: weight,
          country: country,
          gender: gender,
          city: city);

      vm.updateProfile(updatedUser);
    }
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        appBar: SimpleAppBar(
          leadingType: LeadingType.back,
          leadingAction: () => Navigator.of(context).pop(),
          actionType: ActionType.button,
          actionButtonText: S.of(context).all__save,
          actionFunction: () => _updateProfile(vm),
        ),
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: _buildItemList(vm),
        ),
      );

  ///ListView is used for the same actionbar controller positioning as on previous screen
  Widget _buildItemList(_ViewModel vm) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: ListView.builder(
              controller: _controller,
              key: ValueKey("profile_list"),
              itemCount: 1,
              itemBuilder: (context, index) => _buildSingleScrollableListItem(vm)),
        ),
        _progressIndicator(vm),
      ],
    );
  }

  Widget _buildSingleScrollableListItem(_ViewModel vm) {
    return Column(
      children: <Widget>[
        _buildHeader(vm),
        _firstNameInput(),
        _lastNameInput(),
        _birthDayInput(),
        _genderDayInput(),
        _heightInput(),
        _weightInput(),
        _countryInput(),
        _cityInput(),
      ],
    );
  }

  Widget _buildHeader(_ViewModel vm) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  final imageSource = await showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.of(context).pop(ImageSource.gallery);
                          },
                          child: Text(
                            S.of(context).gallery,
                            style: textRegular16.copyWith(
                              color: AppColorScheme.colorPrimaryBlack,
                            ),
                          ),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.of(context).pop(ImageSource.camera);
                          },
                          child: Text(
                            S.of(context).camera,
                            style: textRegular16.copyWith(
                              color: AppColorScheme.colorPrimaryBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (imageSource != null) {
                    final pickedFile = await _picker.getImage(source: imageSource, maxWidth: 250, imageQuality: 40);
                    if (pickedFile != null && pickedFile.path != null) {
                      final img.Image capturedImage = img.decodeImage(await File(pickedFile.path).readAsBytes());
                      final img.Image orientedImage = img.bakeOrientation(capturedImage);
                      await File(pickedFile.path).writeAsBytes(img.encodeJpg(orientedImage));
                      vm.updateProfileImage(pickedFile.path);
                    }
                  }
                },
                child: Container(
                  width: 86,
                  height: 86,
                  margin: EdgeInsets.only(top: 12),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 86,
                        height: 86,
                        child: CircleAvatar(
                          backgroundColor: AppColorScheme.colorBlack4.withOpacity(0.9),
                          radius: 35,
                          backgroundImage: vm.user.photo != null ? NetworkImage(vm.user.photo) : null,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorScheme.colorBlack2.withOpacity(0.7),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColorScheme.colorPrimaryWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _firstNameInput() => InputField(
        errorMessage: _firstNameError,
        focusNode: _firstNameNode,
        nextFocusNode: _lastNameNode,
        textEditingController: _firstNameController,
        onChanged: (firstName) {
          setState(() {
            validateFirstName();
          });
        },
        label: S.of(context).first_name,
        keyboardType: TextInputType.text,
      );

  Widget _lastNameInput() => InputField(
        errorMessage: _lastNameError,
        focusNode: _lastNameNode,
        nextFocusNode: _birthdayNode,
        textEditingController: _lastNameController,
        onChanged: (lastName) {
          setState(() {
            //validateLastName();
          });
        },
        label: S.of(context).last_name,
        keyboardType: TextInputType.text,
      );

  Widget _birthDayInput() => DatePickerInputField(
        errorMessage: _birthdayError,
        focusNode: _birthdayNode,
        nextFocusNode: _genderNode,
        textEditingController: _birthdayController,
        dateNotifier: _birthDayNotifier,
        onClearError: () {
          setState(() {
            _birthdayError = null;
          });
        },
        onChanged: (dateTime) {
          setState(() {
            _birthdayError = null;
          });
          if (dateTime != null) {
            print(dateTime);
            setState(() {
              _birthdayController.text = dateTime;
              _birthDayNotifier.value = convertServerDateToCorrect(dateTime);
              validateBirthday();
            });
          }
        },
        label: S.of(context).birthday,
        keyboardType: TextInputType.text,
      );

  Widget _genderDayInput() => GenderPickerField(
        errorMessage: null,
        focusNode: _genderNode,
        nextFocusNode: _heightNode,
        textEditingController: _genderController,
        onClearError: () {},
        onChanged: (gender) {
          _genderController.text = gender;
        },
        label: S.of(context).gender,
      );

  Widget _countryInput() => CountryPickerField(
        errorMessage: null,
        focusNode: _countryNode,
        nextFocusNode: _cityNode,
        textEditingController: _countryController,
        onClearError: () {},
        label: S.of(context).country,
        keyboardType: TextInputType.text,
      );

  Widget _heightInput() => InputField(
        errorMessage: null,
        focusNode: _heightNode,
        nextFocusNode: _weightNode,
        textEditingController: _heightController,
        onClearError: () {},
        onChanged: (lastName) {},
        label: S.of(context).height,
        keyboardType: TextInputType.number,
      );

  Widget _weightInput() => InputField(
        errorMessage: null,
        focusNode: _weightNode,
        nextFocusNode: _countryNode,
        textEditingController: _weightController,
        onClearError: () {},
        onChanged: (lastName) {},
        label: S.of(context).weight,
        keyboardType: TextInputType.number,
      );

  Widget _cityInput() => InputField(
        errorMessage: null,
        focusNode: _cityNode,
        textEditingController: _cityController,
        onClearError: () {},
        onChanged: (lastName) {},
        label: S.of(context).city,
        keyboardType: TextInputType.text,
      );

  void validateBirthday() {
    final DateTime now = DateTime.now();
    int d16Years = 16 * 365;
    final birthdayValue = _birthDayNotifier.value;

    final selected = birthdayValue != null ? now.difference(_birthDayNotifier.value).inDays : 0;

    if (birthdayValue != null && selected < d16Years) {
      _birthdayError = birthday_error;
    } else {
      _birthdayError = null;
    }
  }

  void validateFirstName() {
    final firstName = _firstNameController.text;
    if (firstName.isEmpty) {
      _firstNameError = empty_field_error;
    } else {
      _firstNameError = null;
    }
  }

  void validateLastName() {
    final lastName = _lastNameController.text;
    if (lastName.isEmpty) {
      _lastNameError = empty_field_error;
    } else {
      _lastNameError = null;
    }
  }

  void validateTextFields() {
    validateFirstName();
    //validateLastName();
    validateBirthday();
  }

  _progressIndicator(_ViewModel vm) => vm.isLoading ? DimmedCircularLoadingIndicator() : Container();
}

class _ViewModel {
  final User user;
  final bool isLoading;
  final TfException error;
  final Function(User) updateProfile;
  final Function(String) updateProfileImage;
  final Function clearSavingException;

  _ViewModel({
    @required this.user,
    @required this.isLoading,
    @required this.error,
    @required this.updateProfile,
    @required this.clearSavingException,
    @required this.updateProfileImage,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        user: store.state.loginState.user,
        isLoading: store.state.profileEditScreenState.isLoading,
        error: store.state.profileEditScreenState.error,
        updateProfile: (user) => store.dispatch(UpdateProfileAction(user: user)),
        updateProfileImage: (imagePath) => store.dispatch(UpdateProfileImageAction(imagePath: imagePath)),
        clearSavingException: () => store.dispatch(ClearEditProfileExceptionAction()),
      );
}
