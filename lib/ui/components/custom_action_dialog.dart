import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:target_cards/themes/colors.dart';

class CustomActionDialog extends StatelessWidget {
  const CustomActionDialog(
      {required this.text, required this.customAction, this.subText, Key? key})
      : super(key: key);

  final String text;
  final String? subText;
  final Function() customAction;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ResponsiveBuilder(builder: (context, sizingInformation) {
          var dialogSize = subText != null
              ? sizingInformation.screenSize.height * .24
              : sizingInformation.screenSize.height * .2;
          return SizedBox(
            height: dialogSize,
            child: Padding(
              padding: EdgeInsets.all(dialogSize * .08),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (subText != null)
                      Text(subText!, textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Cancelar",
                                style: TextStyle(color: AppColors.red))),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightGreen),
                            onPressed: () => customAction(),
                            child: Text("Confirmar",
                                style: TextStyle(color: AppColors.white)))
                      ],
                    )
                  ]),
            ),
          );
        }));
  }
}
