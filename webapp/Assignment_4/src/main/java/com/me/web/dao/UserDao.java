package com.me.web.dao;

import com.me.web.pojo.User;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

public class UserDao extends DAO{

    public UserDao() throws IOException {
        super();
    }
    public int createUser(User user) throws Exception {
        try {
            begin();
            getSession().save(user);
            commit();
            return 2;
        }catch(Exception e){
            rollback();
            if(e.getMessage().contains("email"))
                return 1;
            else
                return 3;
        }
    }

    public User verifyUser(String userName, String password) throws Exception {
       try{
           begin();
           Query q = getSession().createQuery("from User where username = :username ");
           q.setString("username", userName);
           User user = (User)q.uniqueResult();
           commit();
           if(user != null && !user.getUsername().isEmpty()&& BCrypt.checkpw(password, user.getPassword())) {
               return user;
           }
           return null;
       }catch(HibernateException e){
           rollback();
           throw new Exception("Could not get user: "+userName,e);
       }
    }

    public User getUser(UUID uuid) throws Exception {
        try{
            begin();
            User user = (User)getSession().find(User.class,uuid);
            return user;
        }catch(HibernateException e){
            rollback();
            throw new Exception("Could not get user: "+uuid,e);
        }
    }

    public List<User> getAllUser() throws Exception {
        try{
            begin();
            Query q = getSession().createQuery("from User");
            List<User> list = (List<User>)q.getResultList();
            commit();
            return list;
        }catch(HibernateException e){
            rollback();
            throw new Exception("Could not get user: ",e);
        }
    }
}
