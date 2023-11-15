import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_magazin/src/config/router/go_router.dart';
import 'package:task_magazin/src/config/themes/app_theme.dart';
import 'package:task_magazin/src/data/datasources/remote/api_service.dart';
import 'package:task_magazin/src/data/repositories/category_repo.dart';
import 'package:task_magazin/src/data/repositories/product_repo.dart';
import 'package:task_magazin/src/presentation/cubits/category_cubit/category_cubit.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => CategoryCubit(
          repository: CategoryRepo(
            apiService: apiService,
          ),
          productRepo: ProductRepo(
            apiService: apiService,
          ),
        ),
      )
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return AdaptiveTheme(
            light: AppTheme.lightTheme,
            dark: AppTheme.darkTheme,
            initial: AdaptiveThemeMode.system,
            builder: (theme, darkTheme) {
              return MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                theme: theme,
                darkTheme: darkTheme,
              );
            });
      },
    );
  }
}
