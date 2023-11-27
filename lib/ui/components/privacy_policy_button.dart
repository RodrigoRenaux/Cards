import 'package:flutter/material.dart';
import 'package:target_cards/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyButton extends StatelessWidget {
  const PrivacyPolicyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text('Política de Privacidade',
            style: TextStyle(color: AppColors.white)),
        onPressed: () async {
          const url = "https://www.google.com/";
          if (!await launchUrl(Uri.parse(url))) {
            throw Exception('Could not launch $url');
          }
        });
  }
}
