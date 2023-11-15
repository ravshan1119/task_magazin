import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_magazin/src/config/router/app_routes.dart';
import 'package:task_magazin/src/utils/resources/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  novegator() {
    Future.delayed(const Duration(seconds: 3), () {
      context.go(AppRoutes.tab);
    });
  }

  @override
  void initState() {
    novegator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Center(
          child: Image.asset(AppImages.logo),
        ));
  }
}
