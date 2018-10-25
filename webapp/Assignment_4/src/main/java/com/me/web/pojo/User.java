package com.me.web.pojo;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="user")
public class User {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id", unique = true, nullable = false)
    private int id;

    @Column(name="username", unique=true)
    private String username;

    @Column(name="password")
    private String password;

    public User(){

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
