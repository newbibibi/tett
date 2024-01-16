<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	${vo.title }<br>
	${vo.content }<br>
	${vo.nno }<br>
	${vo.regDate }<br>
	${vo.category }<br>
	
	
	<button type="submit" ><a href="/center/notice/modify?nno=${vo.nno }">수정</a></button>
</body>
</html>