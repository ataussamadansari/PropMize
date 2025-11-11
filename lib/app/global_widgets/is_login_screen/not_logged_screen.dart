import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';

import '../background/ola_background.dart';

class NotLoggedScreen extends StatelessWidget
{
    final String? imgUrl;
    final String? heading;
    final String? message;
    final VoidCallback? onPressed;
    const NotLoggedScreen({super.key, this.imgUrl, this.heading, this.message, this.onPressed});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: Stack(
                children: [
                    OlaBackground(
                        primaryColor: Colors.blue, // Different color
                        waveOpacity: 0.08, // More subtle
                        dotOpacity: 0.1
                    ),

                    Positioned(
                        child: Image.asset(
                          imgUrl ?? 'assets/images/image_2.jpg',
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.fill,
                        )
                    ),

                    Positioned(
                        bottom: 32,
                        left: 16,
                        right: 16,
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: context.theme.cardColor.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Text(
                                        heading ?? "You're not logged in",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                            fontWeight: FontWeight.w100
                                        )
                                    ),
                                    Text(
                                        message ?? "Please log in to access this feature.",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyLarge
                                    ),
                                    SizedBox(height: 16),
                                    SizedBox(
                                        height: 48,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: onPressed,
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30) // 👈 rounded corners
                                                ),
                                                backgroundColor: Colors.white,
                                                foregroundColor: AppColors.primary,
                                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                                            ),
                                            child: const Text("Log In")
                                        )
                                    )
                                ]
                            )
                        )
                    )

                ]
            )
        );
    }
}
