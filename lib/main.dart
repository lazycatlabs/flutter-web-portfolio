import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:lazycatlabs/core/core.dart';
import 'package:lazycatlabs/data/data.dart';
import 'package:lazycatlabs/di/di.dart';
import 'package:lazycatlabs/presentation/presentation.dart';
import 'package:lazycatlabs/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  /// Register Service locator

  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();

  runZonedGuarded(
    /// Lock device orientation to portrait
    () => SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    ).then((_) async {
      /// Load SharedPref before load My App Widget
      SharedPreferences.getInstance().then((value) {
        initPrefManager(value);
        setUrlStrategy(PathUrlStrategy());
        runApp(LzyctApp());
      });
    }),
    (error, stackTrace) async {},
  );
}

class LzyctApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MainCubit>(),
      child: BlocBuilder<MainCubit, DataHelper>(
        builder: (context, data) {
          /// Pass context to appRoute
          AppRoute.setStream(context);

          return MaterialApp.router(
            routeInformationProvider: AppRoute.router.routeInformationProvider,
            routeInformationParser: AppRoute.router.routeInformationParser,
            routerDelegate: AppRoute.router.routerDelegate,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              },
            ),
            localizationsDelegates: const [
              Strings.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget? child) {
              final MediaQueryData data = MediaQuery.of(context);

              return MediaQuery(
                data: data.copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
            title: Constants.get.appName,
            theme: themeLight(context),
            darkTheme: themeDark(context),
            locale: Locale(data.type ?? "en"),
            supportedLocales: L10n.all,
            useInheritedMediaQuery: true,
            themeMode: data.activeTheme.mode,

            /// Check if theme is light or dark first
          );
        },
      ),
    );
  }
}
