class ApiLinks {
  //Localhost ios emulator 127.0.0.1 or localhost
  //Localhost android emulator 10.0.2.2
  //Localhost on Real device mean
  //yousef devie: fe80::cf:baff:fe0a:fc4c
  //192.168.1.3
  static const String server = "http://10.0.2.2/jdolh";
  static const String test = "$server/test.php";

  //=================== Images ================//
  static const String imagesBrands = '$server/jdolh_brands/upload';
  static const String logoImage = '$imagesBrands/logo';
  static const String branchImage = '$imagesBrands/branches';
  static const String itemsImage = '$imagesBrands/items';

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
  static const String followUnfollow =
      '$server/jdolh_customers/follow_unfollow.php';

  static const String personProfile =
      '$server/jdolh_customers/profile/person_profile.php';
  static const String myProfile =
      '$server/jdolh_customers/profile/my_profile.php';

  // ================= Groups ====================//
  static const String createGroup =
      '$server/jdolh_customers/group/create_group.php';
  static const String addToGroup =
      '$server/jdolh_customers/group/add_to_group.php';
  static const String deleteMember =
      '$server/jdolh_customers/group/delete_member.php';
  static const String editGroupName =
      '$server/jdolh_customers/group/edit_group_name.php';
  static const String deleteGroup =
      '$server/jdolh_customers/group/delete_group.php';
  static const String leaveGroup =
      '$server/jdolh_customers/group/leave_group.php';
  static const String groupsView =
      '$server/jdolh_customers/group/groups_view.php';
  static const String groupMembers =
      '$server/jdolh_customers/group/group_members.php';

  //================== Occasion ====================//
  static const String createOccasion =
      '$server/jdolh_customers/occasion/create_occasion.php';
  static const String deleteOccasion =
      '$server/jdolh_customers/occasion/delete_occasion.php';
  static const String addToOccasion =
      '$server/jdolh_customers/occasion/add_to_occasion.php';
  static const String deleteOccasionInvitor =
      '$server/jdolh_customers/occasion/delete_invitor.php';
  static const String editOccasion =
      '$server/jdolh_customers/occasion/edit_occasion.php';
  static const String acceptOccasion =
      '$server/jdolh_customers/occasion/accept_invitation.php';
  static const String rejectOccasion =
      '$server/jdolh_customers/occasion/reject_invitation.php';
  static const String viewOccasion =
      '$server/jdolh_customers/occasion/view_occasions.php';
  static const String viewOccasionInvitors =
      '$server/jdolh_customers/occasion/view_invitors.php';

  //============= Checkin ================//
  static const String checkin = '$server/jdolh_customers/checkin/checkin.php';
  static const String jdolhPlaces =
      '$server/jdolh_customers/checkin/view_places.php';

// =========== About Get Brand data ===========//
  static const brandTypesAndsubtypes =
      '$server/jdolh_brands/view_types_and_subtypes.php';
  static const searchBrand =
      '$server/jdolh_customers/get_brand/search_brand.php';
  static const getBch = '$server/jdolh_customers/get_brand/get_bch.php';
  static const getItemOptions =
      '$server/jdolh_customers/get_brand/get_itemsoptions.php';
  static const getBchInfo =
      '$server/jdolh_customers/get_brand/get_bch_info.php';

  // ======= Cart =======//
  static const addCart = '$server/jdolh_customers/cart/add_cart.php';
  static const getCart = '$server/jdolh_customers/cart/get_cart.php';
  static const deleteCart = '$server/jdolh_customers/cart/delete_cart.php';
  static const changeQuantity =
      '$server/jdolh_customers/cart/change_quantity.php';
}
