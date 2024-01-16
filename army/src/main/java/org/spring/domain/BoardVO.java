package org.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {
	private int bno;
	private String nickname;
	private String title;
	private String content;
	private int views;
	private int likes;
	private int dislikes;
	private Timestamp regDate;
	private int commentCnt;
	private String category;
	private int reportCnt;
	private int anonymous;
	private String img;
	
}
