import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_ph_cod_hongphat/services/homepage_service.dart';
import '../../common/simple_appbar.dart';
import '../../helper/router.dart';
import '../popup_screen/popup_screen.dart';

class SetId extends StatefulWidget {
  const SetId({Key? key}) : super(key: key);

  @override
  State<SetId> createState() => _SetIdState();
}

class _SetIdState extends State<SetId> {
  HomePageService homePageService = Get.put(HomePageService());

  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      homePageService.setupID();
      if (!homePageService.offSetID.value) {
        homePageService.setID.value = false;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _id1 = '';
  String _id2 = '';
  @override
  Widget build(BuildContext context) {
    double sizeDevice = homePageService.sizeDevice.value;
    return Obx(
      () => Scaffold(
        appBar: simpleAppBar(context, title: 'Cài đặt ID đầu đo'),
        body: SingleChildScrollView(
          child: Container(
            height: 700 / sizeDevice,
            width: 1365 / sizeDevice,
            margin: EdgeInsets.fromLTRB(
                40 / sizeDevice, 30 / sizeDevice, 40 / sizeDevice, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 230 / sizeDevice),
                  child: Text(
                    "ĐỌC KỸ HƯỚNG DẪN SỬ DỤNG TRƯỚC KHI TIẾN HÀNH ĐỔI ID",
                    style: TextStyle(
                        fontSize: 26 / sizeDevice, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 15 / sizeDevice,
                ),
                Text(
                  "- Được sử dụng để thay đổi id cho đầu đo pH, TSS, DO, NH4",
                  style: TextStyle(
                      fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 15 / sizeDevice,
                ),
                Text(
                  "- Chỉ thay đổi trong trường hợp cần thiết và có yêu cầu, hướng dẫn từ nhà sản xuất.",
                  style: TextStyle(
                      fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 5 / sizeDevice,
                ),
                Text(
                  "- Khi thay đổi id, chỉ lắp duy nhất đầu đo cần thay đổi vào bộ đo. Các đầu đo khác phải tháo hết ra.",
                  style: TextStyle(
                      fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 15 / sizeDevice,
                ),
                Text(
                  "- ID mặc định của các đầu đo là 6. Nếu là đầu đo pH thì chỉ thay đổi ID trong khoảng từ 6-13. Các đầu đo khác thì thay đổi theo hướng dẫn của nhà sản xuất",
                  style: TextStyle(
                      fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 15 / sizeDevice,
                ),
                Text(
                  "- Lưu lại thông số id đã thay đổi cho mỗi đầu đo để làm cơ sở sửa chữa, bảo hành sau này.",
                  style: TextStyle(
                      fontSize: 24 / sizeDevice, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 50 / sizeDevice,
                ),
                Row(
                  children: [
                    SizedBox(width: 200 / sizeDevice),
                    Container(
                        height: 190 / sizeDevice,
                        width: 410 / sizeDevice,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/set_id.png',
                            ).image,
                          ),
                        ),
                        child: Column(
                          children: [
                            //id cũ
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  200 / sizeDevice, 20 / sizeDevice, 0, 0),
                              child: Container(
                                height: 65 / sizeDevice,
                                width: 160 / sizeDevice,
                                color: Colors.white,
                                child: Center(
                                  child: TextFormField(
                                    enabled:
                                        (!homePageService.lockDevice.value),
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    onChanged: (text) => {
                                      _id1 = text,
                                      homePageService.idOld.value =
                                          int.parse(_id1),
                                    },
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      hintText: 'nhập id cũ',
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontFamily: 'Roboto Mono',
                                      color: Colors.black,
                                      fontSize: 26 / sizeDevice,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //id mới
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  200 / sizeDevice, 20 / sizeDevice, 0, 0),
                              child: Container(
                                height: 65 / sizeDevice,
                                width: 160 / sizeDevice,
                                color: Colors.white,
                                child: Center(
                                  child: TextFormField(
                                    enabled:
                                        (!homePageService.lockDevice.value),
                                    textAlign: TextAlign.center,
                                    onChanged: (text) => {
                                      _id2 = text,
                                      homePageService.idNew.value =
                                          int.parse(_id2),
                                    },
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      hintText: 'nhập id mới',
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontFamily: 'Roboto Mono',
                                      color: Colors.black,
                                      fontSize: 26 / sizeDevice,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          80 / sizeDevice, 110 / sizeDevice, 0, 0),
                      child: SizedBox(
                        height: 70 / sizeDevice,
                        width: 140 / sizeDevice,
                        child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                if (homePageService.lockDevice.value == false) {
                                  homePageService.setID.value = true;
                                  homePageService.lockDevice.value = true;
                                } else {
                                  showNotification();
                                }
                              });
                            },
                            child: Text(
                              'Set id',
                              style: TextStyle(
                                fontFamily: 'Roboto Mono',
                                color: homePageService.setID.value == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 30 / sizeDevice,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    homePageService.setID.value == true
                                        ? Colors.green
                                        : const Color(0xFFC0C0C0),
                                side: const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
