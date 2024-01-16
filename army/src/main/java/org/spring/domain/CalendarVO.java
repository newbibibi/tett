package org.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CalendarVO {
	private String nickname;
	private int calNo;
	private String startDate;
	private String endDate;
	private String content;
}
