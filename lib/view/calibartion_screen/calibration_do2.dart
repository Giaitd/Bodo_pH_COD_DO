import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/helper/router.dart';
import 'package:do_ph_cod_hongphat/services/calibration_service.dart';
import '../../services/homepage_service.dart';
import '../../services/secure_storage.dart';
import '../popup_screen/popup_screen.dart';

class CalibrationDO2 extends StatefulWidget {
  const CalibrationDO2({Key? key}) : super(key: key);

  @override
  State<CalibrationDO2> createState() => _CalibrationDO2State();
}

class _CalibrationDO2State extends State<CalibrationDO2> {
  HomePageService homePageService = Get.put(HomePageService());
  CalibrationService calibrationService = Get.put(CalibrationService());
  SecureStorage storage = Get.put(SecureStorage());
  Timer? timer5;

  @override
  void initState() {
    super.initState();
    if (timer5 != null) timer5!.cancel();
    timer5 = Timer.periodic(const Duration(seconds: 1), (timer) {
      calibrationService.calibrationDO2();
      calibrationService.calibDO2Zero.value = false;
      calibrationService.calibDO2Slope.value = false;
    });
  }

  @override
  void dispose() {
    timer5!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Container(
        width: 1365 / sizeDevice,
        height: 580 / sizeDevice,
        margin: EdgeInsets.fromLTRB(
            40 / sizeDevice, 30 / sizeDevice, 40 / sizeDevice, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //text hướng dẫn
          Padding(
            padding: EdgeInsets.only(left: 230 / sizeDevice),
            child: Text(
              "ĐỌC KỸ HƯỚNG DẪN SỬ DỤNG TRƯỚC KHI TIẾN HÀNH HIỆU CHUẨN",
              style: TextStyle(
                  fontSize: 26 / sizeDevice, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 15 / sizeDevice,
          ),

          Text(
            "- Hiệu chuẩn zero:",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w900),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "   + Đổ 95ml nước vào bình đong dung tích 250ml, thêm 5g Natri Sulfit vào, dùng đũa thủy tinh khuấy đều. Ta được dung dịch hòa tan 5% Natri Sulfit. ",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 5 / sizeDevice,
          ),
          Text(
            "   + Đặt cảm biến vào dung dịch. Đợi khoảng 3-5 phút rồi ấn nút hiệu chuẩn Zero.",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "- Hiệu chuẩn Slope",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w900),
          ),
          Container(
            height: 15 / sizeDevice,
          ),
          Text(
            "   + Chuẩn bị nước bão hòa không khí: Đổ nước cất vào 2/3 vật chứa thể tích > 3l. Đặt tấm xốp lên trên mặt nước ngăn tiếp xúc giữa không khí và nước.",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 5 / sizeDevice,
          ),
          Text(
            "   + Sử dụng máy sục khí sục liên tục trong 1 giờ, sau đó dừng lại. Sau 20 phút hoặc lâu hơn, thu được nước bão hòa không khí.",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 5 / sizeDevice,
          ),
          Text(
            "   + Đặt cảm biến vào và ấn hiệu chuẩn Slope.",
            style: TextStyle(
                fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
          ),

          //nhập thông số
          Container(
            margin: EdgeInsets.fromLTRB(0, 30 / sizeDevice, 0, 0),
            child: Row(children: [
              Container(
                width: 450 / sizeDevice,
                height: 150 / sizeDevice,
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Column(children: [
                  //pH =======
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        12 / sizeDevice, 18 / sizeDevice, 27 / sizeDevice, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 183 / sizeDevice,
                          height: 50 / sizeDevice,
                          alignment: Alignment.center,
                          child: Text(
                            "DO",
                            style: TextStyle(
                                fontSize: 24 / sizeDevice,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 160 / sizeDevice,
                          height: 50 / sizeDevice,
                          alignment: Alignment.center,
                          child: Text(
                            homePageService.do2.value.toString(),
                            style: TextStyle(
                              fontSize: 34 / sizeDevice,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black, width: 1 / sizeDevice)),
                        ),
                      ],
                    ),
                  ),

                  //offset DO
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        12 / sizeDevice, 12 / sizeDevice, 27 / sizeDevice, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 183 / sizeDevice,
                          height: 50 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 20 / sizeDevice),
                              Text(
                                "Offset",
                                style: TextStyle(
                                    fontSize: 24 / sizeDevice,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 160 / sizeDevice,
                          height: 50 / sizeDevice,
                          child: TextFormField(
                            enabled: (!homePageService.lockDevice.value),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.bottom,
                            onChanged: (text) {
                              if (double.parse(text) < -100 ||
                                  double.parse(text) > 100) {
                                PopupScreen().anounDialog(context);
                              } else {
                                homePageService.offsetDO2.value =
                                    double.parse(text);

                                storage.writeDataSetup(4);
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: homePageService.mapSetup["offsetDO2"],
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero)),
                            style: TextStyle(
                              fontSize: 34 / sizeDevice,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Container(width: 50 / sizeDevice),
              Container(
                width: 750 / sizeDevice,
                height: 150 / sizeDevice,
                color: const Color.fromARGB(255, 166, 219, 221),
                child: Row(children: [
                  //hiệu chuẩn pH điểm 0
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        90 / sizeDevice, 32 / sizeDevice, 0, 0),
                    width: 250 / sizeDevice,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          if (homePageService.lockDevice.value == false) {
                            setState(() {
                              calibrationService.calibDO2Zero.value = true;
                              homePageService.lockDevice.value = true;
                            });
                          } else {
                            showNotification();
                          }
                        },
                        child: Container(
                          height: 100 / sizeDevice,
                          width: 250 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 15 / sizeDevice),
                              Text(
                                "Hiệu chuẩn",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        calibrationService.calibDO2Zero.value ==
                                                true
                                            ? Colors.red
                                            : Colors.white),
                              ),
                              Text(
                                "zero",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        calibrationService.calibDO2Zero.value ==
                                                true
                                            ? Colors.red
                                            : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4657ef)),
                      ),
                    ]),
                  ),

                  // hiệu chuẩn slope
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        60 / sizeDevice, 32 / sizeDevice, 0, 0),
                    width: 250 / sizeDevice,
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          if (homePageService.lockDevice.value == false) {
                            setState(() {
                              calibrationService.calibDO2Slope.value = true;
                              homePageService.lockDevice.value = true;
                            });
                          } else {
                            showNotification();
                          }
                        },
                        child: Container(
                          height: 100 / sizeDevice,
                          width: 250 / sizeDevice,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 15 / sizeDevice),
                              Text(
                                "Hiệu chuẩn",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: calibrationService
                                                .calibDO2Slope.value ==
                                            true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                "slope",
                                style: TextStyle(
                                    fontSize: 30 / sizeDevice,
                                    fontWeight: FontWeight.bold,
                                    color: calibrationService
                                                .calibDO2Slope.value ==
                                            true
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4657ef)),
                      ),
                    ]),
                  ),
                ]),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
