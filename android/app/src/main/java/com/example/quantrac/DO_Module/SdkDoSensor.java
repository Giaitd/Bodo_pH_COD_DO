package com.example.quantrac.DO_Module;

import android.content.Context;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.util.Log;

import com.example.quantrac.PHModule.PHData;
import com.example.quantrac.Program.Globals;
import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;

import java.io.IOException;
import java.math.BigInteger;
import java.util.Arrays;

import asim.sdk.common.Utils;
import asim.sdk.locker.DeviceInfo;


public class SdkDoSensor {
    public UsbSerialPort usbSerialPort;
    public boolean connected = false;
    public int READ_WAIT_MILLIS = 1500;
    public int WRITE_WAIT_MILLIS = 1500;
    public static String checkReadDo1,checkReadDo2;
    UsbDeviceConnection usbConnection;

    public SdkDoSensor() {
    }

    public boolean connect(Context context, DeviceInfo deviceInfo, int baudRate) {
        UsbSerialDriver driver = deviceInfo.driver;
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        if (driver.getPorts().size() < deviceInfo.port) {
            Log.d("---sdk-lockerCOD---", "connection failed: not enough ports at device");
            return false;
        } else {
            this.usbSerialPort = (UsbSerialPort) driver.getPorts().get(deviceInfo.port);
            usbConnection = usbManager.openDevice(driver.getDevice());
            if (usbConnection == null) {
                if (!usbManager.hasPermission(driver.getDevice())) {
                    Log.d("---sdk-lockerCOD---", "connection failed: permission denied");
                } else {
                    Log.d("---sdk-lockerCOD---", "connection failed: open failed");
                }
                return false;
            } else {
                try {
                    this.usbSerialPort.open(usbConnection);
                    this.usbSerialPort.setParameters(baudRate, 8, 1, UsbSerialPort.PARITY_NONE);
                    this.connected = true;
                    return true;
                } catch (Exception var8) {
                    Log.d("---sdk-lockerCOD---", "connection failed: " + var8.getMessage());
                    this.disconnect();
                    return false;
                }
            }
        }
    }

    //read DO1 id: 03
    public DoSensorData getDo1SensorData() {

        try {
            byte[] bufferDo1 = new byte[]{3, 3, 0, 0, 0, 4, 69, -21};//03 03 00 00 00 04 45 eb
            this.usbSerialPort.write(bufferDo1, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus1 = new byte[14];
            this.usbSerialPort.read(bufferStatus1, this.READ_WAIT_MILLIS);
            checkReadDo1 = Utils.bytesToHex(new byte[]{bufferStatus1[0], bufferStatus1[1], bufferStatus1[2]});
            if (checkReadDo1.equals("030308")) {
                String dO1 = Utils.bytesToHex(new byte[]{bufferStatus1[3], bufferStatus1[4]});
                double DOData = (double) Integer.parseInt(dO1, 16) / 100.0D;
                this.disconnect();
                return new DoSensorData(DOData);
            } else {
                this.disconnect();
                return null;
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            this.disconnect();
            return null;
        }
    }

    //read DO2 id: 04
    public DoSensorData getDo2SensorData() {

        try {
            byte[] bufferDo2 = new byte[]{4, 3, 0, 0, 0, 4, 68, 92};//04 03 00 00 00 04 44 5c
            this.usbSerialPort.write(bufferDo2, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus2 = new byte[14];
            this.usbSerialPort.read(bufferStatus2, this.READ_WAIT_MILLIS);
            checkReadDo2 = Utils.bytesToHex(new byte[]{bufferStatus2[0], bufferStatus2[1], bufferStatus2[2]});
            if (checkReadDo2.equals("040308")) {
                String dO2 = Utils.bytesToHex(new byte[]{bufferStatus2[3], bufferStatus2[4]});
                double DOData = (double) Integer.parseInt(dO2, 16) / 100.0D;
                this.disconnect();
                return new DoSensorData(DOData);
            } else {
                this.disconnect();
                return null;
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            this.disconnect();
            return null;
        }
    }

    //zero calibration DO1
    public void zeroCalibrationDO1() {
        try {
            byte[] buffer = new byte[]{3,6,16,0,0,0,-116,-24}; //{03,06,10,00,00,00,8c,e8}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //Slope Calibration DO1
    public void slopeCalibrationDO1() {
        try {
            byte[] buffer = new byte[]{3,6,16,4,0,0,-51,41}; //{03,06,10,04,00,00,cd,29}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //zero calibration DO2
    public void zeroCalibrationDO2() {
        try {
            byte[] buffer = new byte[]{4,6,16,0,0,0,-115,95}; //{04,06,10,00,00,00,8d,5f}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }

    //Slope Calibration DO2
    public void slopeCalibrationDO2() {
        try {
            byte[] buffer = new byte[]{4,6,16,4,0,0,-52,-98}; //{04,06,10,04,00,00,cc,9e}
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            this.disconnect();
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
        }
    }



    public void disconnect() {
        this.connected = false;

        try {
            this.usbSerialPort.close();
        } catch (IOException var2) {
        }

        this.usbSerialPort = null;
    }
}
