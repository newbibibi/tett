<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정 페이지</title>
<!-- 여기에 스크립트와 스타일은 동일하게 유지하면 됩니다. -->
</head>
<body>

	<form action="${contextPath}/board/modify.do" method="post" enctype="multipart/form-data">
		<div>
			<label for="title">제목:</label> <input type="text" id="title"
				name="title" value="${board.title}" required>
		</div>
		<div>
			<label for="category">카테고리:</label> <select id="category"
				class="form-control" name="category">
				<option value="ssul" ${board.category == 'ssul' ? 'selected' : ''}>썰</option>
				<option value="tip" ${board.category == 'tip' ? 'selected' : ''}>팁</option>
				<option value="free" ${board.category == 'free' ? 'selected' : ''}>자유</option>
			</select> <label for="anonymous">익명:</label> 
			<input type="checkbox" id="anonymous" name="anonymous" value="1"
				${board.anonymous == 1 ? 'checked' : ''}>
			<input type="hidden" name="anonymous" value="0">
			<!-- 체크박스가 해제되었을 때 0이 전송되도록 하는 숨겨진 필드 -->
			
		</div>
		<div>
			<label for="image">이미지:</label> <input type="file" id="image" name="image"
				onchange="showImagePreview(this)" multiple="multiple">
		</div>
		<div id="imagePreviewContainer">
    <c:forEach var="image" items="${imageList}">
        <div>
            <img src="../../resources/boardImage/${image}" style="width: 200px; height: auto;" />
            <button type="button" onclick="removeImage()">이미지 취소</button>
        </div>
    </c:forEach>
</div>
		<div>
			<label for="content">내용:</label>
			<textarea id="content" name="content" rows="4" required>${board.content}</textarea>
		</div>
		<div>
			<input type="hidden" name="bno" value="${board.bno}"> 
			<input type="hidden" name="nickname" value="${board.nickname}"> 
			<input type="submit" value="게시물 수정">
		</div>
	</form>

</body>
</html>
