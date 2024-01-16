package org.spring.domain;

import lombok.Data;

@Data
public class PageDTO {
	// 페이징 처리에서 표시될 시작 페이지 1
	private int startPage;
	// 페이징 처리에서 표시될 끝 페이지 
	private int endPage;
	// 전체 데이터의 갯수
	private int total;
	// 이전, 다음 페이지가 있는지 여부판단
	private boolean prev, next;
	
	private Criteria cri;
	
	// cri : 사용자가 선택한 값(request) 
	// total : DB에서 확인하는 값
	// 위 두가지 값은 controller에서 전달해야함.
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		/*
			// 나눗셈 결과 올림처리
			Math.round(); // 15/10.0 -> 1.5 -> 2 -> 결과적으로 10
			// 페이징처리에서 많이 사용 
	        // 특정 페이지 그룹을 현재 페이지가 속한 그룹으로 설정
			Math.ceil(); // 15/10.0 -> 1.5 -> 2보다 큰 다음 정수인 3 -> 결과적으로 20
		*/
		// 현재 페이지 번호가 15라면 20을 반환
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0)) * 10;
		this.startPage = this.endPage-9;
		
		// 실제 마지막 페이지 번호를 나타냄
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		System.out.println(realEnd);
		
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		System.out.println("pageDTO next : "+next);
		
	}
}
