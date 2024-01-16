<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시물 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
</head>

<body>

	<div>
	
		<h2>전체 게시물</h2>
		<button id="regBtn" type="button">글 작성</button>
		<form id="searchForm" action="/board/list" method="get">
			<div class="form-group col-xs-4">
				<select id="type" class="form-control" name="type">
					<option value="All"
						<c:out value="${pageMaker.cri.type == 'All'?'selected':''}"/>>전체</option>
					<option value="title"
						<c:out value="${pageMaker.cri.type == 'title'?'selected':''}"/>>제목</option>
					<option value="content"
						<c:out value="${pageMaker.cri.type == 'content'?'selected':''}"/>>내용</option>
					<option value="nickname"
						<c:out value="${pageMaker.cri.type == 'nickname'?'selected':''}"/>>작성자</option>
					<option value="TC"
						<c:out value="${pageMaker.cri.type == 'TC'?'selected':''}"/>>제목+내용</option>
					<!-- <option value="TC">제목+내용</option>  -->
				</select> <select id="category" class="form-control" name="category" >
					<option value="best"
						<c:out value="${pageMaker.cri.category == 'best'?'selected':''}"/>>베스트</option>
					<option value="ssul"
						<c:out value="${pageMaker.cri.category == 'ssul'?'selected':''}"/>>썰</option>
					<option value="tip"
						<c:out value="${pageMaker.cri.category == 'tip'?'selected':''}"/>>팁</option>
					<option value="free"
						<c:out value="${pageMaker.cri.category == 'free'?'selected':''}"/>>자유</option>
				</select>
			</div>
			<div class="col-xs-6">
				<div class="form-group input-group">
					<input type='text' name='keyword'
						value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
						type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">

					<span class="input-group-btn">
						<button class="btn btn-default">검색</button>
					</span>
				</div>
			</div>
		</form>
		<table id="boardTable">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>추천수</th>

				</tr>
			</thead>
			<tbody>


			</tbody>
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
						class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':'' }">
						<a href="${num }">${num}</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">다음</a></li>
				</c:if>
			</ul>
		</div>

		<form id="actionFrom" action="/board/list" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="category" value="${pageMaker.cri.category }">
		</form>

	</div>

	
	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							loadTableData(); // Ajax 함수 호출

							let result = '${result}';
							console.log(result);

							checkModal(result);

							function checkModal(result) {
								if (result === '') {
									return;
								}

								if (result === "success") {
									$(".modal-body").html("정상적으로 처리 되었습니다.");
								} else if (parseInt(result) > 0) {
									$(".modal-body")
											.html(
													parseInt(result)
															+ "번 글이 등록 되었습니다.");
								}

								$("#myModal").modal("show");
							}

							$("#regBtn")
									.click(
											function() {
												var form = $('<form action="/board/register" method="post"></form>');
												var categoryValue = $(
														'#category').val();
												form
														.append('<input type="hidden" name="nickname" value="d">'); // 닉네임 추가
												form
														.append('<input type="hidden" name="categoryval" value="' + categoryValue + '">');
												$('body').append(form);
												form.submit();
											});

							function loadTableData() {
								$
										.ajax({
											url : "/board/getList",
											type : "POST",
											dataType : "json",
											data : {
												pageNum : $(
														"#actionFrom input[name='pageNum']")
														.val(),
												amount : $(
														"#actionFrom input[name='amount']")
														.val(),
												type : $(
														"#searchForm select[name='type']")
														.val(),
												keyword : $(
														"#searchForm input[name='keyword']")
														.val(),
												category : $(
														"#searchForm select[name='category']")
														.val()
											},
											success : function(data) {
												let boardTbody = $("#boardTable tbody");
												boardTbody.empty(); // 새로운 데이터를 추가하기 전에 테이블 바디를 비움

												$
														.each(
																data,
																function(index,
																		list) {
																	var displayName = list.anonymous == 1 ? '익명' : list.nickname;
																	let regDate = new Date(
																			list.regDate);
																	console
																			.log(regDate)
																	let options = {
																		year : "numeric",
																		month : "2-digit",
																		day : "2-digit",
																		hour : "2-digit",
																		minute : "2-digit"
																	}
																	let formatDate = regDate
																			.toLocaleString(
																					"ko-KR",
																					options);

																	let row = $("<tr>");
																	row
																			.append($(
																					"<td>")
																					.text(
																							list.bno));

																	let titleLink = $("<a>")
																    .attr("href", "/board/view/" + list.bno)
																    .text(list.title);
																	let titleTd = $(
																			"<td>")
																			.append(
																					titleLink);

																	row
																			.append(titleTd);
																	row.append($("<td>").text(displayName));
																	row
																			.append($(
																					"<td>")
																					.text(
																							formatDate));
																	row
																			.append($(
																					"<td>")
																					.text(
																							list.views));
																	row
																			.append($(
																					"<td>")
																					.text(
																							list.likes));

																	boardTbody
																			.append(row);
																});
											},
											error : function(e) {
												console.log(e);
											}
										});
							}

							let actionForm = $("#actionFrom");
							$(".paginate_button a").on(
									"click",
									function(e) {
										e.preventDefault();
										actionForm
												.find("input[name='pageNum']")
												.val($(this).attr("href"));
										actionForm.submit();
									});

							let searchForm = $("#searchForm");

							$("#searchForm button").on(
									"click",
									function(e) {
										if (!searchForm.find("option:selected")
												.val()) {
											alert("검색종류를 선택하세요");
											return false;
										}

										searchForm
												.find("input[name='pageNum']")
												.val("1");
										e.preventDefault();
										searchForm.submit();
									});
						});
		
	</script>

</body>
</html>
