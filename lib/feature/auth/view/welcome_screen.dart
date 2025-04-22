

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/auth/view/signIn_screen.dart';
import 'package:sound_level_meter/feature/ui/scaffold.dart';
import 'package:sound_level_meter/feature/ui/welcome_button.dart';
import 'package:sound_level_meter/router/router.dart';

@RoutePage()
class WelcomeRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarIsVisible: false,
      child: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
                child: Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "Weelcome back \n",
                            style: TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.w900,
                                color: Colors.white)),
                        TextSpan(
                            text:
                                '\n Enter personal details to your employee account',
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                                color: Colors.white))
                      ])),
                ),
              )),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      ButtonText: 'Sing in',
                      onTap: SignInRoute(),
                      color: Colors.transparent,
                      textCollor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}