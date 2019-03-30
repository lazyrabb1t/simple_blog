package com.mlxp.test;

import java.util.Collections;

import redis.clients.jedis.Jedis;

public class RedisSetNXTest extends Thread {

    private static final String LOCK_SUCCESS = "OK";
    private static final String SET_IF_NOT_EXIST = "NX";
    private static final String SET_WITH_EXPIRE_TIME = "PX";

    private String auctionCode;

    public RedisSetNXTest(String auctionCode) {
        super(auctionCode);
        this.auctionCode = auctionCode;
    }

    private static int bidPrice = 100;

    public static void main(String[] args) {
        System.out.println(Thread.currentThread().getName() + "主线程运行开始!");
        // 更改key为a的值
        Jedis jedis = new Jedis("47.105.165.224", 6379);
        jedis.auth("lazyrabbit");
        jedis.set("goodsprice", "0");
        System.out.println("输出初始化值：" + jedis.get("goodsprice"));
        jedis.close();
        RedisSetNXTest thread1 = new RedisSetNXTest("A001");
        RedisSetNXTest thread2 = new RedisSetNXTest("B001");
        thread1.start();
        thread2.start();
        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(Thread.currentThread().getName() + "主线程运行结束!");
    }

    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName() + "线程运行开始 ");
        Jedis jedis = new Jedis("47.105.165.224", 6379);
        jedis.auth("lazyrabbit");
        try {
            if (Thread.currentThread().getName() == "B001") {
                sleep(1000);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // 让A先拿到锁
        boolean isOk = tryGetDistributedLock(jedis, "goods_lock", Thread.currentThread().getName(), 10000);

        try {
            if (Thread.currentThread().getName() == "A001") {
                sleep(2000);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        if (isOk) {
            System.out.println("子线程" + this.auctionCode + "拿到锁");
            String v = jedis.get("goodsprice");
            Integer iv = Integer.valueOf(v);
            // 条件都给过
            if (bidPrice > iv) {

                Integer bp = iv + 100;
                // 出价成功，事务未提交
                jedis.set("goodsprice", String.valueOf(bp));
                System.out.println("子线程" + this.auctionCode + ", 出价：" + jedis.get("goodsprice") + "，出价时间：" + System.nanoTime());

            } else {
                System.out.println("出价低于现有价格！");
            }
            boolean isOk1 = releaseDistributedLock(jedis, "goods_lock", Thread.currentThread().getName());
            if (isOk1) {
                System.out.println("子线程" + this.auctionCode + "释放锁");
            }

        } else {

            System.out.println("子线程" + auctionCode + "未拿到锁");
        }
        jedis.close();
        System.out.println(Thread.currentThread().getName() + "线程运行结束");
    }

    /**
     * 尝试获取分布式锁
     * 
     * @param jedis
     *            Redis客户端
     * @param lockKey
     *            锁
     * @param requestId
     *            请求标识
     * @param expireTime
     *            超期时间
     * @return 是否获取成功
     */
    public boolean tryGetDistributedLock(Jedis jedis, String lockKey, String requestId, int expireTime) {

        String result = jedis.set(lockKey, requestId, SET_IF_NOT_EXIST, SET_WITH_EXPIRE_TIME, expireTime);

        if (LOCK_SUCCESS.equals(result)) {
            return true;
        }
        return false;

    }

    private static final Long RELEASE_SUCCESS = 1L;

    /**
     * 释放分布式锁
     * 
     * @param jedis
     *            Redis客户端
     * @param lockKey
     *            锁
     * @param requestId
     *            请求标识
     * @return 是否释放成功
     */
    public boolean releaseDistributedLock(Jedis jedis, String lockKey, String requestId) {

        String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
        Object result = jedis.eval(script, Collections.singletonList(lockKey), Collections.singletonList(requestId));

        if (RELEASE_SUCCESS.equals(result)) {
            return true;
        }
        return false;

    }
}
