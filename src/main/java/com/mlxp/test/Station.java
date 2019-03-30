package com.mlxp.test;

public class Station {
    private static int ticketNum;

    public void setTicketNum(int num) {
        this.ticketNum = num;
    }

    public void getTicketNum() {
        System.out.println(ticketNum);
    }

    public boolean saleTiclet() {
        if (ticketNum > 0) {
            ticketNum--;
            return true;
        }
        return false;
    }
}
