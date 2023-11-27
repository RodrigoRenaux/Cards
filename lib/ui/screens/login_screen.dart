import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:target_cards/themes/colors.dart';
import 'package:target_cards/ui/components/custom_text_field.dart';
import 'package:target_cards/ui/components/privacy_policy_button.dart';
import 'package:target_cards/ui/screens/cards_screen.dart';
import 'package:target_cards/values/helpers/string_validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? user;
  String? password;

  void _navigate() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint("Usuário logado: $user - $password");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CardsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
          decoration: BoxDecoration(gradient: AppColors.appBackgroundColor),
          child: ResponsiveBuilder(builder: (context, sizingInformation) {
            var fieldSize = sizingInformation.screenSize.height * .1;
            var horizontalPadding = sizingInformation.screenSize.width * .06;
            var verticalMargin = horizontalPadding * 2;
            var buttonWidth = sizingInformation.screenSize.width * .6;
            var buttonHeight = sizingInformation.screenSize.height * .06;
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: verticalMargin),
                          Column(children: [
                            CustomTextField(
                                tittle: "Usuário",
                                fieldHeight: fieldSize,
                                inputAction: TextInputAction.next,
                                icon:
                                    Icon(Icons.person, color: AppColors.black),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Insira o seu usuário";
                                  }
                                  user = value.removeWhiteSpaceFromEnd;
                                  if (!StringValidator.numberOfCharacters(
                                      user!, null, 20)) {
                                    return "Usuário deve ter no máximo 20 caracteres";
                                  }
                                }),
                            CustomTextField(
                                tittle: "Senha",
                                fieldHeight: fieldSize,
                                inputAction: TextInputAction.done,
                                onDone: (String text) => _navigate(),
                                icon: Icon(Icons.lock, color: AppColors.black),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Insira sua senha";
                                  }
                                  password = value.removeWhiteSpaceFromEnd;
                                  if (!StringValidator.numberOfCharacters(
                                      password!, 2, 20)) {
                                    return "Senha deve ter entre 2 a 20 caracteres";
                                  }
                                  if (!password!.isValidPassword) {
                                    return "Senha não pode ter caracteres especiais";
                                  }
                                }),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: buttonHeight * .4),
                                child: InkWell(
                                    onTap: () => _navigate(),
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width: buttonWidth,
                                        height: buttonHeight,
                                        decoration: BoxDecoration(
                                            color: AppColors.green,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        alignment: Alignment.center,
                                        child: Text('Entrar',
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 16)))))
                          ]),
                          Padding(
                              padding: EdgeInsets.only(bottom: verticalMargin),
                              child: const PrivacyPolicyButton())
                        ])));
          })),
    );
  }
}
