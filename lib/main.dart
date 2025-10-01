import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prop_mize/app/core/themes/app_theme.dart';
import 'package:prop_mize/app/data/services/current_user_id_services.dart';
import 'package:prop_mize/app/routes/app_pages.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import 'app/data/services/like_services.dart';
import 'app/data/services/storage_services.dart';
import 'app/modules/auth_screen/controllers/auth_controller.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  await _initServices();

  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());


  runApp(const MyApp());
}

Future<void> _initServices() async {
  await Get.putAsync<StorageServices>(() async => StorageServices());
  await Get.putAsync<LikeService>(() async => LikeService());
  await Get.putAsync<CurrentUserIdServices>(() async => CurrentUserIdServices());
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
    );
  }
}
