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
package org.medipi.devices.drivers.domain;

import java.sql.Timestamp;
import java.text.ParseException;

import org.medipi.utilities.BytesManipulator;
import org.medipi.utilities.TimestampUtil;

/**
 * The Class BM55Measurement converts the byte data array received from
 * serial interface to meaningful values related to blood pressure measurement.
 *
 * @author krishna.kuntala@mastek.com
 */
public class BM55Measurement {

	private int systolicPressure;
	private int diastolicPressure;
	private BM55User user;
	private int pulseRate;
	private boolean restingIndicator;
	private boolean arrhythmia;
	private Timestamp measuredTime;

	/**
	 * Instantiates a new BM55 measurement.
	 *
	 * @param systolicPressure the systolic pressure
	 * @param diastolicPressure the diastolic pressure
	 * @param user the user
	 * @param pulseRate the pulse rate
	 * @param restingIndicator the resting indicator
	 * @param arrhythmia the arrhythmia
	 * @param measuredTime the measured time
	 */
	public BM55Measurement(final int systolicPressure, final int diastolicPressure, final BM55User user, final int pulseRate, final boolean restingIndicator, final boolean arrhythmia, final Timestamp measuredTime) {
		this.systolicPressure = systolicPressure;
		this.diastolicPressure = diastolicPressure;
		this.user = user;
		this.pulseRate = pulseRate;
		this.restingIndicator = restingIndicator;
		this.arrhythmia = arrhythmia;
		this.measuredTime = measuredTime;
	}

	/**
	 * Instantiates a new BM55 measurement.
	 *
	 * @param reading the reading bytes which will be converted to meaningful values after decoding them
	 */
	public BM55Measurement(final byte[] reading) {
		this.systolicPressure = BytesManipulator.getUnsignedInteger((byte) (reading[0] + 25));
		this.diastolicPressure = BytesManipulator.getUnsignedInteger((byte) (reading[1] + 25));
		this.pulseRate = BytesManipulator.getUnsignedInteger((byte) reading[2]);
		String day = null;
		String month = null;
		String year = null;
		String hour = null;
		String minute = null;

		if(reading[3] < 0) {
			this.restingIndicator = true;
			month = String.valueOf(reading[3] + 128);
		} else {
			month = String.valueOf(reading[3]);
		}

		if(reading[4] < 0) {
			this.user = BM55User.B;
			day = String.valueOf(reading[4] + 128);
		} else {
			this.user = BM55User.A;
			day = String.valueOf(reading[4]);
		}

		hour = String.valueOf(reading[5]);
		minute = String.valueOf(reading[6]);

		if(reading[7] < 0) {
			this.arrhythmia = true;
			year = String.valueOf(reading[7] + 128 + 2000);
		} else {
			year = String.valueOf(reading[7] + 2000);
		}

		final String stringMeasurementTime = year + "-" + month + "-" + day + " " + hour + ":" + minute;
		try {
			this.measuredTime = TimestampUtil.getTimestamp("yyyy-MM-dd hh:mm", stringMeasurementTime);
		} catch(final ParseException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Method to get the systolic pressure.
	 *
	 * @return the systolic pressure
	 */
	public int getSystolicPressure() {
		return this.systolicPressure;
	}

	/**
	 * Method to set the systolic pressure.
	 *
	 * @param systolicPressure the new systolic pressure
	 */
	public void setSystolicPressure(final int systolicPressure) {
		this.systolicPressure = systolicPressure;
	}

	/**
	 * Method to get the diastolic pressure.
	 *
	 * @return the diastolic pressure
	 */
	public int getDiastolicPressure() {
		return this.diastolicPressure;
	}

	/**
	 * Method to set the diastolic pressure.
	 *
	 * @param diastolicPressure the new diastolic pressure
	 */
	public void setDiastolicPressure(final int diastolicPressure) {
		this.diastolicPressure = diastolicPressure;
	}

	/**
	 * Method to get the user.
	 *
	 * @return the user
	 */
	public BM55User getUser() {
		return this.user;
	}

	/**
	 * Method to set the user.
	 *
	 * @param user the new user
	 */
	public void setUser(final BM55User user) {
		this.user = user;
	}

	/**
	 * Method to get the pulse rate.
	 *
	 * @return the pulse rate
	 */
	public int getPulseRate() {
		return this.pulseRate;
	}

	/**
	 * Method to set the pulse rate.
	 *
	 * @param pulseRate the new pulse rate
	 */
	public void setPulseRate(final int pulseRate) {
		this.pulseRate = pulseRate;
	}

	/**
	 * Checks if resting indicator is on.
	 *
	 * @return true, if resting indicator is on
	 */
	public boolean isRestingIndicator() {
		return this.restingIndicator;
	}

	/**
	 * Method to set the resting indicator.
	 *
	 * @param restingIndicator the new resting indicator
	 */
	public void setRestingIndicator(final boolean restingIndicator) {
		this.restingIndicator = restingIndicator;
	}

	/**
	 * Checks if is arrhythmia.
	 *
	 * @return true, if is arrhythmia
	 */
	public boolean isArrhythmia() {
		return this.arrhythmia;
	}

	/**
	 * Method to set the arrhythmia.
	 *
	 * @param arrhythmia the new arrhythmia
	 */
	public void setArrhythmia(final boolean arrhythmia) {
		this.arrhythmia = arrhythmia;
	}

	/**
	 * Method to get the measured time.
	 *
	 * @return the measured time
	 */
	public Timestamp getMeasuredTime() {
		return this.measuredTime;
	}

	/**
	 * Method to set the measured time.
	 *
	 * @param measuredTime the new measured time
	 */
	public void setMeasuredTime(final Timestamp measuredTime) {
		this.measuredTime = measuredTime;
	}

	/**
	 * Method to get all the values in a string array.
	 *
	 * @return all the values in string array format
	 * @throws ParseException the parse exception
	 */
	public String[] getAllValues() throws ParseException {
		final String[] values = new String[8];
		values[0] = TimestampUtil.getStringDate("yyyy-MM-dd", this.getMeasuredTime());
		values[1] = TimestampUtil.getStringDate("hh:mm", this.getMeasuredTime());
		values[2] = String.valueOf(this.getSystolicPressure());
		values[3] = String.valueOf(this.getDiastolicPressure());
		values[4] = String.valueOf(this.getPulseRate());
		values[5] = this.getUser().toString();
		values[6] = String.valueOf(this.isRestingIndicator());
		values[7] = String.valueOf(this.isArrhythmia());
		return values;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BloodPressure:\n" + "systolicPressure=" + this.systolicPressure + "\ndiastolicPressure=" + this.diastolicPressure + "\nuser=" + this.user + "\npulseRate=" + this.pulseRate + "\nrestingIndicator=" + this.restingIndicator + "\narrhythmia=" + this.arrhythmia + "\nmeasuredTime=" + this.measuredTime;
	}
}