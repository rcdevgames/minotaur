import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.restoreSystemUIOverlays();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("53e65003-b3a0-4237-9862-07f245ef217f");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  await GetStorage.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "TemresApps",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
      // initialRoute: AppRoutes.splash,
      // getPages: AppPages.list,
      // theme: AppTheme.light,
      themeMode: ThemeMode.system,
    );
  }
}
