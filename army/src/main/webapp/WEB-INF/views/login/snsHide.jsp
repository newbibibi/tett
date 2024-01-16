<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
window.onload=function(){
	document.form1.submit();
}
</script>

</head>
<body>
<form method="post" name="form1" action="${url}">
<input type="hidden" name="snsID" value="${snsID}">
</form>
</body>
</html>