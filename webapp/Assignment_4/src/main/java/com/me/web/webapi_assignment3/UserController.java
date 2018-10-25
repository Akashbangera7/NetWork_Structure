package com.me.web.webapi_assignment3;

import com.me.web.dao.UserDao;
import com.me.web.pojo.User;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class UserController {

    @RequestMapping(value = "user/save", method = RequestMethod.POST)
    public String saveUser(HttpServletRequest req, UserDao userDao) throws Exception{
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        if(username != null && password != null && username.length() > 0 && password.length() > 0) {
            User user = new User();
            user.setUsername(username);
            String salt = BCrypt.gensalt();
            password = BCrypt.hashpw(password, salt);
            user.setPassword(password);
            if(userDao.createUser(user)==2) {
                return "{message:'User successfully registered'}";
            }
        }else{
            return "Username or password cannot be blank";
        }
        return "{message:'User already exist'}";
    }
}
