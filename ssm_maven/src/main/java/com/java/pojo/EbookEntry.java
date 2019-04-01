package com.java.pojo;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class EbookEntry implements Serializable{
    private static final long serialVersionUID = -2009161467058932841L;
    private Long id;
    private Long catgoryId;
    private String title;
    private String summary;
    private String uploaduser;
    private Date createdate;

}