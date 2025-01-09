package com.example.quantrac.DIDOModule;

import android.content.Context;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.util.Log;

import com.example.quantrac.Program.Globals;
import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;

import java.io.IOException;

import asim.sdk.common.Utils;
import asim.sdk.locker.DeviceInfo;

public class SdkDIDOModule {
    public UsbSerialPort usbSerialPort;
    public boolean connected = false;
    public int READ_WAIT_MILLIS = 100;
    public int WRITE_WAIT_MILLIS = 100;
    public static String checkReadDI, checkReadDO;
    UsbDeviceConnection usbConnection;

    public SdkDIDOModule(){

    }



    public boolean connect(Context context, DeviceInfo deviceInfo, int baudRate) {
        UsbSerialDriver driver = deviceInfo.driver;
        UsbManager usbManager = (UsbManager)context.getSystemService(Context.USB_SERVICE);
        if (driver.getPorts().size() < deviceInfo.port) {
            Log.d("---sdk-lockerDIDO---", "connection failed: not enough ports at device");
            return false;
        } else {
            this.usbSerialPort = (UsbSerialPort)driver.getPorts().get(deviceInfo.port);
            usbConnection = usbManager.openDevice(driver.getDevice());
            if (usbConnection == null) {
                if (!usbManager.hasPermission(driver.getDevice())) {
                    Log.d("---sdk-lockerDIDO---", "connection failed: permission denied");
                } else {
                    Log.d("---sdk-lockerDIDO---", "connection failed: open failed");
                }
                return false;
            } else {
                try {
                    this.usbSerialPort.open(usbConnection);
                    this.usbSerialPort.setParameters(baudRate, 8, 1, UsbSerialPort.PARITY_NONE);
//                    Log.d("---sdk-lockerDIDO---", "connected");
                    this.connected = true;
                    return true;
                } catch (Exception var8) {
                    Log.d("---sdk-lockerDIDO---", "connection failed: " + var8.getMessage());
                    this.disconnect();
                    return false;
                }
            }
        }
    }

    //module 16DI/16DO
    public DIData getDIData() {
        try {
            byte[] buffer = new byte[]{2,2,0,0,0,16,121,-11};
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            checkReadDI = Utils.bytesToHex(new byte[]{bufferStatus[0], bufferStatus[1]});
            if (checkReadDI.equals("0202")) {
                int valueReadDI0 = 0;
                int valueReadDI1 = 0;
                int valueReadDI2 = 0;
                String numberByte = Utils.bytesToHex(new byte[]{bufferStatus[2]});
                int numberByteMore = Integer.parseInt(numberByte);
                if (numberByteMore==1){
                    String value1 = Utils.bytesToHex(new byte[]{bufferStatus[3]});//8 bit low
                    valueReadDI0 = Integer.parseInt(value1,16);

                } else  if (numberByteMore==2){
                    String value1 = Utils.bytesToHex(new byte[]{bufferStatus[3]});//8 bit low
                    String value2 = Utils.bytesToHex(new byte[]{bufferStatus[4]});//8 bit mid
                    valueReadDI0 = Integer.parseInt(value1,16);
                    valueReadDI1 = Integer.parseInt(value2,16);
                }

                boolean[] i0 = new boolean[8];
                boolean[] i1 = new boolean[8];
                boolean[] i2 = new boolean[8];
                for (int i = 0; i < 8; i++) {
                    i0[i] = (valueReadDI0 & (1 << i)) != 0;
                    i1[i] = (valueReadDI1 & (1 << i)) != 0;
                    i2[i] = false;
                }

                this.disconnect();
                return new DIData(i0, i1, i2, valueReadDI0,valueReadDI1,valueReadDI2);

            } else {
                this.disconnect();
                return new DIData(
                        new boolean[8],
                        new boolean[8],
                        new boolean[8],
                        0,
                        0,
                        0
                );
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            return new DIData(
                        new boolean[8],
                        new boolean[8],
                        new boolean[8],
                        0,
                        0,
                        0
                );
        }
    }

    public DOData getDOData() {
        try {
            byte[] buffer = new byte[]{2,1,0,0,0,16,61,-11};
            this.usbSerialPort.write(buffer, this.WRITE_WAIT_MILLIS);
            byte[] bufferStatus = new byte[10];
            this.usbSerialPort.read(bufferStatus, this.READ_WAIT_MILLIS);
            checkReadDO = Utils.bytesToHex(new byte[]{bufferStatus[0], bufferStatus[1]});
            if (checkReadDO.equals("0201")) {
                int valueDO0 = 0;
                int valueDO1 = 0;
                int valueDO2 = 0;

                String numberByte = Utils.bytesToHex(new byte[]{bufferStatus[2]});
                int numberByteMore = Integer.parseInt(numberByte);

                if (numberByteMore==1){
                    String value1 = Utils.bytesToHex(new byte[]{bufferStatus[3]});//8 bit low
                    valueDO0 = Integer.parseInt(value1,16);
                } else if (numberByteMore==2){
                    String value1 = Utils.bytesToHex(new byte[]{bufferStatus[3]});//8 bit low
                    String value2 = Utils.bytesToHex(new byte[]{bufferStatus[4]});//8 bit mid
                    valueDO0 = Integer.parseInt(value1,16);
                    valueDO1 = Integer.parseInt(value2,16);
                }

                boolean[] q0 = new boolean[8];
                boolean[] q1 = new boolean[8];
                boolean[] q2 = new boolean[8];


                for (int i = 0; i < 8; i++) {
                    q0[i] = (valueDO0 & (1 << i)) != 0;
                    q1[i] = (valueDO1 & (1 << i)) != 0;
                    q2[i] = false;
                }


                this.disconnect();
                return new DOData(q0,q1,q2,valueDO0,valueDO1,valueDO2);
            } else {
                this.disconnect();
                return new DOData(
                        new boolean[8],
                        new boolean[8],
                        new boolean[8],
                        0,
                        0,
                        0
                );
            }
        } catch (IOException var14) {
            var14.printStackTrace();
            this.disconnect();
            return new DOData(
                        new boolean[8],
                        new boolean[8],
                        new boolean[8],
                        0,
                        0,
                        0
                );
        }
    }

    public void setDOData() {
        try {
            this.usbSerialPort.write(Globals.bufferAll, this.WRITE_WAIT_MILLIS);
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

    public void close() throws IOException {
        if (usbConnection == null) {
            throw new IOException("Already closed");
        }
        // TODO: nothing sended on close, maybe needed?
        try {
            usbConnection.close();
        } finally {
            usbConnection = null;
        }
    }


}

