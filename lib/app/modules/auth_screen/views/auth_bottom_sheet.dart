import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/modules/auth_screen/controllers/auth_controller.dart';

class AuthBottomSheet extends GetView<AuthController>
{
    const AuthBottomSheet({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Obx(
            ()
            {

              Color borderColor;

              switch (controller.phoneValidationState.value) {
                case "empty" :
                  borderColor = AppColors.primary;
                  break;
                case "valid":
                  borderColor = Colors.green;
                  break;
                case "typing":
                  borderColor = Colors.yellow;
                  break;
                default:
                  borderColor = Colors.red;
              }

                return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: context.theme.cardColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20.0))
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                const Text(
                                    "Welcome!",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary
                                    )
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                    "Enter your phone number to continue",
                                    style: TextStyle(
                                        fontSize: 16, color: AppColors.textSecondary),
                                    textAlign: TextAlign.center
                                ),
                                const SizedBox(height: 24),

                                // Phone Number Field
                                TextFormField(
                                    controller: controller.phoneController,
                                    focusNode: controller.phoneFocus,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.phone, color: AppColors.primary),
                                        hintText: "Enter 10-digit phone number",
                                        /*border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12)
                                        ),*/

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: borderColor, width: 2), // ✅ live color
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: borderColor, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: borderColor, width: 2),
                                        ),

                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14
                                        )
                                    ),
                                    onChanged: (value)
                                    {
                                        // ✅ Controller listener automatically handle karega
                                    },
                                    onFieldSubmitted: (value)
                                    {
                                        // ✅ Enter press karne par OTP send karo
                                        if (value.trim().isNotEmpty && !controller.otpSent.value)
                                        {
                                            controller.sendOtp();
                                        }
                                    }
                                ),

                                const SizedBox(height: 16),

                                // OTP Field
                                if (controller.otpSent.value)
                                AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: TextFormField(
                                        controller: controller.otpController,
                                        focusNode: controller.otpFocus,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        maxLength: 6,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
                                            hintText: "Enter 6-digit OTP",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            counterText: "",
                                            contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 14
                                            )
                                        ),
                                        onChanged: (value)
                                        {
                                            // ✅ Auto verify jab OTP complete ho
                                            if (value.length == 6)
                                            {
                                                controller.verifyOtp();
                                            }
                                        },
                                        onFieldSubmitted: (value)
                                        {
                                            if (value.isNotEmpty)
                                            {
                                                controller.verifyOtp();
                                            }
                                        }
                                    )
                                ),
                                const SizedBox(height: 24),

                                // Action Button
                                /*SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: controller.isLoading.value ? null
                                            : () async
                                            {
                                                // ✅ FIX: Focus pehle hi unfocus karo
                                                FocusScope.of(context).unfocus();
                                                if (!controller.otpSent.value)
                                                {
                                                    await controller.sendOtp();
                                                }
                                                else
                                                {
                                                    bool res = await controller.verifyOtp();
                                                    print("login response: $res");
                                                    if (res)
                                                    {
                                                        // ✅ FIX: Pehle reset auth state, phir close
                                                        controller.resetAuthState();

                                                        // ✅ FIX: Thoda delay dekar UI update hone ka time do
                                                        await Future.delayed(Duration(milliseconds: 300));

                                                        // ✅ FIX: Safe way se bottom sheet close karo
                                                        if (Get.isBottomSheetOpen ?? false)
                                                        {
                                                            Get.back();
                                                        }
                                                    }
                                                }
                                            },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 16),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12)
                                            )
                                        ),
                                        child: controller.isLoading.value
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2
                                                )
                                            )
                                            : Text(
                                                controller.otpSent.value ? "Verify OTP" : "Send OTP",
                                                style: const TextStyle(fontSize: 16)
                                            )
                                    )
                                ),*/

                              // auth_bottom_sheet.dart
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : () => controller.handleAuthAction(),
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


                              if (controller.otpSent.value)
                                TextButton(
                                    onPressed:
                                    controller.isLoading.value ? null : controller.sendOtp,
                                    child: const Text(
                                        "Resend OTP",
                                        style: TextStyle(color: AppColors.primary)
                                    )
                                ),

                                const SizedBox(height: 16),

                                InkWell(
                                    child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: context.theme.cardColor,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4)
                                                )
                                            ]
                                        ),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Image.asset('assets/images/rent.png', width: 32),
                                                const SizedBox(width: 4),
                                                Text(
                                                    'Google',
                                                    style: context.textTheme.bodyLarge?.copyWith(
                                                        fontWeight: FontWeight.bold
                                                    )
                                                )
                                            ]
                                        )
                                    )
                                )
                            ]
                        )
                    )
                );
            }
        );
    }
}
