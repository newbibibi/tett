<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        #page-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        form {
            margin-bottom: 20px;
        }

        select {
            padding: 8px;
            margin-right: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        .pagination {
            list-style: none;
            padding: 0;
            margin: 20px 0;
            text-align: center;
        }

        .pagination li {
            display: inline-block;
            margin-right: 5px;
        }

        .pagination li a {
            padding: 8px;
            text-decoration: none;
            background-color: #007bff;
            color: #fff;
        }

        .pagination li.active a {
            background-color: #333;
        }

        .pull-right {
            float: right;
        }

        button {
            padding: 8px;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	<h1>혜택</h1>
	<div id="page-wrapper">
		<form id="searchForm" action="/center/information/benefit"
			method="get">
			<div class="">
				<select id="type" class="" name="type">
					<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>전체</option>
					<option value="S"
						<c:out value="${pageMaker.cri.type == 'S'?'selected':''}"/>>서울</option>
					<option value="G"
						<c:out value="${pageMaker.cri.type == 'G'?'selected':''}"/>>경기</option>
					<option value="W"
						<c:out value="${pageMaker.cri.type == 'W'?'selected':''}"/>>강원</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type == 'C'?'selected':''}"/>>충청</option>
					<option value="L"
						<c:out value="${pageMaker.cri.type == 'L'?'selected':''}"/>>전라</option>
					<option value="Y"
						<c:out value="${pageMaker.cri.type == 'Y'?'selected':''}"/>>경상</option>
					<option value="J"
						<c:out value="${pageMaker.cri.type == 'J'?'selected':''}"/>>제주</option>
				</select>
			</div>
		</form>
		<table width="100%" class="">
			<thead>
				<tr>
					<th>지역</th>
					<th>혜택대상</th>
					<th>혜택종류</th>
					<th>혜택내용</th>
					<th>혜택시작일</th>
					<th>혜택종료일</th>
					<th>전화번호</th>
					<th>링크</th>
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
		<form id="actionForm" action="/center/information/benefit"
			method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</form>
	</div>
	<script type="text/javascript">
		$(document).ready(
				function() {
					loadTableData();
					console.log(result);

					function loadTableData() {
						$.ajax({
							url : "/center/information/getList",
							type : "POST",
							dataType : "json",
							data : {
								pageNum : $("#actionForm").find(
										"input[name='pageNum']").val(),
								amount : $("#actionForm").find(
										"input[name='amount']").val(),
								type : $("#type").val()
							},
							success : function(data) {
								let boardTbody = $("tbody");
								$.each(data, function(index, sale) {

									let row = $("<tr>");
									row.append($("<td>").text(sale.area));
									row.append($("<td>").text(sale.item));
									row.append($("<td>").text(sale.salename));
									row.append($("<td>").text(sale.detail));
									row.append($("<td>").text(sale.start));
									row.append($("<td>").text(sale.end));
									row.append($("<td>").text(sale.phone));
									if (sale.homepage !== null
											&& sale.homepage !== '') {
										let link = $("<button>").text("더 보기")
												.on("click", function() {
													openPop(sale.homepage);
												});
										let linktd = $("<td>").append(link);
										row.append(linktd);
									}
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
						


						function openPop(url) {
							var popup = window.open(url, '팝업창',
									'width=700px,height=800px');
						}

					}// loadTableData 함수 선언 종료
					
				}); // $(document).ready 함수 선언 종료
				$('#type').change(function() {
					$('#searchForm').submit();
				});
	</script>
</body>

</html>