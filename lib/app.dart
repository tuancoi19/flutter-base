import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'blocs/app_cubit.dart';
import 'common/app_themes.dart';
import 'generated/l10n.dart';
import 'network/api_client.dart';
import 'network/api_util.dart';
import 'repositories/auth_repository.dart';
import 'repositories/movie_repository.dart';
import 'repositories/user_repository.dart';
import 'router/route_config.dart';
import 'ui/pages/splash/splash_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) {
          return AuthRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<MovieRepository>(create: (context) {
          return MovieRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<UserRepository>(create: (context) {
          return UserRepositoryImpl(apiClient: _apiClient);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            final userRepo = RepositoryProvider.of<UserRepository>(context);
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            return AppCubit(
              userRepo: userRepo,
              authRepo: authRepo,
            );
          })
        ],
        child: GestureDetector(
          onTap: () {
            _hideKeyboard(context);
          },
          child: GetMaterialApp(
            home: const SplashPage(),
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: RouteConfig.splash,
            getPages: RouteConfig.getPages,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate,
            ],
            // locale: Get.find<SettingService>().currentLocate.value,
            supportedLocales: S.delegate.supportedLocales,
          ),
        ),
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
