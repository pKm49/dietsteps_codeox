import 'package:dietsteps/feature_modules/address/controllers/address.controller.dart';
import 'package:dietsteps/feature_modules/auth/controllers/meals.controller.auth.dart';
 import 'package:dietsteps/feature_modules/my_subscription/controller/my_subscription.controller.dart';
import 'package:dietsteps/feature_modules/plan_purchase/controllers/plan_purchase.controller.dart';
import 'package:dietsteps/feature_modules/profile/controllers/profile.controller.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/app_routes.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/asset_urls.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/theme_data.constant.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/controllers/localization.controller.shared.dart';
import 'package:dietsteps/shared_module/controllers/push_notification.controller.shared.dart';
import 'package:dietsteps/shared_module/services/notification-services/push_notification.service.shared.dart';
import 'package:dietsteps/shared_module/services/ui-services/theme_manager.service.shared.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationService().initNotification();
  PushNotificationService().handleFcmNotification(message);
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  PushNotificationService().initNotification();

  PushNotificationController notificationController =
      PushNotificationController();
  notificationController.setupInteractedMessage();
  // await NotificationService.initializeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

AppThemeManager appThemeManager = AppThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    CoreTranslationController.initLanguages();
    appThemeManager.addListener(themeListener);
    Get.put(SharedController());
    Get.put(AddressController());
    Get.put(ProfileController());
    Get.put(MySubscriptionController());
    Get.put(PlanPurchaseController());
    Get.put(MealsController());

    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    appThemeManager.removeListener(themeListener);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(ASSETS_HOME_BG), context);
    precacheImage(AssetImage(ASSETS_WELCOME_LOGIN_BG), context);
    precacheImage(AssetImage(ASSETS_MOBILEVERIFICATION), context);
    precacheImage(AssetImage(ASSETS_OTPMESSAGE), context);
    precacheImage(AssetImage(ASSETS_SUCCESSMARK), context);
    precacheImage(AssetImage(ASSETS_NAMELOGO), context);
    precacheImage(AssetImage(ASSETS_FOODTRUCK), context);
    precacheImage(AssetImage(ASSETS_FOODPLATE), context);
    precacheImage(AssetImage(ASSETS_SELECTHAND), context);
    precacheImage(AssetImage(ASSETS_OFFDAY), context);
    precacheImage(AssetImage(ASSETS_PAUSE), context);

    return GetMaterialApp(
      navigatorKey: MyApp.navigatorKey,
      locale: Get.deviceLocale,
      supportedLocales: const [
        Locale('en'), // English, no country code
        Locale('ar'), // Spanish, no country code
      ],
      fallbackLocale: const Locale('en', 'Us'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      translations: CoreTranslationController(),
      debugShowCheckedModeBanner: false,
      title: 'DietDone',
      theme: getThemeData('light', Get.deviceLocale?.languageCode ?? 'en'),
      darkTheme: getThemeData('dark', Get.deviceLocale?.languageCode ?? 'en'),
      initialRoute: AppRouteNames.splashScreenRoute,
      getPages: AppPages(),
    );
  }
}
