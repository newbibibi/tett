package org.spring.domain;

import lombok.Data;


@Data
public class Criteria {
	private String nickname;
	
	private int pageNum;
	
	private int amount;
	
	private int start;
	
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum,int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.start = (pageNum-1)*amount;
	}
	
	public int getStart() {
		this.start = (this.pageNum-1)*this.amount;
		return this.start;
	}
	
}
