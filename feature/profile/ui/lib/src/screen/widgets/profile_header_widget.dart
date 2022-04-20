import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:core/core.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final User? user;
  final VoidCallback navigateToEditProfile;
  final VoidCallback navigateToSettings;

  ProfileHeaderWidget({
    required this.user,
    required this.navigateToEditProfile,
    required this.navigateToSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                      width: 86,
                      height: 86,
                      margin: EdgeInsets.only(top: 12),
                      child: CircleAvatar(
                        child: user != null && user?.photo == null
                            ? Text(
                                _getInitials(),
                                style: title30.copyWith(
                                  color: AppColorScheme.colorPrimaryWhite,
                                ),
                              )
                            : null,
                        backgroundColor:
                            AppColorScheme.colorBlack3.withOpacity(0.9),
                        radius: 35,
                        backgroundImage: user != null && user?.photo != null
                            ? NetworkImage(user!.photo!)
                            : null,
                      )),
                  Container(height: 12),
                ],
              ),
            ),
          ],
        ),
        Container(height: 18),
      ],
    );
  }

  String _getInitials() {
    return '${user != null || user!.firstName.isEmpty ? '' : user?.firstName.substring(0, 1).toUpperCase()}';
  }
}
