package com.example.quantrac.DO_Module;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.Program.Globals;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class ReadDoSensor {

    public static TimerTask getCodSensorTask(Context context) {
        Handler mTimerHandler = new Handler();
        return new TimerTask() {
            public void run() {
                mTimerHandler.post(() -> {

                    SdkDoSensor doSensorSDK = new SdkDoSensor();
                    List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);

                    for (DeviceInfo each : devices) {
                        boolean connect = doSensorSDK.connect(context, each, 9600);
                        if (connect) {

                            Globals.do1SensorData = doSensorSDK.getDo1SensorData();
                            if (SdkDoSensor.checkReadDo1.equals("030308")) {

                                Globals.do1 = Math.round((Globals.do1SensorData.dO + Globals.offsetDO1) * 100) / 100.0;


                            } else {
//                                Globals.do1 = -1.0;
                            }
                        }


                        connect = doSensorSDK.connect(context, each, 9600);
                        if (connect) {

                            Globals.do2SensorData = doSensorSDK.getDo2SensorData();
                            if (SdkDoSensor.checkReadDo2.equals("040308")) {

                                Globals.do2 = Math.round((Globals.do2SensorData.dO + Globals.offsetDO2) * 100) / 100.0;

                            } else {
//                                Globals.do2 = -1.0;
                            }
                        }
                    }
                });
            }
        };
    }


}