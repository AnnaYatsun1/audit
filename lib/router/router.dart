
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sound_level_meter/feature/bottom_bar/bottom_bar.dart';
import 'package:sound_level_meter/feature/bottom_bar/home_tabBar.dart';
import 'package:sound_level_meter/feature/create_item/view/create_product_view.dart';
import 'package:sound_level_meter/feature/detail/detail_screen.dart';
import 'package:sound_level_meter/feature/edite/model/inventory_item_edite.dart';
import 'package:sound_level_meter/feature/history/history_screen.dart';
import 'package:sound_level_meter/feature/home/filter/view/filtre_screen.dart';
import 'package:sound_level_meter/feature/home/model/inventory_item_view.dart';
import 'package:sound_level_meter/feature/locations/location/edit_location/edit_location_view.dart';
import 'package:sound_level_meter/feature/locations/location/model/location_model.dart';
import 'package:sound_level_meter/feature/locations/location/product_location_screen.dart';
import 'package:sound_level_meter/feature/micro/view/micro_screen.dart';
import 'package:sound_level_meter/feature/similar_product/view/similar_product_screen.dart';

import '../feature/auth/view.dart';
import '../feature/home/view.dart';
import '../feature/info/view.dart';
import '../feature/locations/view.dart';
import '../feature/edite/view.dart';
import '../feature/new_type/view.dart';


part 'router.gr.dart';

const REPLACE_IN_ROUTE_NAME = 'Screen|Page,Route';

@AutoRouterConfig(replaceInRouteName: REPLACE_IN_ROUTE_NAME)
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        //     AutoRoute(
        //   page: WelcomeRegisterRoute.page,
        //   initial: true, // Стартовый экран
        //   path: '/',
        // ),

        // /// Экран входа
        // AutoRoute(
        //   page: SignInRoute.page,
        //   path: '/signin',
        // ),
           AutoRoute(
          page: HomeTabRoute.page,
          initial: true,
          path: '/',
          children: [
            AutoRoute(page: MyHomeRoute.page, path: 'home'),
            AutoRoute(page: AllLocationRoute.page, path: 'saves'),
            AutoRoute(page: NewTypeRoute.page, path: 'timer'),
            AutoRoute(page: MicroRoute.page, path: 'micro')
          ],
        ),
          AutoRoute(page: InfoRoute.page, path: '/info'),
          AutoRoute(page: EditRoute.page, path: '/settings'),
          AutoRoute(page: QRScannerRoute.page, path: '/qrCreater'),
          AutoRoute(page: SearchRoute.page, path: '/search'),
          AutoRoute(page: LocationRoute.page, path: '/location'),
          AutoRoute(page: HistoryRoute.page, path: '/history'),
          AutoRoute(page: SimilarProductRoute.page, path: '/similar'),
          AutoRoute(page: DetailRoute.page, path: '/detail'),
          AutoRoute(page: CreateProductRoute.page, path: '/create'),
          AutoRoute(page: EditWarehouseRoute.page, path: '/edite_location'),
          AutoRoute(page: FiltreRoute.page, path: '/filter')
      ];
}