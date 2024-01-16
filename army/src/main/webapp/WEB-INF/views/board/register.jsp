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
<title>게시물 작성 페이지</title>
</head>
<body>

<form id="postForm" action="register.do" method="post" enctype="multipart/form-data">
    <!-- 나머지 폼 필드 -->
    <div>
			<label for="title">제목:</label> <input type="text" id="title"
				name="title" required>
		</div>
		<div>
			<label for="category">카테고리:</label> <select id="category"
				class="form-control" name="category">

				<option value="ssul"
					<c:out value="${category == 'ssul'?'selected':''}"/>>썰</option>
				<option value="tip"
					<c:out value="${category == 'tip'?'selected':''}"/>>팁</option>
				<option value="free"
					<c:out value="${category == 'free'?'selected':''}"/>>자유</option>
			</select> <label for="anonymous">익명:</label> <input type="checkbox"
				id="anonymous" name="anonymous" value="1">
		</div>

		<div>
			<label for="content">내용:</label>
			<textarea id="content" name="content" rows="4" required></textarea>
		</div>
    <div>
        <label for="image">이미지:</label>
        <input type="file" id="image" name="image" onchange="showImagePreview(this)" multiple>
    </div>
    <div id="imagePreviewContainer" style="display: none;">
        <image id="imagePreview" style="width: 200px; height: auto;">
        <button type="button" onclick="removeImage()">이미지 취소</button>
    </div>
    <!-- 폼 제출 버튼 -->
    <div>
        <input type="hidden" name="nickname" value="${nickname}">
        <input type="submit" value="게시물 업로드">
    </div>
</form>

<script>
    // 이미지 미리보기 함수
    function showImagePreview(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function(e) {
                var imagePreview = document.getElementById('imagePreview');
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block';
                document.getElementById('imagePreviewContainer').style.display = 'block';
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    // 이미지 제거 함수
    function removeImage() {
        var imageInput = document.getElementById('image');
        var imagePreview = document.getElementById('imagePreview');
        var imagePreviewContainer = document.getElementById('imagePreviewContainer');

        if (imageInput) {
            imageInput.value = "";
        }
        if (imagePreview) {
            imagePreview.src = "";
        }
        if (imagePreviewContainer) {
            imagePreviewContainer.style.display = 'none';
        }
    }
</script>

</body>
</html>
