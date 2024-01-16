package org.spring.domain;

import lombok.Data;

@Data
public class MenuVO {
	private String date;
	private String morning;
	private String mkcal;
	private String lunch;
	private String lkcal;
	private String dinner;
	private String dkcal;
	private String totalkcal;
}
