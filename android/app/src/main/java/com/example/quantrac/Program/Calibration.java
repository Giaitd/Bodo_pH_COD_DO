package com.example.quantrac.Program;

import android.content.Context;
import android.os.Handler;

import com.example.quantrac.COD_BOD_Module.SdkCodSensor;
import com.example.quantrac.DO_Module.SdkDoSensor;
import com.example.quantrac.PHModule.SdkPHModule;

import java.util.List;
import java.util.TimerTask;

import asim.sdk.locker.DeviceInfo;
import asim.sdk.locker.SDKLocker;

public class Calibration {

    public Calibration() {
        super();
    }

    public static TimerTask CalibrationSensor(Context context) {
        return new TimerTask() {
            Handler mTimerHandler = new Handler();

            public void run() {
                mTimerHandler.post(new Runnable() {
                    @Override
                    public void run() {
                        //PH1
                        //calibration pH1 zero
                        if(Globals.pH1Zero){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration1Zero();
                                }
                            }
                        }

                        //calibration pH1 slope low
                        if(Globals.pH1SlopeLo){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration1SlopeLow();
                                }
                            }
                        }

                        //calibration pH1 slope hi
                        if(Globals.pH1SlopeHi){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration1SlopeHigh();
                                }
                            }
                        }

                        //PH2
                        //calibration pH2 zero
                        if(Globals.pH2Zero){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration2Zero();
                                }
                            }
                        }

                        //calibration pH2 slope low
                        if(Globals.pH2SlopeLo){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration2SlopeLow();
                                }
                            }
                        }

                        //calibration pH2 slope hi
                        if(Globals.pH2SlopeHi){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration2SlopeHigh();
                                }
                            }
                        }

                        //PH3
                        //calibration pH3 zero
                        if(Globals.pH3Zero){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration3Zero();
                                }
                            }
                        }

                        //calibration pH3 slope low
                        if(Globals.pH3SlopeLo){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration3SlopeLow();
                                }
                            }
                        }

                        //calibration pH3 slope hi
                        if(Globals.pH3SlopeHi){
                            SdkPHModule PHSdk = new SdkPHModule();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = PHSdk.connect(context, each, 9600);
                                if (connect) {
                                    PHSdk.calibration3SlopeHigh();
                                }
                            }
                        }


                        //calibration cod sensor to default factory
                        if(Globals.codDefault){
                            SdkCodSensor CODSdk = new SdkCodSensor();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
                                    CODSdk.calibrationCODDefault();
                                }
                            }
                        }

                        //turn on the brush
                        if(Globals.turnOnBrush){
                            SdkCodSensor CODSdk = new SdkCodSensor();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
                                    CODSdk.turnOnTheBrush();
                                }
                            }
                        }

                        //calibration cod sensor
                        if(Globals.codCalibration){
                            SdkCodSensor CODSdk = new SdkCodSensor();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = CODSdk.connect(context, each, 9600);
                                if (connect) {
                                    CODSdk.calibrationCOD();
                                }
                            }
                        }

                        //DO1
                        //calibration DO1 zero
                        if(Globals.do1Zero){
                            SdkDoSensor DOSdk = new SdkDoSensor();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = DOSdk.connect(context, each, 9600);
                                if (connect) {
                                    DOSdk.zeroCalibrationDO1();
                                }
                            }
                        }

                        //calibration DO1 slope
                        if(Globals.do1Slope){
                            SdkDoSensor DOSdk = new SdkDoSensor();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = DOSdk.connect(context, each, 9600);
                                if (connect) {
                                    DOSdk.slopeCalibrationDO1();
                                }
                            }
                        }

                        //DO2
                        //calibration DO2 zero
                        if(Globals.do2Zero){
                            SdkDoSensor DOSdk = new SdkDoSensor();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = DOSdk.connect(context, each, 9600);
                                if (connect) {
                                    DOSdk.zeroCalibrationDO2();
                                }
                            }
                        }

                        //calibration DO2 slope
                        if(Globals.do2Slope){
                            SdkDoSensor DOSdk = new SdkDoSensor();
                            List<DeviceInfo> devices = SDKLocker.getAllUsbDevicesHasDriver(context);
                            for (DeviceInfo each : devices) {
                                boolean connect = DOSdk.connect(context, each, 9600);
                                if (connect) {
                                    DOSdk.slopeCalibrationDO2();
                                }
                            }
                        }
                    }
                });
            }


        };
    }
}
