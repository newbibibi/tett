<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="form">
	<input type="hidden" name="regDate" value="${vo.regDate }">
	<input type="hidden" name="category" value="${vo.category }">
	<input type="text" name = "nno" readonly="readonly" value="${vo.nno }">
		<input type="text" name="title" value="${vo.title }">
		<input type="text" name="content" value ="${vo.content }">
		<button type="submit" class="btn" data-oper="modify">수정</button>
		<button type="submit" class="btn" data-oper="delete">삭제</button>
	</form>
	
</body>
<script src="/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	let formObj = $("#form");
	
		$(".btn").click(function() {
			let operation = $(this).data("oper");
			console.log(operation);
			
			if(operation == "modify"){
				formObj.attr("action","/center/notice/modify")
				.attr("method", "post");
			}
			else if(operation == "delete"){
				formObj.attr("action","/center/notice/delete")
				.attr("method", "post");
			}
			formObj.submit();
		});
	});
	</script>
</html>