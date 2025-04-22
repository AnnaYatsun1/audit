
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/router/router.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key,
      required this.ButtonText,
      this.onTap,
      required this.color,
      required this.textCollor});

  final String ButtonText;
  final PageRouteInfo<dynamic>? onTap;
  final Color? color;
  final Color? textCollor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
            if (onTap != null) {
          AutoRouter.of(context).push(onTap!); // Переход по маршруту
        } else {
          print('onTap is null');
        }
      },
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: color!,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
            )),
        child: Text(
          textAlign: TextAlign.center,
          ButtonText!,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textCollor!),
        ),
      ),
    );
  }
}
