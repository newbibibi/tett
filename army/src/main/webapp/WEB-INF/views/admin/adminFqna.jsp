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
	<h1>관리자 문의확인창</h1>
	
	<div id="page-wrapper">
	<form id="searchForm" action="/admin/adminFqna" method="get">
		<div class="">
			<select id="type" class="" name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>전체</option>
				<option value="O"
					<c:out value="${pageMaker.cri.type == 'O'?'selected':''}"/>>해결</option>
				<option value="X"
					<c:out value="${pageMaker.cri.type == 'X'?'selected':''}"/>>미해결</option>
			</select>
		</div>
	</form>
		<table width="100%" class="">
			<thead>
				<tr>
					<th>제목</th>
					<th>작성자</th>
					<th>답변유무</th>
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
		<form id="actionForm" action="/admin/adminFqna" method="get">
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
							url : "/admin/adminFqnaList",
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
								$.each(data, function(index, fqna) {
									let row = $("<tr>");
									let titleLink = $("<a>").attr("href","/admin/fqnaAnswer?qno="+fqna.qno).text(fqna.title);
									let titleTd = $("<td>").append(titleLink);
									row.append(titleTd);
									row.append($("<td>").text(fqna.nickname));
									if (fqna.answer === null) {
										row.append($("<td>").text("미답변"));
									} else {
										row.append($("<td>").text("답변"));
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

					}// loadTableData 함수 선언 종료

				}); // $(document).ready 함수 선언 종료
		$('#type').change(function() {
			$('#searchForm').submit();
		});
	</script>
</body>

</html>