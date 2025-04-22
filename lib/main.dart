import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_level_meter/provider/language_provider.dart';

import 'package:sound_level_meter/router/router.dart';
import 'package:sound_level_meter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'feature/auth/view.dart';
import 'feature/home/view/home_screen.dart';

void main() {
  final appRouter = AppRouter(); // Создаем экземпляр роутера
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => LanguageProvider(), 
    //   child:
       MyApp()
      // )
    );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     //   final languageProvider = Provider.of<LanguageProvider>(context);
    // return MaterialApp(
    //          localizationsDelegates: const [
    //             S.delegate,
    //             GlobalMaterialLocalizations.delegate,
    //             GlobalWidgetsLocalizations.delegate,
    //             GlobalCupertinoLocalizations.delegate,
    //         ],
    //         supportedLocales: S.delegate.supportedLocales,
    //   home: WelcomeRegisterScreen());
    return MaterialApp.router(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    //  locale: languageProvider.locale,
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Releway'),
      routerConfig: _appRouter.config(
        navigatorObservers: () => [],
      ),
      // home: const MyHomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
