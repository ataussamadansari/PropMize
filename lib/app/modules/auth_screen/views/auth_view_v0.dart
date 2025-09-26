import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/modules/auth_screen/controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Obx(
                    () => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(24),
                  // margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Enter your phone number to continue",
                        style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Phone Number Field (Always Visible)
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => controller.phone.value = val,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone, color: AppColors.primary),
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // OTP Field (Only after OTP sent)
                      if (controller.otpSent.value)
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) => controller.otp.value = val,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
                            hintText: "Enter OTP",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Single Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                            if (!controller.otpSent.value) {
                              controller.sendOtp();
                            } else {
                              controller.verifyOtp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            controller.otpSent.value ? "Verify OTP" : "Send OTP",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      // Resend OTP
                      if (controller.otpSent.value)
                        TextButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.sendOtp,
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),

                      // Google
                      const SizedBox(height: 16),

                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: context.theme.cardColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/images/rent.png', width: 32),
                              SizedBox(width: 4,),
                              Text('Google', style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
