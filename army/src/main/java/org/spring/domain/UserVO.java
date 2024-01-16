package org.spring.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class UserVO {
	private String id;
	private String pw;
	private String nickname;
	private String email;
	private String enlisting;
	private String armygroup;
	private Timestamp baned;
	private int admin;
	private String sns;
}
