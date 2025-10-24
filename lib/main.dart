import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prop_mize/app/core/bindings/app_bindings.dart';
import 'package:prop_mize/app/core/themes/app_theme.dart';
import 'package:prop_mize/app/routes/app_pages.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
      initialBinding: AppBindings(),
    );
  }
}

