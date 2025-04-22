

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/router.dart';
import 'bottom_bar.dart';

@RoutePage()
class HomeTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        MyHomeRoute(), // Главная страница
        SavesRoute(),
        TimerRoute(),
        MicroRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child, // Тут будет контент активной вкладки
          bottomNavigationBar: BottomBar(
            tabsRouter: tabsRouter,
          ), // Передаём tabsRouter
        );
      },
    );
  }
}
