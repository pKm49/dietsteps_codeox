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
    try {
      print("DEBUG: checkStatus called");
      if (Platform.isAndroid) {
        print("DEBUG: Device is Android, checking Android update");
        return await checkAndroidUpdateStatus();
      }
      print("DEBUG: Device is iOS, checking iOS update");
      return await checkIOSUpdateStatus();
    } catch (e) {
      print("DEBUG: Error in checkStatus: $e");
      print("error in app update");
      return false;
    }
  }

  Future<bool> checkIOSUpdateStatus() async {
    print("DEBUG: Starting iOS update check");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersionName = _getCleanVersion(packageInfo.version);
    print("DEBUG: Local app version: $appVersionName");

    print("DEBUG: Calling getIosStoreVersionName");
    VersionStatus? versionStatus = await getIosStoreVersionName(packageInfo);
    print("DEBUG: Result from getIosStoreVersionName: ${versionStatus != null ? 'Success' : 'Null'}");

    if (versionStatus == null) {
      print("DEBUG: versionStatus is null, using fallback version");
      versionStatus = VersionStatus(
          localVersion: packageInfo.version,
          storeVersion: '0.0.0',
          appStoreLink: 'appStoreLink');
    }

    print("DEBUG: Local version: ${versionStatus.localVersion}");
    print("DEBUG: Store version: ${versionStatus.storeVersion}");
    print("DEBUG: Can update: ${versionStatus.canUpdate}");

    if (versionStatus.canUpdate) {
      print("DEBUG: Update available, showing dialog");
      FlutterNativeSplash.remove();
      showUpdateDialog(storeLink: versionStatus.appStoreLink);
      return true;
    } else {
      print("DEBUG: No update needed");
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
    print("DEBUG: Inside getIosStoreVersionName");
    final id = env.appStorePackageId;
    print("DEBUG: App Store Package ID: $id");

    final parameters = {"bundleId": id};

    BuildContext? context = MyApp.navigatorKey.currentContext;
    print("DEBUG: Context available: ${context != null}");

    if (context == null) {
      print("DEBUG: Context is null, can't get country code");
      parameters.addAll({"country": "US"}); // Default to US
    } else {
      String countryCode = findCountryCodeEdited(context: context);
      print("DEBUG: Country code: $countryCode");
      parameters.addAll({"country": countryCode});
    }

    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    print("DEBUG: iTunes API URL: $uri");

    try {
      print("DEBUG: Making HTTP request to iTunes API");
      final response = await http.get(uri);
      print("DEBUG: Response status code: ${response.statusCode}");

      if (response.statusCode != 200) {
        print('DEBUG: Failed to query iOS App Store, status: ${response.statusCode}');
        return null;
      }

      print("DEBUG: Response body length: ${response.body.length}");
      print("DEBUG: Response body preview: ${response.body.substring(0, min(100, response.body.length))}...");

      final jsonObj = json.decode(response.body);
      final List results = jsonObj['results'];

      if (results.isEmpty) {
        print('DEBUG: Empty results from iTunes API. Can\'t find app with ID: $id');
        return null;
      }

      print("DEBUG: Found app in store: ${jsonObj['results'][0]['trackName']}");
      print("DEBUG: Store version: ${jsonObj['results'][0]['version']}");
      print("DEBUG: Local version: ${_getCleanVersion(packageInfo.version)}");

      VersionStatus status = VersionStatus(
        localVersion: _getCleanVersion(packageInfo.version),
        storeVersion: _getCleanVersion(jsonObj['results'][0]['version']),
        appStoreLink: jsonObj['results'][0]['trackViewUrl'],
        releaseNotes: jsonObj['results'][0]['releaseNotes'],
      );

      print("DEBUG: Can update (calculated): ${status.canUpdate}");
      print("DEBUG: Can update two (alternative calculation): ${status.canUpdateTwo}");

      return status;
    } catch (e) {
      print("DEBUG: Exception in getIosStoreVersionName: $e");
      return null;
    }
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

  String _getCleanVersion(String version) {
    String? match = RegExp(r'\d+\.\d+\.\d+').stringMatch(version);
    print("DEBUG: Cleaning version '$version', result: ${match ?? '0.0.0'}");
    return match ?? '0.0.0';
  }

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
    print("DEBUG: Showing update dialog with link: $storeLink");
    BuildContext context = MyApp.navigatorKey.currentContext!;
    final dialogTitleWidget = Text('app_update_title'.tr,
        style: getHeadlineLargeStyle(context).copyWith(color: APPSTYLE_Grey80));
    final dialogTextWidget = Text(
      'app_update_content'.tr,
      style: getBodyMediumStyle(context),
    );

    final updateButtonTextWidget = Text(
      'app_update_button_text'.tr,
      style: TextStyle(color: APPSTYLE_BackgroundWhite),
    );

    updateAction() {
      print("DEBUG: Update button pressed, launching: $storeLink");
      launchAppStore(storeLink);
    }

    List<Widget> actions = [
      Platform.isAndroid
          ? ElevatedButton(
          onPressed: updateAction,
          style: getElevatedButtonStyle(context).copyWith(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                      horizontal: APPSTYLE_SpaceLarge,
                      vertical: APPSTYLE_SpaceSmall))),
          child: updateButtonTextWidget)
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
      if (i >= local.length) {
        // If store has more version segments than local, consider it an update
        return true;
      }

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
    if (int.parse(store) > int.parse(local)) {
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
  print("DEBUG: launchAppStore called with: $appStoreLink");
  if (await canLaunchUrl(Uri.parse(appStoreLink))) {
    print("DEBUG: Can launch URL, launching app store");
    await launchUrl(Uri.parse(appStoreLink));
  } else {
    print("DEBUG: Cannot launch URL: $appStoreLink");
    throw 'something_wrong'.tr;
  }
}

String findCountryCodeEdited({required BuildContext context}) {
  Locale? locale = Localizations.maybeLocaleOf(context);
  String code = (locale == null || locale.countryCode == null)
      ? 'US'
      : locale.countryCode!;
  print("DEBUG: findCountryCodeEdited returning: $code");
  return code;
}

// Helper function for substring
int min(int a, int b) => a < b ? a : b;