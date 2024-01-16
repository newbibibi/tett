package org.spring.domain;

import lombok.Data;

@Data
public class ReportVO {
	private int rno;
	private int cno;
	private int bno;
	private String report;
	private String nickname;
	private String reason;
}
