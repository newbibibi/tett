package org.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CalendarVO {
	private String nickname;
	private int calNo;
	private Date startDate;
	private Date endDate;
	private String content;
}
