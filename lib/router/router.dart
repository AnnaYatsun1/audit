
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/bottom_bar/home_tabBar.dart';
import 'package:sound_level_meter/feature/micro/view/micro_screen.dart';

import '../feature/auth/view.dart';
import '../feature/home/view.dart';
import '../feature/info/view.dart';
import '../feature/saves/view.dart';
import '../feature/settings/view.dart';
import '../feature/timer/view.dart';


part 'router.gr.dart';

const REPLACE_IN_ROUTE_NAME = 'Screen|Page,Route';

@AutoRouterConfig(replaceInRouteName: REPLACE_IN_ROUTE_NAME)
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
            AutoRoute(
          page: WelcomeRegisterRoute.page,
          initial: true, // Стартовый экран
          path: '/',
        ),

        /// Экран входа
        AutoRoute(
          page: SignInRoute.page,
          path: '/signin',
        ),
           AutoRoute(
          page: HomeTabRoute.page,
          // initial: true,
          path: '/',
          children: [
            AutoRoute(page: MyHomeRoute.page, path: 'home'),
            AutoRoute(page: SavesRoute.page, path: 'saves'),
            AutoRoute(page: TimerRoute.page, path: 'timer'),
            AutoRoute(page: MicroRoute.page, path: 'micro')
          ],
        ),
           AutoRoute(page: InfoRoute.page, path: '/info'),
          AutoRoute(page: SattingsRoute.page, path: '/settings'),
          AutoRoute(page: QrCraterRoute.page, path: '/qrCreater')
      ];
}