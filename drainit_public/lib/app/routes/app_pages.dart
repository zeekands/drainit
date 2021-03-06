import 'package:drainit_flutter/app/modules/detail/bindings/detail_binding.dart';
import 'package:drainit_flutter/app/modules/detail/views/detail_view.dart';
import 'package:drainit_flutter/app/modules/edit_password/bindings/edit_password_binding.dart';
import 'package:drainit_flutter/app/modules/edit_password/views/edit_password_view.dart';
import 'package:drainit_flutter/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:drainit_flutter/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/bindings/flood_drainage_list_binding.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/views/flood_drainage_list_view.dart';
import 'package:drainit_flutter/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:drainit_flutter/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:drainit_flutter/app/modules/history/bindings/history_binding.dart';
import 'package:drainit_flutter/app/modules/history/views/history_view.dart';
import 'package:drainit_flutter/app/modules/homepage/bindings/homepage_binding.dart';
import 'package:drainit_flutter/app/modules/homepage/views/homepage_view.dart';
import 'package:drainit_flutter/app/modules/homepage_anonymous/bindings/homepage_anonymous_binding.dart';
import 'package:drainit_flutter/app/modules/homepage_anonymous/views/homepage_anonymous_view.dart';
import 'package:drainit_flutter/app/modules/login/bindings/login_binding.dart';
import 'package:drainit_flutter/app/modules/login/views/login_view.dart';
import 'package:drainit_flutter/app/modules/profile/bindings/profile_binding.dart';
import 'package:drainit_flutter/app/modules/profile/views/profile_view.dart';
import 'package:drainit_flutter/app/modules/register/bindings/register_binding.dart';
import 'package:drainit_flutter/app/modules/register/views/register_view.dart';
import 'package:drainit_flutter/app/modules/register_next/bindings/register_next_binding.dart';
import 'package:drainit_flutter/app/modules/register_next/views/register_next_view.dart';
import 'package:drainit_flutter/app/modules/reports/bindings/reports_binding.dart';
import 'package:drainit_flutter/app/modules/reports/views/reports_view.dart';
import 'package:drainit_flutter/app/modules/searchmap/bindings/searchmap_binding.dart';
import 'package:drainit_flutter/app/modules/searchmap/views/searchmap_view.dart';
import 'package:get/get.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHMAP,
      page: () => SearchmapView(),
      binding: SearchmapBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_NEXT,
      page: () => RegisterNextView(),
      binding: RegisterNextBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PASSWORD,
      page: () => EditPasswordView(),
      binding: EditPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FLOOD_DRAINAGE_LIST,
      page: () => FloodDrainageListView(),
      binding: FloodDrainageListBinding(),
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE_ANONYMOUS,
      page: () => HomepageAnonymousView(),
      binding: HomepageAnonymousBinding(),
    ),
  ];
}
