// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [DetailScreen]
class DetailRoute extends PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    Key? key,
    required InventoryItemView item,
    List<PageRouteInfo>? children,
  }) : super(
         DetailRoute.name,
         args: DetailRouteArgs(key: key, item: item),
         initialChildren: children,
       );

  static const String name = 'DetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailRouteArgs>();
      return DetailScreen(key: args.key, item: args.item);
    },
  );
}

class DetailRouteArgs {
  const DetailRouteArgs({this.key, required this.item});

  final Key? key;

  final InventoryItemView item;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [EditScreen]
class EditRoute extends PageRouteInfo<EditRouteArgs> {
  EditRoute({
    Key? key,
    required InventoryItemView item,
    List<PageRouteInfo>? children,
  }) : super(
         EditRoute.name,
         args: EditRouteArgs(key: key, item: item),
         initialChildren: children,
       );

  static const String name = 'EditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditRouteArgs>();
      return EditScreen(key: args.key, item: args.item);
    },
  );
}

class EditRouteArgs {
  const EditRouteArgs({this.key, required this.item});

  final Key? key;

  final InventoryItemView item;

  @override
  String toString() {
    return 'EditRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryScreen();
    },
  );
}

/// generated route for
/// [HomeTabScreen]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
    : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return HomeTabScreen();
    },
  );
}

/// generated route for
/// [InfoScreen]
class InfoRoute extends PageRouteInfo<void> {
  const InfoRoute({List<PageRouteInfo>? children})
    : super(InfoRoute.name, initialChildren: children);

  static const String name = 'InfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InfoScreen();
    },
  );
}

/// generated route for
/// [LocationScreen]
class LocationRoute extends PageRouteInfo<LocationRouteArgs> {
  LocationRoute({
    Key? key,
    required InventoryType productType,
    List<PageRouteInfo>? children,
  }) : super(
         LocationRoute.name,
         args: LocationRouteArgs(key: key, productType: productType),
         initialChildren: children,
       );

  static const String name = 'LocationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationRouteArgs>();
      return LocationScreen(key: args.key, productType: args.productType);
    },
  );
}

class LocationRouteArgs {
  const LocationRouteArgs({this.key, required this.productType});

  final Key? key;

  final InventoryType productType;

  @override
  String toString() {
    return 'LocationRouteArgs{key: $key, productType: $productType}';
  }
}

/// generated route for
/// [MicroScreen]
class MicroRoute extends PageRouteInfo<void> {
  const MicroRoute({List<PageRouteInfo>? children})
    : super(MicroRoute.name, initialChildren: children);

  static const String name = 'MicroRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MicroScreen();
    },
  );
}

/// generated route for
/// [MyHomeScreen]
class MyHomeRoute extends PageRouteInfo<void> {
  const MyHomeRoute({List<PageRouteInfo>? children})
    : super(MyHomeRoute.name, initialChildren: children);

  static const String name = 'MyHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MyHomeScreen();
    },
  );
}

/// generated route for
/// [QRScannerScreen]
class QRScannerRoute extends PageRouteInfo<void> {
  const QRScannerRoute({List<PageRouteInfo>? children})
    : super(QRScannerRoute.name, initialChildren: children);

  static const String name = 'QRScannerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QRScannerScreen();
    },
  );
}

/// generated route for
/// [SavesScreen]
class SavesRoute extends PageRouteInfo<void> {
  const SavesRoute({List<PageRouteInfo>? children})
    : super(SavesRoute.name, initialChildren: children);

  static const String name = 'SavesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SavesScreen();
    },
  );
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchScreen();
    },
  );
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInScreen();
    },
  );
}

/// generated route for
/// [SimilarProductScreen]
class SimilarProductRoute extends PageRouteInfo<void> {
  const SimilarProductRoute({List<PageRouteInfo>? children})
    : super(SimilarProductRoute.name, initialChildren: children);

  static const String name = 'SimilarProductRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SimilarProductScreen();
    },
  );
}

/// generated route for
/// [TimerScreen]
class TimerRoute extends PageRouteInfo<void> {
  const TimerRoute({List<PageRouteInfo>? children})
    : super(TimerRoute.name, initialChildren: children);

  static const String name = 'TimerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TimerScreen();
    },
  );
}

/// generated route for
/// [WelcomeRegisterScreen]
class WelcomeRegisterRoute extends PageRouteInfo<void> {
  const WelcomeRegisterRoute({List<PageRouteInfo>? children})
    : super(WelcomeRegisterRoute.name, initialChildren: children);

  static const String name = 'WelcomeRegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WelcomeRegisterScreen();
    },
  );
}
