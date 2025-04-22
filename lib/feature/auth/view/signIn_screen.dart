import 'package:auto_route/auto_route.dart';
import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/ui/custom_adaptive_button.dart';
import 'package:sound_level_meter/feature/ui/fabric/inputDecorative.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/theme/theme.dart';
import 'package:sound_level_meter/generated/l10n.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  List<Color> colors2 = [
    Color.fromARGB(255, 254, 254, 254),
    Color.fromARGB(255, 184, 172, 172)
  ];
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  bool isButtonEnabled = false;
  bool isHiddenPassword = true;
  final TextEditingController emailTextInputController =
      TextEditingController();
  final TextEditingController passwordTextInputController =
      TextEditingController();
  EmailValidatorFlutter validator = EmailValidatorFlutter();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void toogleToPasswordView() {
    if (mounted) {
      setState(() {
        isHiddenPassword = !isHiddenPassword;
      });
    }
  }

  void validateForm() {
    setState(() {
      isButtonEnabled = _formSignInKey.currentState?.validate() ?? false;
    });
  }

  Future<void> login() async {}

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: false,
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              )),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: colors2,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        S.of(context).getStartetWelcomeTitle,
                        style: themeDark.textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        controller: emailTextInputController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).plsEnterPassword;
                          }

                          if (!validator.validateEmail(value)) {
                            return 'please enter correct email';
                          }
                          return null;
                        },
                        onChanged: (_) => validateForm(),
                        decoration: CustomInputDecoration.customDecoration(
                            context,
                            S.of(context).emailLabel,
                            S.of(context).laceholderEnterEmail),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: isHiddenPassword,
                        obscuringCharacter: '*',
                        controller: passwordTextInputController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                           ? 'Minimum 6 symbol'
                            : null,
                          onChanged: (_) => validateForm(),
                        decoration: CustomInputDecoration.customDecoration(
                            context,
                            S.of(context).passwordLabel,
                            S.of(context).placeholderEnterPassword),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberPassword,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberPassword = value!;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                          Text(
                            S.of(context).agreedamantData,
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomAdaptiveButton(
                            isActivated: isButtonEnabled, 
                            title: S.of(context).enterTitleLabel,
                            onPressed: isButtonEnabled ? () {
                               if (_formSignInKey.currentState?.validate() ??
                                  true) {
                                AutoRouter.of(context).replace(HomeTabRoute());
                              }
                            } : null
                            )            
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
