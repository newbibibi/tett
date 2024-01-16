<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        #page-wrapper {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1.page-header {
            color: #333;
        }

        form {
            margin-bottom: 20px;
        }

        textarea {
            resize: none;
        }

        .btn-group {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        img {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">1:1문의 수정</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">fqnaModify</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<form name="dataForm" id="dataForm">
							<button id="btn-upload" type="button"
								style="border: 1px solid #ddd; outline: none;">파일 추가</button>
							<input id="input_file" multiple="multiple" type="file"
								style="display: none;"> <span
								style="font-size: 10px; color: gray;">※첨부파일은 최대 10개까지 등록이
								가능합니다.</span>
							<div class="data_file_txt" id="data_file_txt"
								style="margin: 40px;">
								<span>첨부 파일</span> <br />
								<div id="articlefileChange"></div>
							</div>
							<div class="form-group">
								<input type="hidden" name="nickname" value="홍길동"> <input
									type="hidden" name="qno" value="${board.qno }">
							</div>
							<div class="form-group">
								<label>제목</label> <input class="form-control" name="title"
									value="${board.title }">
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea class="form-control" rows="5" cols="40" name="content">${board.content }</textarea>
							</div>
							<button type="button" class="btn btn-default" data-oper="modify">수정완료</button>
							<button type="button" class="btn btn-default" data-oper="remove">삭제</button>
						</form>
						<a href="/center/cscenter/fqna"><button>목록으로</button></a>
					</div>
				</div>
			</div>
		</div>

	</div>


	<script type="text/javascript">
		$(document).ready(
				function() {
					$("#input_file").on("change", fileCheck);
					let formObj = $("form");
					$(".btn").click(
							function() {
								let operation = $(this).data("oper");
								console.log(operation);

								if (operation == "remove") {
									formObj.attr("action",
											"/center/cscenter/fqnaRemove")
											.attr("method", "get");
								} else if (operation == "modify") {
									formObj.attr("action",
											"/center/cscenter/fqnaModify")
											.attr("method", "post").attr(
													"onsubmit",
													"return registerAction()");
								}
								formObj.submit();
							});
				});

		$(function() {
			$('#btn-upload').click(function(e) {
				e.preventDefault();
				$('#input_file').click();
			});
		});

		// 파일 현재 필드 숫자 totalCount랑 비교값
		var fileCount = 0;
		// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
		var totalCount = 10;
		// 파일 고유넘버
		var fileNum = 0;
		// 첨부파일 배열
		var content_files = new Array();

		function fileCheck(e) {
			var files = e.target.files;

			// 파일 배열 담기
			var filesArr = Array.prototype.slice.call(files);

			// 파일 개수 확인 및 제한
			if (fileCount + filesArr.length > totalCount) {
				$.alert('파일은 최대 ' + totalCount + '개까지 업로드 할 수 있습니다.');
				return;
			} else {
				fileCount = fileCount + filesArr.length;
			}

			// 각각의 파일 배열담기 및 기타
			filesArr
					.forEach(function(f) {
						var reader = new FileReader();
						reader.onload = function(e) {
							content_files.push(f);
							$('#articlefileChange')
									.append(
											'<div id="file'
													+ fileNum
													+ '" onclick="fileDelete(\'file'
													+ fileNum
													+ '\')">'
													+ '<font style="font-size:12px">'
													+ f.name
													+ '</font>'
													+ '<img src="/img/icon_minus.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>'
													+ '<div/>');
							fileNum++;
						};
						reader.readAsDataURL(f);
					});
			console.log(content_files);
			//초기화 한다.
			$("#input_file").val("");
		}

		// 파일 부분 삭제 함수
		function fileDelete(fileNum) {
			var no = fileNum.replace(/[^0-9]/g, "");
			content_files[no].is_delete = true;
			$('#' + fileNum).remove();
			fileCount--;
			console.log(content_files);
		}

		/*
		 * 폼 submit 로직
		 */
		function registerAction() {
			var form = $("form")[0];
			var formData = new FormData(form);
			for (var x = 0; x < content_files.length; x++) {
				// 삭제 안한것만 담아 준다. 
				if (!content_files[x].is_delete) {
					formData.append("article_file", content_files[x]);
				}
			}
			/*
			 * 파일업로드 multiple ajax처리
			 */
			$.ajax({
				type : "POST",
				enctype : "multipart/form-data",
				url : "/center/file-upload",
				data : formData,
				processData : false,
				contentType : false,
				success : function(data) {
					if (JSON.parse(data)['result'] == "OK") {
						alert("파일업로드 성공");
					} else
						alert("서버내 오류로 처리가 지연되고있습니다. 잠시 후 다시 시도해주세요");
				},
				error : function(xhr, status, error) {
					alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
					return false;
				}
			});
		}
	</script>
</body>

</html>