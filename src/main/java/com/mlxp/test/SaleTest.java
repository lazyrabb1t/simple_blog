package com.mlxp.test;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class SaleTest {

    public static final Station station = new Station();

    public static void main(String[] args) throws InterruptedException {
        int threadsNum = 1000;
        station.setTicketNum(10);
        final CountDownLatch latch = new CountDownLatch(threadsNum);
        ExecutorService exec = Executors.newFixedThreadPool(threadsNum);
        for (int i = 0; i < threadsNum; i++) {
            Runnable r = new Runnable() {

                @Override
                public void run() {
                    // TODO Auto-generated method stub
                    try {
                        latch.await();
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    System.out.println("开始执行");
                    station.saleTiclet();

                }
            };
            exec.execute(r);
            latch.countDown();
        }
        Thread.currentThread().sleep(2000);
        station.getTicketNum();
    }
}
