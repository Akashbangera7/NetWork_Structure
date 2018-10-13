package com.cloud;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;

public class Attachment {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id", unique = true, nullable = false)
    private int id;



    @ManyToOne()
    @JsonBackReference
    private Transaction transaction;

    @Column(name="path")
    private String url;

    public Attachment(){}

    public int getId(){ return id;}


    public Transaction getTransaction(){ return transaction;}

    public void setId(int id){ this.id = id;}

    public void setTransaction(Transaction transaction){ this.transaction = transaction;}

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
