import 'package:get/get.dart';
import 'package:temres_apps/app/modules/pendukung/views/edit_view.dart';

import '../core/widget/image/camera_screen.dart';
import '../core/widget/image/image_binding.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dpt/bindings/dpt_binding.dart';
import '../modules/dpt/views/dpt_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pendukung/bindings/pendukung_binding.dart';
import '../modules/pendukung/views/pendukung_view.dart';
import '../modules/pendukung/views/tambah_view.dart';
import '../modules/pendukung/views/tambah_keluarga_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/wilayah/bindings/wilayah_binding.dart';
import '../modules/wilayah/views/wilayah_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WILAYAH,
      page: () => const WilayahView(),
      binding: WilayahBinding(),
    ),
    GetPage(
      name: _Paths.PENDUKUNG,
      page: () => const PendukungView(),
      binding: PendukungBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAHPENDUKUNG,
      page: () => TambahView(),
      binding: PendukungBinding(),
    ),
    GetPage(
      name: _Paths.EDITPENDUKUNG,
      page: () => EditView(),
      binding: PendukungBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAHPENDUKUNGKELUARGA,
      page: () => TambahKeluargaView(),
      binding: PendukungBinding(),
    ),
    GetPage(
      name: _Paths.DPT,
      page: () => DptView(),
      binding: DptBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => CameraScreen(),
      binding: ImageBinding(),
    ),
  ];
}
