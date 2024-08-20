import 'dart:convert';
import 'dart:io';

import 'package:dietsteps/main.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
 import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dietsteps/env.dart' as env;

class AppUpdateChecker {

  Future<bool> checkStatus() async {
    try{
      if (Platform.isAndroid) {
        return await checkAndroidUpdateStatus();
      }
      return await checkIOSUpdateStatus();
    }catch (e){
      print(e);
      return false;
    }

  }

  Future<bool> checkIOSUpdateStatus() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersionName = _getCleanVersion(packageInfo.version);

    VersionStatus versionStatus = await getIosStoreVersionName(packageInfo) ??
        VersionStatus(
            localVersion: packageInfo.version,
            storeVersion: '0.0.0',
            appStoreLink: 'appStoreLink');

    if (versionStatus.canUpdate) {
      FlutterNativeSplash.remove();
      showUpdateDialog(storeLink: versionStatus.appStoreLink);
      return true;
    } else {
      return false;
    }

  }

  Future<bool> checkAndroidUpdateStatus() async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    int appVersionCode = int.parse(packageInfo.buildNumber);
    int storeVersionCode = await getAndroidStoreVersion(appVersionCode);
    print("appVersionCode $appVersionCode");
    print("storeVersionCode $storeVersionCode");
    final uri = Uri.https("play.google.com", "/store/apps/details",
        {"id": env.playStorePackageId, "hl": "en"});

    if (storeVersionCode > appVersionCode) {
      FlutterNativeSplash.remove();
      showUpdateDialog(storeLink: uri.toString());
      return true;
    } else {
      return false;
    }
  }

  Future<VersionStatus?> getIosStoreVersionName(PackageInfo packageInfo) async {
    final id = env.appStorePackageId;
    final parameters = {"bundleId": id};
    String countryCode =
    findCountryCodeEdited(context: MyApp.navigatorKey.currentContext!);

    parameters.addAll({"country": countryCode});

    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      print('Failed to query iOS App Store');
      return null;
    }
    final jsonObj = json.decode(response.body);
    final List results = jsonObj['results'];
    if (results.isEmpty) {
      print('Can\'t find an app in the App Store with the id: $id');
      return null;
    }
    return VersionStatus(
      localVersion: _getCleanVersion(packageInfo.version),
      storeVersion: _getCleanVersion(jsonObj['results'][0]['version']),
      appStoreLink: jsonObj['results'][0]['trackViewUrl'],
      releaseNotes: jsonObj['results'][0]['releaseNotes'],
    );
  }

  Future<String?> getAppStoreLink(String bundleID) async {
    final parameters = {"bundleId": bundleID};
    String countryCode =
    findCountryCodeEdited(context: MyApp.navigatorKey.currentContext!);

    parameters.addAll({"country": countryCode});

    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      print('Failed to query iOS App Store');
      return null;
    }
    final jsonObj = json.decode(response.body);
    final List results = jsonObj['results'];
    if (results.isEmpty) {
      print('Can\'t find an app in the App Store with the id: $bundleID');
      return null;
    }
    return jsonObj['results'][0]['trackViewUrl'];
  }

  String _getCleanVersion(String version) =>
      RegExp(r'\d+\.\d+\.\d+').stringMatch(version) ?? '0.0.0';

  Future<int> getAndroidStoreVersion(int appVersionCode) async {
    try {
      AppUpdateInfo appUpdateInfo = await InAppUpdate.checkForUpdate();
      debugPrint("getAndroidStoreVersion");
      debugPrint(appUpdateInfo.packageName);
      debugPrint(appUpdateInfo.availableVersionCode.toString());
      debugPrint(appUpdateInfo.updateAvailability.toString());
      return appUpdateInfo.availableVersionCode ?? 0;
    } catch (e) {
      debugPrint("getAndroidStoreVersion");
      debugPrint(e.toString());
      return 0;
    }
  }

  void showUpdateDialog({
    required String storeLink,
  }) async {
    BuildContext context = MyApp.navigatorKey.currentContext!;
    final dialogTitleWidget = Text('app_update_title'.tr,style: getHeadlineLargeStyle(context).copyWith(color: APPSTYLE_Grey80));
    final dialogTextWidget = Text( 'app_update_content'.tr,style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text('app_update_button_text'.tr);

    updateAction() {
      launchAppStore(storeLink);
    }

    List<Widget> actions = [
      Platform.isAndroid
          ?  ElevatedButton(
          onPressed:updateAction,
          style: getElevatedButtonStyle(context).copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonTextWidget)
          : CupertinoDialogAction(
        onPressed: updateAction,
        child: updateButtonTextWidget,
      ),
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            )
                : CupertinoAlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

}

class VersionStatus {
  final String localVersion;
  final String storeVersion;
  final String appStoreLink;

  final String? releaseNotes;

  bool get canUpdate {

    final local = localVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();

    for (var i = 0; i < store.length; i++) {
      if (store[i] > local[i]) {
        return true;
      }

      if (local[i] > store[i]) {
        return false;
      }
    }

    return false;

  }

  bool get canUpdateTwo {

    final local = localVersion.split('.').join();
    final store = storeVersion.split('.').join();
    debugPrint("local version $local");
    debugPrint("store version $store");
    if(int.parse(store)>int.parse(local)){
      return true;
    }

    return false;

  }
  VersionStatus({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
    this.releaseNotes,
  });
}

Future<void> launchAppStore(String appStoreLink) async {
  print(appStoreLink);
  if (await canLaunchUrl(Uri.parse(appStoreLink))) {
    await launchUrl(Uri.parse(appStoreLink));
  } else {
    throw 'something_wrong'.tr;
  }
}

String findCountryCodeEdited({required BuildContext context}) {
  Locale? locale = Localizations.maybeLocaleOf(context);

  String code = (locale == null || locale.countryCode == null)
      ? 'US'
      : locale.countryCode!;
  return code;
}
