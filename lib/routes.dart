import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/middleware/my_middleware.dart';
import 'package:jdolh_customers/view/screens/add_members_screen.dart';
import 'package:jdolh_customers/view/screens/auth/edit_personal_data_screen.dart';
import 'package:jdolh_customers/view/screens/bills/bill_details_screen.dart';
import 'package:jdolh_customers/view/screens/bills/bill_payment_result_screen.dart';
import 'package:jdolh_customers/view/screens/bills/divide_bill_screen.dart';
import 'package:jdolh_customers/view/screens/bills/select_payment_method_screen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/all_bchs_screen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/display_worktime_screen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/set_res_time_screen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/wait_for_approve_screen.dart';
import 'package:jdolh_customers/view/screens/checkin/add_new_place_screen.dart';
import 'package:jdolh_customers/view/screens/checkin/checkin_confirm_screen.dart';
import 'package:jdolh_customers/view/screens/checkin/checkin_screen.dart';
import 'package:jdolh_customers/view/screens/display_location_screen.dart';

import 'package:jdolh_customers/view/screens/auth/login_screen.dart';
import 'package:jdolh_customers/view/screens/auth/reset_password_screen.dart';
import 'package:jdolh_customers/view/screens/auth/forget_password_screen.dart';
import 'package:jdolh_customers/view/screens/auth/signup_screen.dart';
import 'package:jdolh_customers/view/screens/auth/success_operation_screen.dart';
import 'package:jdolh_customers/view/screens/auth/verifycode_screen.dart';
import 'package:jdolh_customers/view/screens/bills/bills_screen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/brand_profile_screen.dart';
import 'package:jdolh_customers/view/screens/explore_checkin_screen.dart';
import 'package:jdolh_customers/view/screens/groups/create_group_screen.dart';
import 'package:jdolh_customers/view/screens/my_contacts_screen.dart';
import 'package:jdolh_customers/view/screens/notifications_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/create_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/explore_brand_screen.dart';
import 'package:jdolh_customers/view/screens/explore_people_screen.dart';
import 'package:jdolh_customers/view/screens/friends_activities_screen.dart';
import 'package:jdolh_customers/view/screens/groups/edit_group_screen.dart';
import 'package:jdolh_customers/view/screens/groups/group_details_screen.dart';
import 'package:jdolh_customers/view/screens/groups/groups_screen.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/language_screen.dart';
import 'package:jdolh_customers/view/screens/main_screen.dart';
import 'package:jdolh_customers/view/screens/more_screen.dart';
import 'package:jdolh_customers/view/screens/my_profile_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/edit_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/finished_occasions_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/occasion_details_screen.dart';
import 'package:jdolh_customers/view/screens/occasion/occasions_screen.dart';
import 'package:jdolh_customers/view/screens/payment_result_screen.dart';
import 'package:jdolh_customers/view/screens/payment_screen.dart';
import 'package:jdolh_customers/view/screens/person_profile_screen.dart';
import 'package:jdolh_customers/view/screens/rates_and_scheduled/bch_followers_screen.dart';
import 'package:jdolh_customers/view/screens/rates_and_scheduled/rates_screen.dart';
import 'package:jdolh_customers/view/screens/rates_and_scheduled/scheduled_users_screen.dart';
import 'package:jdolh_customers/view/screens/res_archive_details_screen.dart';
import 'package:jdolh_customers/view/screens/res_archive_screen.dart';
import 'package:jdolh_customers/view/screens/res_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/reservation_search_screen.dart';
import 'package:jdolh_customers/view/screens/schedule/reservation_confirm_wait_screen.dart';
import 'package:jdolh_customers/view/screens/schedule/reservation_details_screen.dart';
import 'package:jdolh_customers/view/screens/schedule/reservation_with_invitors_details_screen.dart';
import 'package:jdolh_customers/view/screens/schedule/schedule_screen.dart';
import 'package:jdolh_customers/view/screens/search_screen.dart';
import 'package:jdolh_customers/view/screens/select_address_screen.dart';
import 'package:jdolh_customers/view/screens/brand_profile/items_details_screen.dart';
import 'package:jdolh_customers/view/screens/set_date_screen.dart';
import 'package:jdolh_customers/view/screens/wallet/transfer_money_screen.dart';
import 'package:jdolh_customers/view/screens/wallet/wallet_charging_result_screen.dart';
import 'package:jdolh_customers/view/screens/wallet/wallet_charging_screen.dart';
import 'package:jdolh_customers/view/screens/wallet/wallet_details_screen.dart';

List<GetPage> routes = [
  //Replace Login with onBoarding
  GetPage(
    name: '/',
    page: () => const LoginScreen(),
    middlewares: [MyMiddleware()],
  ),
  // GetPage(
  //   name: '/',
  //   page: () => const TestPayment(),
  // ),
  //For testing

  // GetPage(
  //   name: '/',
  //   page: () => const ReservationSearchScreen(),
  // ),
  GetPage(
      name: AppRouteName.transferMoney,
      page: () => const TranferMoneyScreen(),
      popGesture: true),
  GetPage(
    name: AppRouteName.billPaymentResult,
    page: () => const BillPaymentResultScreen(),
  ),
  GetPage(
    name: AppRouteName.divideBill,
    page: () => const DivideBillScreen(),
  ),
  GetPage(
    name: AppRouteName.selectPaymentMethod,
    page: () => const SelectPaymentMethodScreen(),
  ),
  GetPage(
    name: AppRouteName.billDetails,
    page: () => const BillDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.walletChargingResult,
    page: () => const WalletChargingResultScreen(),
  ),
  GetPage(
    name: AppRouteName.paymentResult,
    page: () => const PaymentResultScreen(),
  ),
  GetPage(
    name: AppRouteName.reservationWithInvitors,
    page: () => const ReservationWithInvitorsDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.notifications,
    page: () => const NotificationsScreen(),
  ),
  GetPage(
    name: AppRouteName.editPersonalData,
    page: () => const EdtiPersonalDataScreen(),
  ),
  GetPage(
    name: AppRouteName.resOccasion,
    page: () => const ResOccasionScreen(),
  ),
  GetPage(
    name: AppRouteName.myContacts,
    page: () => const MyContactsScreen(),
  ),
  GetPage(
    name: AppRouteName.displayWorktime,
    page: () => const DisplayWorktimeScreen(),
  ),
  GetPage(
    name: AppRouteName.resArchiveDetails,
    page: () => const ResArchiveDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.resArchive,
    page: () => const ResArchiveScreen(),
  ),
  GetPage(
    name: AppRouteName.reservationDetails,
    page: () => const ReservationDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.brandProfile,
    page: () => const BrandProfileScreen(),
  ),

  GetPage(
    name: AppRouteName.login,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRouteName.checkin,
    page: () => const CheckinScreen(),
  ),
  GetPage(
      name: AppRouteName.selectAddressScreen,
      page: () => const SelectAddressScreen(),
      popGesture: true),
  GetPage(
    name: AppRouteName.checkinConfirm,
    page: () => const CheckinConfirmScreen(),
  ),
  GetPage(
    name: AppRouteName.diplayLocation,
    page: () => const DisplayLocationScreen(),
  ),
  GetPage(
    name: AppRouteName.addNewPlace,
    page: () => const AddNewPlaceScreen(),
  ),
  GetPage(
    name: AppRouteName.exploreCheckin,
    page: () => const ExploreCheckinScreen(),
  ),
  GetPage(
      name: AppRouteName.allBchs,
      page: () => const AllBchsScreen(),
      popGesture: true),
  // GetPage(
  //   name: AppRouteName.addMembersCheckin,
  //   page: () => const AddMembersCheckinScreen(),
  // ),
  GetPage(
    name: AppRouteName.rates,
    page: () => const RatesScreen(),
  ),
  GetPage(
    name: AppRouteName.bchFollowers,
    page: () => const BchFollowersScreen(),
  ),
  GetPage(
    name: AppRouteName.scheduledUsers,
    page: () => const ScheduledUsersScreen(),
  ),
  GetPage(
    name: AppRouteName.signUp,
    page: () => const SignupScreen(),
  ),
  GetPage(
    name: AppRouteName.resetPassword,
    page: () => const ResetPasswordScreen(),
  ),
  GetPage(
    name: AppRouteName.verifyCode,
    page: () => const VerifycodeScreen(),
  ),
  GetPage(
    name: AppRouteName.forgetPassword,
    page: () => const ForgetPasswordScreen(),
  ),
  // GetPage(
  //   name: AppRouteName.addOccasionLocation,
  //   page: () => const AddOccasionLocationScreen(),
  // ),
  GetPage(
    name: AppRouteName.finishedOccasions,
    page: () => const FinishedOccasionsScreen(),
  ),
  GetPage(
    name: AppRouteName.reservationConfirmWait,
    page: () => const ReservationConfirmWaitScreen(),
  ),
  GetPage(
    name: AppRouteName.successOperation,
    page: () => const SuccessOperation(),
  ),
  GetPage(
    name: AppRouteName.personProfile,
    page: () => const PersonProfile(),
  ),
  GetPage(
    name: AppRouteName.home,
    page: () => const HomeScreen(),
  ),

  GetPage(
    name: AppRouteName.bills,
    page: () => const BillsScreen(),
  ),

  GetPage(
      name: AppRouteName.createGroup,
      page: () => const CreateGroupScreen(),
      popGesture: true),
  GetPage(
    name: AppRouteName.editGroup,
    page: () => const EditGroupScreen(),
  ),

  GetPage(
      name: AppRouteName.addMembers,
      page: () => const AddMembersScreen(),
      popGesture: true),
  GetPage(
    name: AppRouteName.createOccasion,
    page: () => const CreateOccasionScreen(),
  ),
  GetPage(
    name: AppRouteName.occasions,
    page: () => const OccasionsScreen(),
  ),
  GetPage(
    name: AppRouteName.occasionDetails,
    page: () => const OccasionDetailsScreen(),
  ),
  GetPage(
    name: AppRouteName.editOccasion,
    page: () => const EditOccasionScreen(),
  ),

  GetPage(
    name: AppRouteName.exploreBrand,
    page: () => const ExploreBrandScreen(),
  ),
  GetPage(
    name: AppRouteName.explorePeople,
    page: () => const ExplorePeopleScreen(),
  ),
  // GetPage(
  //   name: AppRouteName.followersAndFollowing,
  //   page: () => const FollowersAndFollowingScreen(),
  // ),
  GetPage(
    name: AppRouteName.friendsActivities,
    page: () => const FriendsActivitiesScreen(),
  ),
  GetPage(
    name: AppRouteName.groupDetails,
    page: () => const GroupDetails(),
  ),
  GetPage(
    name: AppRouteName.gourps,
    page: () => const GroupsScreen(),
  ),

  GetPage(
    name: AppRouteName.language,
    page: () => const LanguageScreen(),
  ),
  GetPage(
    name: AppRouteName.mainScreen,
    page: () => const MainScreen(),
  ),
  GetPage(
    name: AppRouteName.more,
    page: () => const MoreScreen(),
  ),

  GetPage(
    name: AppRouteName.payment,
    page: () => const PaymentScreen(),
  ),
  GetPage(
    name: AppRouteName.waitForApprove,
    page: () => const WaitForApproveScreen(),
  ),
  GetPage(
    name: AppRouteName.myProfile,
    page: () => const MyProfileScreen(),
  ),

  GetPage(
    name: AppRouteName.reservation,
    page: () => const ReservationSearchScreen(),
  ),
  GetPage(
    name: AppRouteName.schedule,
    page: () => const ScheduleScreen(),
  ),

  GetPage(
    name: AppRouteName.search,
    page: () => const SearchScreen(),
  ),
  GetPage(
    name: AppRouteName.itemsDetails,
    page: () => const ItemsDetailsScreen(),
  ),
  // GetPage(
  //   name: AppRouteName.addResInvitors,
  //   page: () => const AddResInvitorsScreen(),
  // ),
  GetPage(
      name: AppRouteName.setResTime,
      page: () => const SetResTimeScreen(),
      popGesture: true),
  GetPage(
    name: AppRouteName.setDate,
    page: () => const SetDateScreen(),
  ),
  GetPage(
      name: AppRouteName.walletCharging,
      page: () => const WalletChargingScreen(),
      popGesture: true),
  GetPage(
    name: AppRouteName.walletDetails,
    page: () => const WalletDatailsScreen(),
  ),
];
