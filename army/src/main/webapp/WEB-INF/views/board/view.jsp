<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${board.title}</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
}

#boardView {
	max-width: 800px;
	margin: 20px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	color: #333;
}

label {
	font-weight: bold;
	margin-right: 5px;
}

span, div {
	margin-bottom: 10px;
}

img {
	max-width: 100%;
	height: auto;
	border-radius: 8px;
}

.commentItem {
	margin-bottom: 20px;
	padding: 10px;
	background-color: #f9f9f9;
	border-radius: 8px;
}

.commentContent, .editForm {
	margin-bottom: 10px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.commentInfo {
	font-size: 14px;
}

button {
	cursor: pointer;
	padding: 5px 10px;
	background-color: #4285f4;
	color: #fff;
	border: none;
	border-radius: 4px;
}

button:hover {
	background-color: #3367d6;
}

#commentForm, #commentList {
	margin-top: 20px;
}

#replyForm, #editForm {
	margin-top: 10px;
}
</style>

</head>
<body>
	<div id="boardView">
		<h1>게시글 상세보기</h1>
		<p>
			게시글 번호: <span>${board.bno}</span>
		</p>
		<p>
			제목: <span>${board.title}</span>
		</p>
		<p>
			작성자: <span> <c:choose>
					<c:when test="${board.anonymous == 1}">익명</c:when>
					<c:otherwise>${board.nickname}</c:otherwise>
				</c:choose></span>
		</p>
		<p>
			조회수: <span>${board.views}</span>
		</p>
		<p>
			좋아요: <span>${board.likes}</span>
		</p>
		<p>
			작성일: <span><fmt:formatDate value="${board.regDate}"
					pattern="yyyy-MM-dd HH:mm:ss" /></span>
		</p>
		<c:if test="${not empty imageList}">
			<div class="image-gallery">
				<c:forEach items="${imageList}" var="imageUrl">
					<img src="../../resources/boardImage/${imageUrl}" alt="게시글 이미지" />
				</c:forEach>
			</div>
		</c:if>
		<p>내용:</p>
		<div>${board.content}</div>
		

		<p>
			댓글 수: <span>${board.commentCnt}</span>
		</p>

		<form action="/board/update" method="post">
			<input type="hidden" name="bno" value="${board.bno}" />
			<button type="submit">수정</button>
		</form>

		<form action="/board/delete" method="post"
			onsubmit="return confirm('정말 삭제하시겠습니까?');">
			<input type="hidden" name="bno" value="${board.bno}">
			<button type="submit">삭제</button>
		</form>

		<button id="reportBtnB" type="button">신고</button>

		<div id="reportModalB"
			style="display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0.4);">
			<div
				style="background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 80%;">
				<h2>신고하기</h2>
				<form action="/board/report" method="post">
					<input type="hidden" name="bno" value="${board.bno}"> <input
						type="hidden" name="nickname" value="${board.nickname}"> <input
						type="hidden" name="reporter" value="d"><br> <label
						for="reason">신고 이유:</label> <select name="reason" id="reason">
						<option value="광고">광고</option>
						<option value="도배">도배</option>
						<option value="음란물">음란물</option>
						<option value="욕설">욕설</option>
						<option value="개인정보침해">개인정보침해</option>
						<option value="저작권침해">저작권침해</option>
						<option value="기타">기타</option>
					</select><br> <br> <label>세부 사항:</label>
					<textarea name="details"></textarea>
					<br>
					<button type="submit">신고 제출</button>
				</form>
				<button type="button"
					onclick="document.getElementById('reportModalB').style.display='none'">닫기</button>
			</div>
		</div>

		<c:choose>
			<c:when test="${liked}">
				<form action="/board/like" method="post">
					<input type="hidden" name="like" value="like"> <input
						type="hidden" name="bno" value="${board.bno}">
					<button type="submit">좋아요</button>
				</form>
			</c:when>
			<c:otherwise>
				<form action="/board/like" method="post">
					<input type="hidden" name="like" value="unlike"> <input
						type="hidden" name="bno" value="${board.bno}">
					<button type="submit">좋아요 취소</button>
				</form>
			</c:otherwise>
		</c:choose>

		<a href="/board/list">목록으로 돌아가기</a>
	</div>



	</div>
	<div id="commentForm">
		<h3>댓글 달기</h3>
		<form action="/board/commentAdd" method="post">
			<input type="hidden" name="bno" value="${board.bno}" /> <input
				type="hidden" name="nickname" value="d" />
			<textarea name="content" required></textarea>
			<div>
				<input type="checkbox" id="isAnonymous" name="isAnonymous" value="1">
				<label for="isAnonymous">익명으로 작성하기</label>
			</div>
			<button type="submit">댓글 등록</button>
		</form>
	</div>

	<!-- 댓글 목록 -->
	<div id="commentList">
		<h3>댓글</h3>
		<c:forEach items="${comments}" var="comment">
			<c:if test="${comment.parentCno == 0}">
				<div class="commentItem">
					<div class="commentContent${comment.cno}"
						id="commentContent${comment.cno}">${comment.content}</div>
					<div id="editForm${comment.cno}" style="display: none;">
						<form onsubmit="return updateComment(${comment.cno});">
							<input type="hidden" name="cno" value="${comment.cno}" /> <input
								type="text" id="editContent${comment.cno}" name="content"
								value="${comment.content}" required />
							<button type="submit">수정 완료</button>
						</form>
					</div>
					<div class="commentInfo${comment.cno}">
						작성자: <span class="authorName"> <c:out
								value="${comment.isAnonymous == 1 ? '익명' : comment.nickname}" /></span>
						<!-- 좋아요 버튼 -->
						<button type="button" onclick="likeComment(${comment.cno})">좋아요:
							${comment.likes}</button>
						<!-- 대댓글 -->
						<button type="button" onclick="toggleReplyForm(${comment.cno})">대댓글
							달기</button>
						<!-- 수정 -->
						<button type="button" onclick="editComment(${comment.cno})">수정</button>
						<button id="reportBtnC${comment.cno}" type="button"
							onclick="showReportForm(${comment.cno})">신고</button>

						<div id="reportModalC${comment.cno}"
							style="display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0.4);">
							<div
								style="background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 80%;">
								<h2>신고하기</h2>
								<form action="/board/report" method="post">
									<input type="hidden" name="cno" value="${comment.cno}">
									<input type="hidden" name="nickname" value="${board.nickname}">
									<input type="hidden" name="reporter" value="d"><br>
									<label for="reason">신고 이유:</label> <select name="reason"
										id="reason">
										<option value="광고">광고</option>
										<option value="도배">도배</option>
										<option value="음란물">음란물</option>
										<option value="욕설">욕설</option>
										<option value="개인정보침해">개인정보침해</option>
										<option value="저작권침해">저작권침해</option>
										<option value="기타">기타</option>
									</select><br> <br> <label>세부 사항:</label>
									<textarea name="details"></textarea>
									<br>
									<button type="submit">신고 제출</button>
								</form>
								<button type="button"
									onclick="document.getElementById('reportModalC${comment.cno}').style.display='none'">닫기</button>
							</div>
						</div>


						<!-- 댓글 삭제 버튼 -->
						<form action="/board/cmtDelete" method="post"
							onsubmit="return confirm('정말 삭제하시겠습니까?');">
							<input type="hidden" name="bno" value="${board.bno}"> <input
								type="hidden" name="cno" value="${comment.cno}">
							<button type="submit">삭제</button>
						</form>


						<!-- 대댓글, 수정, 삭제 등 추가 기능에 대한 링크나 버튼을 여기에 추가할 수 있습니다. -->
						<div id="replyForm${comment.cno}" style="display: none;">
							<form action="/board/commentAdd" method="post">
								<input type="hidden" name="nickname" value="d" /> <input
									type="hidden" name="bno" value="${board.bno}" /> <input
									type="hidden" name="parentCno" value="${comment.cno}">
								<textarea name="content" required></textarea>
								<input type="checkbox" name="isAnonymous" value="1"
									id="isAnonymous"> <label for="anonymous">익명으로
									댓글 작성</label>
								<button type="submit">등록</button>
							</form>
						</div>

					</div>
				</div>
			</c:if>
			<!-- 대댓글 표시 -->
			<c:forEach items="${comments}" var="reply">
				<c:if test="${reply.parentCno == comment.cno}">
					<div class="commentItem" style="margin-left: 30px;">
						<!-- 대댓글을 댓글보다 안쪽으로 들여쓰기 -->
						<div class="commentContent${reply.cno}"
							id="commentContent${reply.cno}">${reply.content}</div>
						<div id="editForm${reply.cno}" style="display: none;">
							<form onsubmit="return updateComment(${reply.cno});">
								<input type="hidden" name="cno" value="${reply.cno}" /> <input
									type="text" id="editContent${reply.cno}" name="content"
									value="${reply.content}" required />
								<button type="submit">수정 완료</button>
							</form>
						</div>
						<div class="commentInfo${reply.cno}">
							작성자: <span class="authorName"> <c:out
									value="${reply.isAnonymous == 1 ? '익명' : reply.nickname}" /></span>
							<!-- 좋아요 버튼 -->
							<button type="button" onclick="likeComment(${reply.cno})">좋아요:
								${reply.likes}</button>
							<!-- 대댓글 -->
							<button type="button" onclick="toggleReplyForm(${reply.cno})">대댓글
								달기</button>
							<!-- 수정 -->
							<button type="button" onclick="editComment(${reply.cno})">수정</button>
							<button id="reportBtnR${reply.cno}" type="button"
								onclick="showReportForm(${reply.cno})">신고</button>

							<div id="reportModalC${reply.cno}"
								style="display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0.4);">
								<div
									style="background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 80%;">
									<h2>신고하기</h2>
									<form action="/board/report" method="post">
										<input type="hidden" name="cno" value="${reply.cno}">
										<input type="hidden" name="nickname" value="${board.nickname}">
										<input type="hidden" name="reporter" value="d"><br>
										<label for="reason">신고 이유:</label> <select name="reason"
											id="reason">
											<option value="광고">광고</option>
											<option value="도배">도배</option>
											<option value="음란물">음란물</option>
											<option value="욕설">욕설</option>
											<option value="개인정보침해">개인정보침해</option>
											<option value="저작권침해">저작권침해</option>
											<option value="기타">기타</option>
										</select><br> <br> <label>세부 사항:</label>
										<textarea name="details"></textarea>
										<br>
										<button type="submit">신고 제출</button>
									</form>
									<button type="button"
										onclick="document.getElementById('reportModalC${reply.cno}').style.display='none'">닫기</button>
								</div>
							</div>
							<form action="/board/cmtDelete" method="post"
								onsubmit="return confirm('정말 삭제하시겠습니까?');">
								<input type="hidden" name="bno" value="${board.bno}" /> <input
									type="hidden" name="cno" value="${reply.cno}" />
								<button type="submit">삭제</button>
							</form>
							<div id="replyForm${reply.cno}" style="display: none;">
								<form action="/board/commentAdd" method="post">
									<input type="hidden" name="nickname" value="d" /> <input
										type="hidden" name="bno" value="${board.bno}" /> <input
										type="hidden" name="parentCno" value="${comment.cno}">
									<textarea name="content" required></textarea>
									<input type="checkbox" name="isAnonymous" value="1"
										id="isAnonymous"> <label for="anonymous">익명으로
										댓글 작성</label>
									<button type="submit">등록</button>
								</form>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>


		</c:forEach>
	</div>
</body>
</html>

<script>
//신고 버튼 클릭 이벤트
	
document.getElementById('reportBtnB').onclick = function() {
    document.getElementById('reportModalB').style.display = 'block';
}

function showReportForm(cno) {
    var reportModal = document.getElementById('reportModalC' + cno);

    if (reportModal.style.display === 'none' || reportModal.style.display === '') {
        reportModal.style.display = 'block';
    } else {
        reportModal.style.display = 'none';
    }
}


    // 대댓글 입력 폼을 표시하거나 숨기는 함수
    function toggleReplyForm(cno) {
    var form = document.getElementById('replyForm' + cno);
    var authorNameElement = document.querySelector('.commentInfo' + cno + ' .authorName'); // 각 대댓글에 대한 작성자 이름 요소 선택
    var textarea = form.querySelector('textarea');
    
    if (form.style.display === 'none' || form.style.display === '') {
        form.style.display = 'block';
        textarea.value = '@' + authorNameElement.innerText + ' '; // 작성자 이름을 입력창에 미리 채웁니다.
    } else {
        form.style.display = 'none';
    }
}




    function editComment(cno) {
        var commentContent = document.getElementById('commentContent' + cno);
        var form = document.getElementById('editForm' + cno);

        if (form.style.display === 'none' || form.style.display === '') {
            form.style.display = 'block';
            commentContent.style.display = 'none';
        } else {
            form.style.display = 'none';
            commentContent.style.display = 'block';
        }
    }

	

    // 댓글 수정 처리
    function updateComment(cno) {
        var editContent = document.getElementById('editContent' + cno).value;

        // AJAX 요청
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/cmtUpdate');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(JSON.stringify({
            cno: cno,
            content: editContent
        }));

        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                alert('댓글이 수정되었습니다.');
                location.reload(); // 페이지를 리로드하여 수정된 댓글을 보여줍니다.
            } else {
                console.error(xhr.responseText);
            }
        };

        return false; // 폼 제출 방지
    }
 // 댓글 숨기기/나타나기 토글 함수
 
   
 function likeComment(cno) {
	    $.ajax({
	        url: '/board/likeComment',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({
	            cno: cno,
	            nickname: 'd'
	        }),
	        success: function(data) {
	            if (data.success) {
	                const button = $(`button[onclick="likeComment(${cno})"]`);
	                location.reload();
	            } else {
	                alert('좋아요 처리에 실패하였습니다.');
	            }
	        },
	        error: function() {
	            alert('서버와의 통신에 문제가 발생했습니다.');
	        }
	    });
	}

</script>
