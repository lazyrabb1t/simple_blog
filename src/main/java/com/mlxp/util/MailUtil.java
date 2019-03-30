package com.mlxp.util;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.mlxp.define.MailConfig;

public class MailUtil {
    private static final String HOST = MailConfig.host;
    private static final Integer PORT = MailConfig.port;
    private static final String USERNAME = MailConfig.userName;
    private static final String PASSWORD = MailConfig.passWord;
    private static final String emailForm = MailConfig.emailForm;
    private static final String timeout = MailConfig.timeout;
    private static final String personal = MailConfig.personal;
    private static final String html = MailConfig.html;
    private static JavaMailSenderImpl mailSender = createMailSender();

    /**
     * 邮件发送器
     * 
     * @return 配置好的工具
     */
    private static JavaMailSenderImpl createMailSender() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setHost(HOST);
        sender.setPort(PORT);
        sender.setUsername(USERNAME);
        sender.setPassword(PASSWORD);
        sender.setDefaultEncoding("Utf-8");
        Properties p = new Properties();
        p.setProperty("mail.smtp.timeout", timeout);
        p.setProperty("mail.smtp.auth", "false");
        p.setProperty("mail.smtp.starttls.enable", "true");
        // QQ邮箱需要使用SSL
        p.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        p.setProperty("mail.smtp.socketFactory.port", PORT.toString());
        p.setProperty("mail.smtp.socketFactory.fallback", "false");
        //debug
//        p.setProperty("mail.debug", "true");
        sender.setJavaMailProperties(p);
        return sender;
    }

    /**
     * 发送邮件
     * 
     * @param to
     *            接受人
     * @param subject
     *            主题
     * @param html
     *            发送内容
     * @throws MessagingException
     *             异常
     * @throws UnsupportedEncodingException
     *             异常
     */
    public static void sendMail(String to, String subject, String text) {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        // 设置utf-8或GBK编码，否则邮件会有乱码
        try {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            messageHelper.setFrom(emailForm, personal);
            messageHelper.setTo(to);
            messageHelper.setSubject(subject);
            messageHelper.setText(html.replaceAll("content", text), true);
            mailSender.send(mimeMessage);
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
