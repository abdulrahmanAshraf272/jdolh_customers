class ApiLinks {
  //Localhost ios emulator 127.0.0.1 or localhost
  //Localhost android emulator 10.0.2.2
  //Localhost on Real device mean
  //yousef devie: fe80::cf:baff:fe0a:fc4c
  //192.168.1.3
  //static const String server = "http://10.0.2.2/jdolh1";
  static const String server = "https://www.jdolh.com/jdolh1";
  static const String test = "$server/test.php";

  //=================== Images ================//
  static const String imagesBrands = '$server/jdolh_brands/upload';
  static const String logoImage = '$imagesBrands/logo';
  static const String branchImage = '$imagesBrands/branches';
  static const String itemsImage = '$imagesBrands/items';
  static const String customerImage =
      '$server/jdolh_customers/upload/customers_photo';
  static const String adsImages = '$server/jdolh_admin/upload/ads';

  //=============== Auth ===============//
  static const String signUp = '$server/jdolh_customers/auth/signup.php';
  static const String signUpWithImage =
      '$server/jdolh_customers/auth/signup_with_image.php';
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

  static const String editPersonalData =
      '$server/jdolh_customers/auth/edit_personal_data.php';
  static const String editPersonalDataWithImage =
      '$server/jdolh_customers/auth/edit_personal_data_with_image.php';

  static const String getUser = '$server/jdolh_customers/auth/get_user.php';

  // ================= Groups ====================//
  static const String createGroup =
      '$server/jdolh_customers/group/create_group.php';
  static const String addGroupMember =
      '$server/jdolh_customers/group/add_member.php';
  static const String deleteMember =
      '$server/jdolh_customers/group/delete_member.php';
  static const String editGroupName =
      '$server/jdolh_customers/group/edit_group_name.php';
  static const String deleteGroup =
      '$server/jdolh_customers/group/delete_group.php';

  static const String groupsView =
      '$server/jdolh_customers/group/groups_view.php';
  static const String groupMembers =
      '$server/jdolh_customers/group/get_group_members.php';

  static const String clearMembers =
      '$server/jdolh_customers/group/clear_members.php';

  static const String testGroup = '$server/jdolh_customers/group2/test.php';

  //================== Occasion ====================//
  static const String createOccasion =
      '$server/jdolh_customers/occasion/create_occasion.php';
  static const String deleteOccasion =
      '$server/jdolh_customers/occasion/delete_occasion.php';
  static const String addOccasionMember =
      '$server/jdolh_customers/occasion/add_member.php';
  static const String deleteOccasionInvitor =
      '$server/jdolh_customers/occasion/delete_member.php';
  static const String editOccasion =
      '$server/jdolh_customers/occasion/edit_occasion.php';

  static const String viewOccasion =
      '$server/jdolh_customers/occasion/view_occasions.php';
  static const String viewOccasionInvitors =
      '$server/jdolh_customers/occasion/view_invitors.php';
  static const String responedToInvitation =
      '$server/jdolh_customers/occasion/responed_to_invitation.php';
  static const String clearMemberOccasion =
      '$server/jdolh_customers/occasion/clear_members.php';

  static const String addGroupToOccasion =
      '$server/jdolh_customers/occasion/add_group.php';
  static const String deleteGroupFromOccasoin =
      '$server/jdolh_customers/occasion/delete_group.php';

  static const String getOccasion =
      '$server/jdolh_customers/occasion/get_occasion.php';
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

  static const getAllBchs =
      '$server/jdolh_customers/get_brand/get_all_bchs.php';

  // ======= Cart =======//
  static const addCart = '$server/jdolh_customers/cart/add_cart.php';
  static const getCart = '$server/jdolh_customers/cart/get_cart.php';
  static const deleteCart = '$server/jdolh_customers/cart/delete_cart.php';
  static const changeQuantity =
      '$server/jdolh_customers/cart/change_quantity.php';

  //Home Service
  static const String homeServiceAvailable =
      '$server/jdolh_brands/bch/home_available_switch.php';

  static const String getHomeServices =
      '$server/jdolh_brands/bch/home_services/get_home_services.php';

  //ResDetails
  static const String getResDetails =
      '$server/jdolh_brands/bch/get_resdetails.php';

  //===== Reservation =====//
  static const String addResLocation =
      '$server/jdolh_customers/res/add_res_location.php';
  static const String createRes = '$server/jdolh_customers/res/create_res.php';
  static const String getRes = '$server/jdolh_customers/res/get_res.php';
  static const String getReservedTime =
      '$server/jdolh_customers/res/get_reserved_time.php';
  static const String getPolicyTitle =
      '$server/jdolh_customers/res/get_polies_title.php';
  static const String changeResStatus =
      '$server/jdolh_brands/res/change_res_status.php';

  static const String getAllMyRes =
      '$server/jdolh_customers/res/get_all_my_res.php';
  static const String getResCart = '$server/jdolh_brands/res/get_res_cart.php';

  static const String sendInvitations =
      '$server/jdolh_customers/res/send_invitations.php';
  static const String getInvitations =
      '$server/jdolh_customers/res/get_invitations.php';

  // ===== Rate ======//
  static const String addRate = '$server/jdolh_customers/rate/add_rate.php';
  static const String getRate = '$server/jdolh_customers/rate/get_rate.php';
  static const String deleteRate =
      '$server/jdolh_customers/rate/delete_rate.php';

  // ==== Activity ==== //
  static const String getUserActivities =
      '$server/jdolh_customers/get_user_activities.php';
  static const String getFriendsActivities =
      '$server/jdolh_customers/get_friends_activities.php';
  static const String likeUnlikeActivity =
      '$server/jdolh_customers/like_unlike_activity.php';

  static const String getBrandBch =
      '$server/jdolh_customers/get_brand/get_brand_bch.php';

  static const String getHomeScreenData =
      '$server/jdolh_customers/home/home_screen_data.php';

  // == follow bch ==//
  static const String followBch = '$server/jdolh_customers/follow_bch.php';

  static const String getAllUsers = '$server/jdolh_customers/get_all_users.php';

  static const getUserData =
      '$server/jdolh_customers/profile/get_user_data.php';

  // === home ===//
  static const String getTopCheckin =
      '$server/jdolh_customers/home/get_top_checkin.php';
  static const String getTopRes =
      '$server/jdolh_customers/home/get_top_res.php';
  static const String getTopRate =
      '$server/jdolh_customers/home/get_top_rate.php';
  static const String geetTopCheckinPeople =
      '$server/jdolh_customers/home/get_top_checkin_peaple.php';
  static const String getAllAds = '$server/jdolh_admin/ads/get_all_ads.php';
  static const String increaseClickNumber =
      '$server/jdolh_admin/ads/increase_click_count.php';

  //Notifications
  static const String createNotification =
      '$server/jdolh_customers/notification/create_notification.php';
  static const String getNotifications =
      '$server/jdolh_customers/notification/get_notifications.php';

  static const String getAllStores =
      '$server/jdolh_customers/get_all_stores.php';

  //========= Payment =========//
  static const String initiatePayment =
      '$server/jdolh_customers/payment/initiate_payment.php';
}
