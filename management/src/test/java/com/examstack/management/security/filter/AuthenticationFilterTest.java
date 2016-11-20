package com.examstack.management.security.filter;

import com.examstack.common.util.StandardPasswordEncoderForSha1;
import com.examstack.management.security.UserInfo;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.Assert.*;

/**
 * 生成用户密码
 * Created by vince on 2016/11/20.
 */
public class AuthenticationFilterTest {

    private static Logger log = Logger.getLogger(AuthenticationFilterTest.class);
    @Test
    public void genUser() {
        String username = "student";
//        String username = "admin";
        String password = "888888";

        //加盐
        String sh1Password = password + "{" + username + "}";
        PasswordEncoder passwordEncoder = new StandardPasswordEncoderForSha1();
        String result = passwordEncoder.encode(sh1Password);
        log.info("用户名="+ username+"  密码="+ result);
    }
}