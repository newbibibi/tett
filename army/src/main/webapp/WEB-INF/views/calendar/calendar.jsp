<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
		<div id="showing">

			<div id="mainpage">
				<!-- Banner -->
				<div id="schedule">
					AAA
				</div>
				<!-- Main -->
				<div id="main">
					<ul id="liTitle">
						<li><a href="">BBBÂ </a></li>
						<li><a href="">CCC</a></li>
						<li><a href="">DDD</a></li>
					</ul>
					<ul>
						<li>dasdasdas</li>
						<li>adasdasda</li>
						<li>asdasdasdas</li>
					</ul>
				</div>
			</div>
			<div id="nickname">
			 <input type="hidden" name="nickname" value="asd">  
			</div>
			<table id="boardTable" border="1">
				<tr>
					<th>bno</th>
					<th>title</th>
					<th>content</th>
					<th>writer</th>
					<th>regdate</th>
				</tr>
				<tbody></tbody>
			</table>
					
		</div>
		<a href="/calendar/create">이동하기</a>
		<script type="text/javascript">
		
	$(document).ready(function() {
		
		loadTableData(); // Ajax 실행 함수 호출
	
		
		function loadTableData() {
	        // Ajax : 비동기 통신 
	        // - 프로세스의 완료를 기다리지 않고 동시에 여러 작업을 처리 
	        // - 전체 페이지를 새로고침 하지 않고 필요한 부분만을 업데이트 할 수 있다
	        // - 자원과 시간을 절약, 깜박거리거나 멈추지 않고 부드럽게 작동
	        $.ajax({
	            url: "/calendar/calendar", // 요청할 서버 uri 지정
	            type: "POST", //요청 방식 지정
	            dataType: "json", // 서버 응답의 데이터 타입(대표적:json,xml)
	            data: {
	                nickname: $("#nickname").find("input[name='nickname']").val()
	            },
	            success: function(data) {
	                console.log(data);
			
	                let boardTbody = $("#boardTable tbody");

	                // Ajax가 반환한 데이터를 '순회'(=='반복자')하여 처리
	                // for( let item of items) -> items == data, item == board 역할
	                $.each(data, function(index, board) {
	                    // 날짜 형태로 전환
	                    let startDate = new Date(board.startDate);
	                    let endDate = new Date(board.endDate);
	                    // numeric: 숫자 형식, 2-digit: 두자리 숫자 형식
	                    let options = {
	                        year: "numeric",
	                        month: "2-digit",
	                        day: "2-digit",
	                   
	                    };
	                    let sformatDate = startDate.toLocaleString("ko-KR", options);
	                    let eformatDate = endDate.toLocaleString("ko-KR", options);
	                    // 데이터를 순회하여 테이블 목록을 불러와 테이블 바디에 추가
	                    // 동적으로 데이터 처리
	                    let row = $("<tr>");
	                    row.append($("<td>").text(board.calNo));
	                    let titleLink = $("<a>").attr("href","/calendar/calendarmodify?calNo="+board.calNo).text(board.content);
                        let titleTd = $("<td>").append(titleLink);
                        row.append(titleTd);
	                    row.append($("<td>").text(board.nickname));
	                    row.append($("<td>").text(sformatDate));
	                    row.append($("<td>").text(eformatDate));

	                    boardTbody.append(row);

	                });
	            },
	            error: function(e) {
	                console.log(e);
	                console.log(nickname.value)
	            }
	        });

	    } // -- loadTableData 함수 선언 종료

	}); // // -- $(document).ready 함수 선언 종료
</script>
	<!-- Footer -->
<%@ include file="../includes/footer.jsp" %>	