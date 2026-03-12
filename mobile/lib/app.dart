import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';
import 'utils/app_theme.dart';

class ReplaiApp extends StatelessWidget {
  const ReplaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Replai',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}