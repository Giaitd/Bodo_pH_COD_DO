import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/router.dart';

class CalibrationService extends GetxService {
  //calibration
  RxBool calibpH1Zero = false.obs;
  RxBool calibpH1SlopeLo = false.obs;
  RxBool calibpH1SlopeHi = false.obs;

  RxBool calibpH2Zero = false.obs;
  RxBool calibpH2SlopeLo = false.obs;
  RxBool calibpH2SlopeHi = false.obs;

  RxBool calibpH3Zero = false.obs;
  RxBool calibpH3SlopeLo = false.obs;
  RxBool calibpH3SlopeHi = false.obs;

  RxBool calibNH4Zero = false.obs;
  RxBool calibNH4Slope = false.obs;

  RxBool calibDO1Zero = false.obs;
  RxBool calibDO1Slope = false.obs;

  RxBool calibDO2Zero = false.obs;
  RxBool calibDO2Slope = false.obs;

  RxBool calibCODDefault = false.obs;
  RxBool turnOnBrush = false.obs;
  RxBool calibCODSensor = false.obs;
  RxDouble X = 0.2.obs;
  RxDouble Y = 151.3.obs;

  static const platform = MethodChannel('giaitd.com/data');

  //hiệu chuẩn đầu đo PH
  Future<void> calibrationPH1() async {
    var sendDataToNative1 = <String, dynamic>{
      "calibpH1Zero": calibpH1Zero.value,
      "calibpH1SlopeLo": calibpH1SlopeLo.value,
      "calibpH1SlopeHi": calibpH1SlopeHi.value,
    };

    try {
      await platform.invokeMethod('calibrationPH1', sendDataToNative1);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> calibrationPH2() async {
    var sendDataToNative2 = <String, dynamic>{
      "calibpH2Zero": calibpH2Zero.value,
      "calibpH2SlopeLo": calibpH2SlopeLo.value,
      "calibpH2SlopeHi": calibpH2SlopeHi.value,
    };

    try {
      await platform.invokeMethod('calibrationPH2', sendDataToNative2);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> calibrationPH3() async {
    var sendDataToNative3 = <String, dynamic>{
      "calibpH3Zero": calibpH3Zero.value,
      "calibpH3SlopeLo": calibpH3SlopeLo.value,
      "calibpH3SlopeHi": calibpH3SlopeHi.value,
    };

    try {
      await platform.invokeMethod('calibrationPH3', sendDataToNative3);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo DO1
  Future<void> calibrationDO1() async {
    var sendDataToNative2 = <String, dynamic>{
      "calibDO1Zero": calibDO1Zero.value,
      "calibDO1Slope": calibDO1Slope.value,
    };

    try {
      await platform.invokeMethod('calibrationDO1', sendDataToNative2);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo DO1
  Future<void> calibrationDO2() async {
    var sendDataToNative2 = <String, dynamic>{
      "calibDO2Zero": calibDO2Zero.value,
      "calibDO2Slope": calibDO2Slope.value,
    };

    try {
      await platform.invokeMethod('calibrationDO2', sendDataToNative2);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hiệu chuẩn đầu đo COD
  Future<void> calibrationCOD() async {
    var sendDataToNative3 = <String, dynamic>{
      "calibCODDefault": calibCODDefault.value,
      "turnOnBrush": turnOnBrush.value,
      "calibCODSensor": calibCODSensor.value,
      "x": X.value,
      "y": Y.value,
    };

    try {
      await platform.invokeMethod('calibrationCOD', sendDataToNative3);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  //hàm thực hiện hiệu chuẩn đầu đo pH, dùng chung trong widget đầu đo pH
  Future<void> calibFunc(
    bool calibBtn,
  ) async {
    print('data====   ${calibBtn}');
    if (homePageService.lockDevice.value == false) {
      calibBtn = !calibBtn;
      homePageService.lockDevice.value = true;
    } else {
      showNotification();
    }
    print('data====   ${calibBtn}');
  }
}
