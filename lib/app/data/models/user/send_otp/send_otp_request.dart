class SendOtpRequest {
  final String phone;

  SendOtpRequest({required this.phone});

  Map<String, dynamic> toJson() => {"phone": phone};
}