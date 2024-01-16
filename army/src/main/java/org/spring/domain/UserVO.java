package org.spring.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	private String id;
	private String pw;
	private String nickname;
	private String email;
	private Date enlisting;
	private String group;
	private Timestamp baned;
	private int admin;
	private String sns;
}
