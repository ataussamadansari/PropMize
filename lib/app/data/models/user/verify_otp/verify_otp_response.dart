import '../user_model.dart';

class VerifyOtpResponse {
  final bool success;
  final VerifyOtpData data;

  VerifyOtpResponse({required this.success, required this.data});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      success: json["success"] ?? false,
      data: VerifyOtpData.fromJson(json["data"]),
    );
  }
}

class VerifyOtpData {
  final User user;
  final Tokens tokens;

  VerifyOtpData({required this.user, required this.tokens});

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpData(
      user: User.fromJson(json["user"]),
      tokens: Tokens.fromJson(json["tokens"]),
    );
  }
}