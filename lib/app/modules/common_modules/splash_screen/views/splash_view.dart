import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import '../../splash_screen/controllers/splash_controllers.dart';

class SplashView extends GetView<SplashController>
{
    const SplashView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Image.asset('assets/images/logo.png', width: 200, height: 200),
                        Text('PropMize', style: TextStyle(fontSize: 50, color: AppColors.primary,fontWeight: FontWeight.bold))
                    ]
                )
            )
        );
    }
}
