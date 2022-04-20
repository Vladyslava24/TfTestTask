import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AuthTypeSelector extends StatelessWidget {
  final String googleBtnText;
  final String appleBtnText;
  final VoidCallback onGoogleTap;
  //final VoidCallback onFacebookTap;
  final VoidCallback onAppleTap;

  const AuthTypeSelector({
    @required this.googleBtnText,
    @required this.appleBtnText,
    @required this.onGoogleTap,
    //@required this.onFacebookTap,
    @required this.onAppleTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Expanded(
        //         child: BaseElevatedButton(
        //       image: btnImageFacebook,
        //       text: "Facebook",
        //       iconSpace: 16,
        //       textColor: Color(0xFF3578EA),
        //       fontFamily: 'Gilroy',
        //       backgroundColor: AppColorScheme.colorPrimaryWhite,
        //       onPressed: onFacebookTap,
        //     ))
        //   ],
        // ),
        BaseElevatedButton(
          image: btnImageGoogle,
          text: googleBtnText,
          fontFamily: 'Roboto',
          iconSpace: 13,
          textColor: AppColorScheme.colorBlack4,
          backgroundColor: AppColorScheme.colorPrimaryWhite,
          onPressed: onGoogleTap,
        ),
        SizedBox(height: 16),
        Platform.isIOS
            ? BaseElevatedButton(
                icon: SocialIcons.apple_logo,
                backgroundColor: AppColorScheme.colorPrimaryWhite,
                text: appleBtnText,
                onPressed: onAppleTap,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
