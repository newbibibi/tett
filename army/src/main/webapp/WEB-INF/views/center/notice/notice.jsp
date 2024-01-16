<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
ul{
	list-style:none;
	display: flex;
	
}
li{
	padding-right: 10px;
}
a{
	text-decoration:none;
}

</style>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	<h1>혜택</h1>
	<div id="page-wrapper">
		
		<table width="100%" class="">
			<thead>
				<tr>
					<th>지역</th>
					<th>혜택대상</th>
					<th>혜택종류</th>
					<th>혜택내용</th>
					<th>혜택시작일</th>
					
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<div class="pull-right">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage -1 }">이전</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li
						class="paginate_button ${pageMaker.cri.pageNum ==num?'active':'' }">
						<a href="${num }">${num }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">다음</a></li>
				</c:if>
			</ul>
		</div>
		<form id="actionForm" action="/center/notice/notice"
			method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</form>
	</div>
	<script src="/resources/assets/js/jquery.min.js"></script>
	
	<script type="text/javascript">
	$(document).ready(
			function() {
				loadTableData();
				

				function loadTableData() {
					$.ajax({
						url : "/center/notice/noticeList",
						type : "POST",
						dataType : "json",
						data : {
							pageNum : $("#actionForm").find(
									"input[name='pageNum']").val(),
							amount : $("#actionForm").find(
									"input[name='amount']").val(),
							
						},
						success : function(data) {
							let boardTbody = $("tbody");
							
							$.each(data, function(index, sale) {
								
								let regDate = new Date(sale.regDate);
			                    // numeric: 숫자 형식, 2-digit: 두자리 숫자 형식
			                    let options = {
			                        year: "numeric",
			                        month: "2-digit",
			                        day: "2-digit",
			                   
			                    };
			                    let formatDate = regDate.toLocaleString("ko-KR", options);

								let row = $("<tr>");
								row.append($("<td>").text(sale.nno));
								let titleLink = $("<a>").attr("href","/center/notice/get?nno="+sale.nno).text(sale.content);
		                        let titleTd = $("<td>").append(titleLink);
		                        row.append(titleTd);
								row.append($("<td>").text(formatDate));
								row.append($("<td>").text(sale.category));

								
								boardTbody.append(row);
							});
						},
						error : function(e) {
							console.log(e);
						}
					});

					let actionForm = $("#actionForm");
					$(".paginate_button a").on(
							"click",
							function(e) {
								e.preventDefault();
								actionForm.find("input[name='pageNum']")
										.val($(this).attr("href"));
								actionForm.submit();
							});
					


					
				}// loadTableData 함수 선언 종료
				
			}); // $(document).ready 함수 선언 종료
	</script>
</body>
</html>