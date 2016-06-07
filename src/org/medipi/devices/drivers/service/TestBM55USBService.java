/*
 Copyright 2016  Richard Robinson @ HSCIC <rrobinson@hscic.gov.uk, rrobinson@nhs.net>

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
package org.medipi.devices.drivers.service;

import java.util.ArrayList;
import java.util.List;

import javax.usb.UsbControlIrp;
import javax.usb.UsbDevice;
import javax.usb.UsbPipe;

import org.junit.Test;
import org.medipi.devices.drivers.domain.BM55Measurement;
import org.medipi.devices.drivers.domain.BM55User;

/**
 * Tests the BM55 device interfaces and collects the measurements it has stored.
 *
 * @author krishna.kuntala@mastek.com
 */
public class TestBM55USBService {

	private static final int VENDOR_ID = 0x0c45;
	private static final int PRODUCT_ID = 0x7406;
	private USBService usbService = new BM55USBService();

	/**
	 * Test BM55 device to get the measurements.
	 *
	 * @throws Exception the exception
	 */
	@Test
	public void testGetBM55Measurements() throws Exception {
		BM55User readingsUser = BM55User.valueOf("A");
		List<BM55Measurement> measurements = new ArrayList<BM55Measurement>();
		UsbDevice device = usbService.getUSBDevice(VENDOR_ID, PRODUCT_ID);

		UsbPipe connectionPipe = usbService.getUSBConnection(device, 0, -127);
		byte requestType = 33;
		byte request = 0x09;
		short value = 521;
		short index = 0;
		UsbControlIrp usbControl = usbService.getUSBControl(device, requestType, request, value, index);
		try {
			connectionPipe.open();
			usbService.initialiseDevice(device, usbControl, connectionPipe);
			int numberOfReadings = usbService.getNumberOfReadings(device, usbControl, connectionPipe);

			BM55Measurement measurement;
			byte[] data;
			for(int readingsCounter = 1; readingsCounter < numberOfReadings; readingsCounter++) {
				usbService.writeDataToInterface(device, usbControl, new byte[] {(byte) 0xA3, (byte) readingsCounter}, BM55USBService.DEFAULT_BYTE_ARRAY_LENGTH_8, BM55USBService.PADDING_BYTE_0xF4);
				data = usbService.readData(connectionPipe, 8);
				measurement = new BM55Measurement(data);
				if(measurement.getUser().equals(readingsUser)) {
					measurements.add(new BM55Measurement(data));
				}
			}
			usbService.terminateDeviceCommunication(device, usbControl);
		} finally {
			if(connectionPipe != null && connectionPipe.isOpen()) {
				connectionPipe.close();
				connectionPipe.getUsbEndpoint().getUsbInterface().release();
			}
		}
		System.out.println("Number of readings:" + measurements.size() + "\n");
		for(BM55Measurement bloodPressureMeasurement : measurements) {
			System.out.println(bloodPressureMeasurement + "\n");
		}
	}
}
