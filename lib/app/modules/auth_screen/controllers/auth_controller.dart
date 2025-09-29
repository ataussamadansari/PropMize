import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/user/user_me.dart';
import 'package:prop_mize/app/data/models/user/verify_otp/verify_otp_response.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/models/api_response_model.dart';
import '../../../data/models/user/send_otp/send_otp_request.dart';
import '../../../data/models/user/verify_otp/verify_otp_request.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/services/storage_services.dart';

class AuthController extends GetxController
{
    final AuthRepository _authRepo = AuthRepository();

    // Reactive variables
    final user = Rxn<VerifyOtpResponse>();
    final profile = Rxn<UserMe>();

    var phone = "".obs;
    var otp = "".obs;
    var otpSent = false.obs;

    final RxBool isLoading = false.obs;
    final RxBool hasError = false.obs;
    final RxString errorMessage = "".obs;

    // Phone validation state
    var phoneValidationState = "".obs;

    void validatePhoneLive(String value) {
        final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

        if (digitsOnly.isEmpty) {
            phoneValidationState.value = "empty";
        } else if (digitsOnly.length < 10) {
            phoneValidationState.value = "typing";
        } else if (_isValidPhoneNumber(digitsOnly)) {
            phoneValidationState.value = "valid";
        } else {
            phoneValidationState.value = "invalid";
        }
    }

    // ✅ FIX: Controllers ko immediately initialize karo
    TextEditingController phoneController = TextEditingController();
    TextEditingController otpController = TextEditingController();

    // FocusNodes
    final phoneFocus = FocusNode();
    final otpFocus = FocusNode();

    @override
    void onInit() 
    {
        super.onInit();
        _initializeControllers();
        _setupListeners();
    }

    // ✅ FIX: Controllers initialize karo
    void _initializeControllers() 
    {
        phoneController = TextEditingController();
        otpController = TextEditingController();

        // ✅ Initial values set karo agar observable values mein kuch hai
        if (phone.value.isNotEmpty) 
        {
            phoneController.text = phone.value;
        }
    }

    // ✅ FIX: TextControllers aur Observable values ko sync karo
    void _setupListeners() 
    {
        // Phone controller changes ko phone observable mein update karo
        phoneController.addListener(()
            {
                phone.value = phoneController.text.trim();
                validatePhoneLive(phoneController.text);
            }
        );

        // OTP controller changes ko otp observable mein update karo
        otpController.addListener(()
            {
                otp.value = otpController.text.trim();
            }
        );

        // OTP sent hone par OTP field par focus karo
        ever(otpSent, (sent)
            {
                if (sent == true) 
                {
                    // Thoda delay dekar focus set karo
                    Future.delayed(Duration(milliseconds: 300), ()
                        {
                            otpFocus.requestFocus();
                        }
                    );
                }
            }
        );
    }

    Future<void> sendOtp() async
    {
        try
        {
            // ✅ Pehle unfocus karo
            phoneFocus.unfocus();

            isLoading.value = true;
            hasError.value = false;
            errorMessage.value = "";

            // ✅ Phone validation improve karo
            final phoneNumber = phone.value.trim();
            if (phoneNumber.isEmpty) 
            {
                hasError.value = true;
                errorMessage.value = "Please enter a phone number";
                AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
                phoneFocus.requestFocus();
                return;
            }

            // ✅ Basic phone number validation
            if (!_isValidPhoneNumber(phoneNumber)) 
            {
                hasError.value = true;
                errorMessage.value = "Please enter a valid phone number";
                AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
                phoneFocus.requestFocus();
                return;
            }

            // Create request model
            final request = SendOtpRequest(phone: phoneNumber);

            // Call repository
            final response = await _authRepo.sendOtp(request);

            if (response.success) 
            {
                otpSent.value = true;
                AppHelpers.showSnackBar(title: "Success", message: "OTP sent: ${response.data?.data.otp}", isError: false);
            }
            else 
            {
                hasError.value = true;
                errorMessage.value = response.message;
                AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
                // ✅ Error mein phone field par focus rakhO
                phoneFocus.requestFocus();
            }

        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
            phoneFocus.requestFocus();
        }
        finally
        {
            isLoading.value = false;
        }
    }

    Future<void> verifyOtp() async
    {
        try
        {
            // ✅ Pehle unfocus karo
            otpFocus.unfocus();

            isLoading.value = true;
            hasError.value = false;
            errorMessage.value = "";

            // ✅ Phone available hai ya nahi check karo
            if (phone.value.isEmpty) 
            {
                errorMessage.value = "Phone number not found. Please restart the process.";
                hasError.value = true;
                AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
                return;
            }

            if (otp.value.isEmpty) 
            {
                errorMessage.value = "Please enter the OTP";
                hasError.value = true;
                AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
                // ✅ OTP field par focus karo
                otpFocus.requestFocus();
                return;
            }

            // ✅ OTP length validation
            if (otp.value.length < 5) 
            {
                errorMessage.value = "Please enter a valid OTP";
                hasError.value = true;
                AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
                otpFocus.requestFocus();
                return;
            }

            final request = VerifyOtpRequest(phone: phone.value, otp: otp.value);
            final response = await _authRepo.verifyOtp(request);

            if (response.success) 
            {
                user.value = response.data;

                if (user.value != null && user.value!.data.tokens.accessToken != null) 
                {
                    StorageServices.to.setToken(user.value!.data.tokens.accessToken!);
                }

                if (user.value != null && user.value!.data.user.id != null) 
                {
                    StorageServices.to.setUserId(user.value!.data.user.id!);
                }

                Get.isBottomSheetOpen == true ? Get.back() : null;

                AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Success", message: "Login successful!");
                await me();
            }
            else 
            {
                hasError.value = true;
                errorMessage.value = response.message;
                AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
                otpFocus.requestFocus();
                return;
            }

        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
            otpFocus.requestFocus();
            return;
        }
        finally
        {
            isLoading.value = false;
        }
    }

    Future<void> me() async
    {
        try
        {
            isLoading.value = true;
            hasError.value = false;
            errorMessage.value = "";

            final token = StorageServices.to.getToken();
            if (token == null || token.isEmpty) 
            {
                return;
            }

            // Repository call
            final response = await _authRepo.me();

            if (response.success) 
            {
                profile.value = response.data!;

                if (user.value != null && user.value!.data.user.id != null) 
                {
                    StorageServices.to.setUserId(user.value!.data.user.id!);
                }
            }
            else 
            {
                hasError.value = true;
                errorMessage.value = response.message;
                AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
            }
        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
        }
        finally
        {
            isLoading.value = false;
        }
    }

    void logout() 
    {
        StorageServices.to.removeToken();
        StorageServices.to.removeUserId();
        resetAuthState();
        AppHelpers.showSnackBar(icon: CupertinoIcons.bell, title: "Logout", message: "Logout successful");
    }


    /*Future<ApiResponse<UserMe>> updateProfile(dynamic updateData) async {
        try {
            isLoading.value = true;
            final response = await _authRepo.updateDetails(updateData);

            if (response.success) {
                profile.value = response.data;
            }

            return response;
        } on DioException catch (e) {
            return ApiResponse(success: false, message: "$e");
        } finally {
            isLoading.value = false;
        }
    }*/

    Future<ApiResponse<UserMe>> updateProfile(dynamic updateData, {File? image}) async {
        try {
            isLoading.value = true;
            final response = await _authRepo.updateDetails(updateData, image: image);

            if (response.success) {
                profile.value = response.data;
            }

            return response;
        } on DioException catch (e) {
            return ApiResponse(success: false, message: "$e");
        } finally {
            isLoading.value = false;
        }
    }



    /*Future<ApiResponse<UserMe>> updateProfile(Map<String, dynamic> updateData) async
    {
        try
        {
            isLoading.value = true;
            final response = await _authRepo.updateDetails(updateData);

            if (response.success) 
            {
                profile.value = response.data;
            }

            return response;
        }
        on DioException catch (e)
        {
            return ApiResponse(success: false, message: "$e");
        }
        finally
        {
            isLoading.value = false;
        }
    }*/

    void resetAuthState() 
    {
        phone.value = "";
        otp.value = "";
        otpSent.value = false;
        isLoading.value = false;
        hasError.value = false;
        errorMessage.value = "";

        // ✅ Controllers clear karo
        phoneController.clear();
        otpController.clear();

        // ✅ Focus reset karo
        phoneFocus.unfocus();
        otpFocus.unfocus();

        // ✅ Phone field par focus wapas lao
        Future.delayed(Duration(milliseconds: 100), ()
            {
                phoneFocus.requestFocus();
            }
        );
    }

    // ✅ Phone number validation
    bool _isValidPhoneNumber(String phone) 
    {
        // ✅ Correct regex for Indian phone numbers
        final phoneRegex = RegExp(r'^[6-9]\d{9}$');
        return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[^0-9]'), ''));
    }

    // ✅ Resend OTP method
    void resendOtp() 
    {
        if (phone.value.isNotEmpty) 
        {
            sendOtp();
        }
        else 
        {
            AppHelpers.showSnackBar(title: "Error", message: "Please enter phone number first", isError: true);
            phoneFocus.requestFocus();
        }
    }

    // auth_controller.dart
    Future<void> handleAuthAction() async
    {
        FocusScope.of(Get.context!).unfocus();

        if (!otpSent.value) 
        {
            await sendOtp();
        }
        else 
        {
            await verifyOtp();
        }
    }
}
