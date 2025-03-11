import 'package:live_app/binding/HomeBinding.dart';
import 'package:live_app/constant/route.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:live_app/core/NavigationBar/NavigationBar.dart';
import 'package:live_app/core/Midellware/mideelware.dart';
import 'package:live_app/credential_manage.dart/change_password.dart';
import 'package:live_app/view/chosepage/ChosePage.dart';
import 'package:live_app/view/chosepage/chosepageforseller.dart';
import 'package:live_app/view/homepage/homepage.dart';
import 'package:live_app/view/login/login-signup.dart';
import 'package:live_app/view/login/reset-password.dart';
import 'package:live_app/view/onboarding/CustomSlider.dart';
import 'package:live_app/view/payment/paymentPage.dart';
import 'package:live_app/view/profile/Editprofilepage.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: AppRoute.navigation,
    page: () => CustomNavigationbar(),
    middlewares: [Mymidellware()],
  ),
  GetPage(
    name: AppRoute.home,
    page: () => HomePage(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: AppRoute.Login,
    page: () => LoginPage(),
  ),
  GetPage(
    name: AppRoute.OnboardingPage,
    page: () => CustomPageView(),
  ),
  GetPage(
    name: AppRoute.EditProfilePage,
    page: () => EditProfilePage(),
  ),
  GetPage(
    name: AppRoute.resetpassword,
    page: () => ResetPassword(),
  ),
  GetPage(
    name: AppRoute.changepassword,
    page: () => ChangePassword(),
  ),
  GetPage(
    name: AppRoute.chosepage,
    page: () => Chosepage(),
  ),
  GetPage(
    name: AppRoute.chosepageforseller,
    page: () => Chosepageforseller(),
  ),
  GetPage(
    name: AppRoute.payment,
    page: () => Payment()),
  // Additional routes can be uncommented and used as needed.
  // GetPage(name: AppRoute.SignUp, page: () => Signup()),
  // GetPage(name: AppRoute.ForgetPassword, page: () => Forgetpassword()),
  // GetPage(name: AppRoute.VerifyCode, page: () => Verifycode()),
  // GetPage(name: AppRoute.ResetPassword, page: () => Resetpassword()),
  // GetPage(name: AppRoute.Successsignup, page: () => Successsignup()),
  // GetPage(name: AppRoute.Successresetpassword, page: () => Successresetpassword()),
  // GetPage(name: AppRoute.VerifyCodeSignUp, page: () => VerifyCodeSignUp()),
];
