class ApiLinks {
  static const String server = "http://10.0.2.2/jdolh";
  static const String test = "$server/test.php";

  //=================== Images ================//
  static const String images = '$server/upload';
  static const String imagesCategories = '$images/categories';
  static const String imagesItems = '$images/items';

  //=============== Auth ===============//
  static const String signUp = '$server/jdolh_customers/auth/signup.php';
  static const String login = '$server/jdolh_customers/auth/login.php';
  static const String verifycode =
      '$server/jdolh_customers/auth/verifycode.php';
  static const String resendVerifycode =
      '$server/jdolh_customers/auth/resend_verifycode.php';
  static const String forgetPassword =
      '$server/jdolh_customers/auth/forget_password.php';
  static const String resetPassword =
      '$server/jdolh_customers/auth/reset_password.php';

  static const String searchPerson =
      '$server/jdolh_customers/search_person.php';
}
