import 'package:flutter/material.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';

import '../background/ola_background.dart';

class NotLoggedScreen extends StatelessWidget
{
    final String? heading;
    final String? message;
    final VoidCallback? onPressed;
    const NotLoggedScreen({super.key, this.heading, this.message, this.onPressed});

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
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        heading ?? "You're not logged in",
                                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                            fontWeight: FontWeight.w100
                                        )
                                    ),
                                    Text(
                                        message ?? "Please log in to access this feature.",
                                        style: Theme.of(context).textTheme.bodyLarge
                                    )
                                ]
                            )
                        )
                    ),
                    Positioned(
                        bottom: 30,
                        left: 16,
                        right: 16,
                        child: SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: onPressed,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // 👈 rounded corners
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: const Text("Log In"),
                            )
                        )
                    )
                ]
            )
        );
    }
}
