package org.spring.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 선택값에 따라 원하는 결과가 다르게 나오게 할 경우에
// 필요한 필드와 기능 구현
@ToString
@Setter
@Getter
public class Criteria {
	// 현재 사용자의 페이지 위치
	private int pageNum;
	
	// 한 페이지에 표시될 게시물의 갯수
	private int amount;
	
	// 페이지에 따라 첫번째 글이 어디부터 시작해야 하는지 정하기위해
	private int start;
	
	// 검색에 사용되는 필드 선언
	private String type;
	private String keyword;
	
	private String category;
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;            // pageNum    start
		this.start = (pageNum-1)*amount; //    1   ->   0
	}   // mapper에서 활용하는 방법 체크 //    2   ->   10
	                                     //    3   ->   20 

	public int getStart() {
		this.start = (this.pageNum-1)*this.amount;
		return this.start;
	}
	
	// 미션: 이 메서드를 사용하여 검색 기능 구현하기
	// type의 value : TC(제목+내용) 검색 -> {'T','C'}
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
}
