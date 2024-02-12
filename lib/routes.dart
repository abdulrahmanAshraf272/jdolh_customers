import 'package:get/get.dart';
import 'package:jdolh_customers/controller/auth/forget_password_controller.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/middleware/my_middleware.dart';
import 'package:jdolh_customers/test_screen.dart';
import 'package:jdolh_customers/test_screen2.dart';
import 'package:jdolh_customers/view/screens/add_to_group_screen.dart';
import 'package:jdolh_customers/view/screens/appt_details_screen.dart';
import 'package:jdolh_customers/view/screens/appt_screen.dart';
import 'package:jdolh_customers/view/screens/auth/login_screen.dart';
import 'package:jdolh_customers/view/screens/auth/reset_password_screen.dart';
import 'package:jdolh_customers/view/screens/auth/forget_password_screen.dart';
import 'package:jdolh_customers/view/screens/auth/signup_screen.dart';
import 'package:jdolh_customers/view/screens/auth/success_operation_screen.dart';
import 'package:jdolh_customers/view/screens/auth/verifycode_screen.dart';
import 'package:jdolh_customers/view/screens/bills_screen.dart';
import 'package:jdolh_customers/view/screens/brand_profile_screen.dart';
import 'package:jdolh_customers/view/screens/create_and_edit_group_screen.dart';
import 'package:jdolh_customers/view/screens/create_occasion_screen.dart';
import 'package:jdolh_customers/view/screens/explore_brand_screen.dart';
import 'package:jdolh_customers/view/screens/explore_people_screen.dart';
import 'package:jdolh_customers/view/screens/followers_and_following_screen.dart';
import 'package:jdolh_customers/view/screens/friends_activities_screen.dart';
import 'package:jdolh_customers/view/screens/groups_screen.dart';
import 'package:jdolh_customers/view/screens/home_screen.dart';
import 'package:jdolh_customers/view/screens/invitation_add_screen.dart';
import 'package:jdolh_customers/view/screens/language_screen.dart';
import 'package:jdolh_customers/view/screens/main_screen.dart';
import 'package:jdolh_customers/view/screens/more_screen.dart';
import 'package:jdolh_customers/view/screens/my_profile_screen.dart';
import 'package:jdolh_customers/view/screens/payment_screen.dart';
import 'package:jdolh_customers/view/screens/reservation_done_screen.dart';
import 'package:jdolh_customers/view/screens/reservation_screen.dart';
import 'package:jdolh_customers/view/screens/schedule_screen.dart';
import 'package:jdolh_customers/view/screens/search_screen.dart';
import 'package:jdolh_customers/view/screens/select_product_features_screen.dart';
import 'package:jdolh_customers/view/screens/set_date_screen.dart';
import 'package:jdolh_customers/view/screens/wallet_charging_screen.dart';
import 'package:jdolh_customers/view/screens/wallet_details_screen.dart';

List<GetPage> routes = [
  //Replace Login with onBoarding
  GetPage(
    name: '/',
    page: () => const LoginScreen(),
    middlewares: [MyMiddleware()],
  ),
  //GetPage(name: '/', page: () => const const LanguageScreen(),),
  GetPage(
    name: AppRouteName.login,
    page: () => const LoginScreen(),
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
  GetPage(
    name: AppRouteName.successOperation,
    page: () => const SuccessOperation(),
  ),
  GetPage(
    name: AppRouteName.home,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: AppRouteName.addToGroup,
    page: () => const AddToGroupScreen(),
  ),
  GetPage(
    name: AppRouteName.appt,
    page: () => const ApptScreen(),
  ),
  GetPage(
      name: AppRouteName.apptDetails, page: () => const ApptDetailsScreen()),
  GetPage(
    name: AppRouteName.bills,
    page: () => const BillsScreen(),
  ),
  GetPage(
    name: AppRouteName.brandProfile,
    page: () => const BrandProfileScreen(),
  ),
  GetPage(
    name: AppRouteName.createAndEditGroup,
    page: () => const CreateAndEditGroupScreen(),
  ),

  GetPage(
    name: AppRouteName.createOccasion,
    page: () => const CreateOccasionScreen(),
  ),
  GetPage(
    name: AppRouteName.exploreBrand,
    page: () => const ExploreBrandScreen(),
  ),
  GetPage(
    name: AppRouteName.explorePeople,
    page: () => const ExplorePeopleScreen(),
  ),
  GetPage(
    name: AppRouteName.followersAndFollowing,
    page: () => const FollowersAndFollowingScreen(),
  ),
  GetPage(
    name: AppRouteName.friendsActivities,
    page: () => const FriendsActivitiesScreen(),
  ),
  GetPage(
    name: AppRouteName.gourps,
    page: () => const GroupsScreen(),
  ),
  GetPage(
    name: AppRouteName.invitationAdd,
    page: () => const InvitationAddScreen(),
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
    name: AppRouteName.myProfile,
    page: () => const MyProfileScreen(),
  ),
  GetPage(
    name: AppRouteName.reservationDone,
    page: () => const ReservationDoneScreen(),
  ),
  GetPage(
    name: AppRouteName.reservation,
    page: () => const ReservationScreen(),
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
    name: AppRouteName.selectProductFeature,
    page: () => const SelectProductFeaturesScreen(),
  ),
  GetPage(
    name: AppRouteName.setDate,
    page: () => const SetDateScreen(),
  ),
  GetPage(
    name: AppRouteName.walletCharging,
    page: () => const WalletChargingScreen(),
  ),
  GetPage(
    name: AppRouteName.walletDetails,
    page: () => const WalletDatailsScreen(),
  ),
];
