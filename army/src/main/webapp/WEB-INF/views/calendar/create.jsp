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
				
				<input type="hidden" name="nickname" value="asd">
				<input type="date" name="startDate" id="sd" value="${vo.startDate }" >
				<input type="date" name="endDate" id="ed" value="${vo.endDate }">
				<textarea name="content" rows="" cols="">
				${vo.content }
				</textarea>
				<button class="btn" type="submit" data-oper="create">dd</button>
				<button class="btn" type="submit" data-oper="out">&times;</button>
			</form>
</body>
<script src="/resources/assets/js/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	let formObj = $("form");
	
		$(".btn").click(function() {
			let operation = $(this).data("oper");
			console.log(operation);
			
			if(operation == "out"){
				
			}
			else if(operation == "create"){
				formObj.attr("action","/calendar/create")
				.attr("method", "post");
			}
			formObj.submit();
		});
	});
	</script>
</html>