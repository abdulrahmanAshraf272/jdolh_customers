class ApiLinks {
  static const String server = "http://10.0.2.2/ecommerce";
  static const String test = "$server/test.php";

  //=================== Images ================//
  static const String images = '$server/upload';
  static const String imagesCategories = '$images/categories';
  static const String imagesItems = '$images/items';

  //=============== Auth ===============//
  static const String signUp = '$server/auth/signup.php';
  static const String verifycode = '$server/auth/verifycode.php';
  static const String login = '$server/auth/login.php';
  static const String checkEmail = '$server/forget_password/check_email.php';
  static const String verifycodeForgetPassword =
      '$server/forget_password/verifycode.php';
  static const String resetPassword =
      '$server/forget_password/reset_password.php';
  static const String resend = '$server/auth/resend.php';
  static const String home = '$server/home.php';
}
