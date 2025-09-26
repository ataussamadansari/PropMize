class SendOtpResponse {
  final bool success;
  final String message;
  final OtpData data;

  SendOtpResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: OtpData.fromJson(json["data"]),
    );
  }
}

class OtpData {
  final String otp;
  final bool isNewUser;
  final String phone;

  OtpData({required this.otp, required this.isNewUser, required this.phone});

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      otp: json["otp"] ?? "",
      isNewUser: json["isNewUser"] ?? true,
      phone: json["phone"] ?? "",
    );
  }
}