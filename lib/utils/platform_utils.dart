import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:totalfit/model/device.dart';

String getPlatform() => Platform.operatingSystem;

String getSystemLocale() => Platform.localeName;

String getTimeZone() => DateTime.now().timeZoneName;

Device readAndroidBuildData(AndroidDeviceInfo build) =>
  Device(build.model, build.isPhysicalDevice, build.androidId);

Device readIosDeviceInfo(IosDeviceInfo data) =>
  Device(data.model, data.isPhysicalDevice, data.identifierForVendor);