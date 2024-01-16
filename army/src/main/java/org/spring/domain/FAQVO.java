package org.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FAQVO {
	private int qno;
	private String title;
	private String content;
	private Date regDate;
	private String category;
}
