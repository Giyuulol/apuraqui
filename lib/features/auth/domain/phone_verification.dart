class PhoneVerification {
  const PhoneVerification({
    required this.verificationId,
    this.resendToken,
    this.autoVerified = false,
  });

  final String verificationId;
  final int? resendToken;
  final bool autoVerified;
}
