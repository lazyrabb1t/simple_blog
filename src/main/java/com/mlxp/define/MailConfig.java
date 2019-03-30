package com.mlxp.define;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

public class MailConfig {
    private static final String PROPERTIES_DEFAULT = "config/mailConfig.properties";
    private static final String htmlpath = "config/mailmodel.html";//html文件地址  
    public static String host;
    public static Integer port;
    public static String userName;
    public static String passWord;
    public static String emailForm;
    public static String timeout;
    public static String personal;
    public static String html;
    public static Properties properties;
    static {
        init();
    }

    /**
     * 初始化
     */
    private static void init() {
        properties = new Properties();
        try {
            InputStream inputStream = MailConfig.class.getClassLoader().getResourceAsStream(PROPERTIES_DEFAULT);
            properties.load(inputStream);
            inputStream.close();
            host = properties.getProperty("mailHost");
            port = Integer.parseInt(properties.getProperty("mailPort"));
            userName = properties.getProperty("mailUsername");
            passWord = properties.getProperty("mailPassword");
            emailForm = properties.getProperty("mailFrom");
            timeout = properties.getProperty("mailTimeout");
            personal = properties.getProperty("personal");
            BufferedReader br = new BufferedReader(new InputStreamReader(MailConfig.class.getClassLoader().getResourceAsStream(htmlpath), "UTF-8"));// 解决读取中文乱码  
            String line = null;  
            StringBuffer sb = new StringBuffer();  
            while ((line = br.readLine()) != null) {  
                sb.append(line);//拼接到stringBuffer  
                sb.append("\n");
            }
            br.close();
            html = sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
