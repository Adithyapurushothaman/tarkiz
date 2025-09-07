enum AppRoute {
  register(path: '/register'),
  login(path: '/login'),
  registerOtpVerification(path: '/register-otp-verification'),
  resetPasswordOtpVerification(path: '/reset-password-otp-verification'),
  deleteAccountOtpVerification(path: '/delete-account-otp-verification'),
  registerInitiate(path: '/register-initiate'),
  loading(path: '/loading'),
  success(path: '/success');

  const AppRoute({required this.path});
  final String path;
}
