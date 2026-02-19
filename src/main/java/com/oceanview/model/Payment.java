package com.oceanview.model;

import java.sql.Timestamp;

public class Payment {
    private int paymentId;
    private String reservationNumber;
    private int nights;
    private double ratePerDay;
    private double subtotal;
    private double total;
    private Timestamp paymentDate;

    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public String getReservationNumber() { return reservationNumber; }
    public void setReservationNumber(String reservationNumber) { this.reservationNumber = reservationNumber; }

    public int getNights() { return nights; }
    public void setNights(int nights) { this.nights = nights; }

    public double getRatePerDay() { return ratePerDay; }
    public void setRatePerDay(double ratePerDay) { this.ratePerDay = ratePerDay; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public Timestamp getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Timestamp paymentDate) { this.paymentDate = paymentDate; }
}
