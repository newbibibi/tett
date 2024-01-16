package org.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommentVO {
	private int cno;
	private String content;
	private String nickname;
	private int bno;
	private int dislikes;
	private Timestamp cTime;
	private int isCFC;
	private int parentCno;
	private int likes;
	private int isAnnoymous;
}
