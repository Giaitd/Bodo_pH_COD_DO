// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePageService extends GetxService {
  RxDouble sizeDevice = 1.0.obs;

  //check timer sent data to server run
  RxBool check = false.obs;

  //androidbox info (use to this topic name to receive thietBiId)
  RxString androidBoxInfo = '20099002'.obs;

  //thietBiId
  RxString thietBiId = "".obs;

  //list data
  RxList pHDataList = [].obs;
  RxList dataQuanTracList = [].obs;
  RxList<dynamic> listData = [].obs;
  //set id
  RxInt idOld = 6.obs;
  RxInt idNew = 7.obs;
  RxBool setID = false.obs;
  RxBool offSetID = false.obs;
  RxBool lockDevice = true.obs;

  //DIDO
  RxInt valueDO0 = 0.obs;
  RxInt valueDI0 = 0.obs;
  RxList<bool> q0 =
      [false, false, false, false, false, false, false, false].obs;
  RxList<bool> i0 =
      [false, false, false, false, false, false, false, false].obs;

  //data setup
  RxDouble pHMinSet = 6.5.obs;
  RxDouble pHMaxSet = 8.5.obs;
  RxDouble codSet = 100.0.obs;

  //data quan trắc
  RxDouble pH1 = 0.0.obs;
  RxDouble temp1 = 0.0.obs;
  RxDouble cod = 0.0.obs;
  RxDouble bod = 0.0.obs;
  RxDouble tss = 0.0.obs;
  RxDouble pH2 = 0.0.obs;
  RxDouble temp2 = 0.0.obs;
  RxDouble pH3 = 0.0.obs;
  RxDouble temp3 = 0.0.obs;
  RxDouble do1 = 0.0.obs;
  RxDouble do2 = 0.0.obs;

  //data offset
  RxDouble offsetpH1 = 0.0.obs;
  RxDouble offsetCOD = 0.0.obs;
  RxDouble offsetTSS = 0.0.obs;
  RxDouble offsetpH2 = 0.0.obs;
  RxDouble offsetpH3 = 0.0.obs;
  RxString offsetpH_1 = "".obs;
  RxDouble offsetDO1 = 0.0.obs;
  RxDouble offsetDO2 = 0.0.obs;

  /// //data save for setup parameter
  Map<String, dynamic> mapSetup = {
    "pHMinSet": "6.5",
    "pHMaxSet": "8.5",
    "codSet": "100.0",
    "offsetDO1": "0.0",
    "offsetDO2": "0.0",
    "offsetpH1": "0.0",
    "offsetpH2": "0.0",
    "offsetpH3": "0.0",
    "offsetCOD": "0.0",
    "offsetTSS": "0.0",
    "thietBiId": "64746b0adf7ac34be49ce692",
  }.obs;

  List<String> keySetup = [
    "pHMinSet",
    "pHMaxSet",
    "codSet",
    "offsetDO1",
    "offsetDO2",
    "offsetpH1",
    "offsetpH2",
    "offsetpH3",
    "offsetCOD",
    "offsetTSS",
    "thietBiId",
  ].obs;
  // ignore: prefer_typing_uninitialized_variables
  var client;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      Timer.periodic(const Duration(milliseconds: 2000), (timer) {
        setDataToNative();
        _getData();
        convertData();
      });
    });
  }

  //get androidBoxInfo
  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
      androidBoxInfo.value = deviceData.androidId!;
    }
  }

  /// ============ MethodChannel=== send/get data to/from native ====================== */

  static const platform = MethodChannel('giaitd.com/data');

  //send data setup to native code
  Future<void> setDataToNative() async {
    var sendDataToNative = <String, dynamic>{
      "pHMinSet": double.parse(mapSetup["pHMinSet"]),
      "pHMaxSet": double.parse(mapSetup["pHMaxSet"]),
      "codSet": double.parse(mapSetup["codSet"]),
      "offsetDO1": double.parse(mapSetup["offsetDO1"]),
      "offsetDO2": double.parse(mapSetup["offsetDO2"]),
      "offsetPH1": double.parse(mapSetup["offsetpH1"]),
      "offsetPH2": double.parse(mapSetup["offsetpH2"]),
      "offsetPH3": double.parse(mapSetup["offsetpH3"]),
      "offsetCOD": double.parse(mapSetup["offsetCOD"]),
      // "offsetTSS": double.parse(mapSetup["offsetTSS"]),
    };

    try {
      await platform.invokeMethod('dataToNative', sendDataToNative);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //get data from native code
  Future<void> _getData() async {
    Map<dynamic, dynamic> getDataValues = {};

    try {
      getDataValues = await platform.invokeMethod('getData');
      pH1.value = getDataValues['getPH1'];
      temp1.value = getDataValues['getTemp1'];
      pH2.value = getDataValues['getPH2'];
      temp2.value = getDataValues['getTemp2'];
      pH3.value = getDataValues['getPH3'];
      temp3.value = getDataValues['getTemp3'];
      cod.value = getDataValues['getCod'];
      // bod.value = getDataValues['getBod'];
      // tss.value = getDataValues['getTss'];
      do1.value = getDataValues['getDO1'];
      do2.value = getDataValues['getDO2'];
      valueDO0.value = getDataValues['getDO0'];
      valueDI0.value = getDataValues['getDI0'];
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //Convert data
  Future<void> convertData() async {
    for (int i = 0; i < 8; i++) {
      q0[i] = (valueDO0 & (1 << i)) != 0;
      i0[i] = (valueDI0 & (1 << i)) != 0;
    }
  }

  Future<void> setupID() async {
    var sendDataToNative1 = <String, dynamic>{
      //id
      "idOld": idOld.value,
      "idNew": idNew.value,
      "btnSetId": setID.value,
    };

    try {
      await platform.invokeMethod('changeID', sendDataToNative1);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
