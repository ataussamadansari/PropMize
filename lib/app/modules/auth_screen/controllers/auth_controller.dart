import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/user/user_me.dart';
import 'package:prop_mize/app/data/models/user/verify_otp/verify_otp_response.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/models/api_response_model.dart';
import '../../../data/models/user/send_otp/send_otp_request.dart';
import '../../../data/models/user/verify_otp/verify_otp_request.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/services/storage_services.dart';

class AuthController extends GetxController {
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

  Future<void> sendOtp() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      if (phone.value.isEmpty) {
        hasError.value = true;
        errorMessage.value = "Please enter a phone number";
        AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: hasError.value);
        return;
      }

      // Create request model
      final request = SendOtpRequest(phone: phone.value);

      // Call repository
      final response = await _authRepo.sendOtp(request);

      if (response.success) {
        otpSent.value = true;
        AppHelpers.showSnackBar(
          title: "Success",
          message: "OTP sent: ${response.data?.data.otp}",
          isError: false,
        );
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelpers.showSnackBar(
            title: "Error",
            message: response.message,
            isError: true
        );
      }

    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      AppHelpers.showSnackBar(
          title: "Error",
          message: errorMessage.value,
          isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyOtp() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      if (otp.value.isEmpty) {
        errorMessage.value = "Please enter the OTP";
        hasError.value = true;
        AppHelpers.showSnackBar(
          title: "Error",
          message: errorMessage.value,
          isError: true,
        );
        return false;
      }

      final request = VerifyOtpRequest(phone: phone.value, otp: otp.value);
      final response = await _authRepo.verifyOtp(request);

      if (response.success) {
        user.value = response.data;

        if (user.value != null && user.value!.data.tokens.accessToken != null) {
          StorageServices.to.setToken(user.value!.data.tokens.accessToken!);
        }

        if (user.value != null && user.value!.data.user.id != null) {
          StorageServices.to.setUserId(user.value!.data.user.id!);
        }
        // ✅ SUCCESS MESSAGE
        AppHelpers.showSnackBar(
          title: "Success",
          message: "Login successful!",
          isError: false,
        );

        me();

        return true;
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelpers.showSnackBar(
            title: "Error",
            message: response.message,
            isError: true
        );

        return false;
      }

    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void me() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final token = StorageServices.to.getToken();
      if (token == null || token.isEmpty) {
        throw "No token found. Please login again.";
      }

      // Repository call
      final response = await _authRepo.me();

      if (response.success) {
        profile.value = response.data!;

        // ✅ User info ko storage me update bhi kar sakte ho (optional)
        if (user.value != null && user.value!.data.user.id != null) {
          StorageServices.to.setUserId(user.value!.data.user.id!);
        }
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelpers.showSnackBar(
          title: "Error",
          message: response.message,
          isError: true,
        );
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      AppHelpers.showSnackBar(title: "Error", message: errorMessage.value, isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    StorageServices.to.removeToken();
    StorageServices.to.removeUserId();

    // 🔹 Reset controller state
    phone.value = "";
    otp.value = "";
    otpSent.value = false;


    Get.snackbar(
        "Logout",
        "Logout successful"
    );
  }

  // 🔹 Update profile method jo Map accept kare
  Future<ApiResponse<UserMe>> updateProfile(Map<String, dynamic> updateData) async {
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
  }
}
