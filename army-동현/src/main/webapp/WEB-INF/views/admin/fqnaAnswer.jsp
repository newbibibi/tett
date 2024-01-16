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
				<h1 class="page-header">관리자 문의답변창</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">fqnaAnswer</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<form role="form">
							<div class="form-group">
								<input type="hidden" name="qno" value="${board.qno }">
							</div>
							<div class="form-group">
								<label>제목</label> <input class="form-control" name="title" readonly="readonly" value="${board.title }">
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea class="form-control" rows="5" cols="40" name="content" readonly="readonly">${board.content }</textarea>
							</div>
							<div class="form-group">
								<label>답변</label>
								<textarea class="form-control" rows="5" cols="40" name="answer">${board.answer }</textarea>
							</div>
							<button type="button" class="btn btn-default" data-oper = "modify">답변완료</button>
						</form>
						<div>
							<button type="button" class="filebtn">첨부그림확인</button>
							<table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                </thead>
                                <tbody>
                                <tr>
                             
                                </tr>
                                </tbody>
                            </table>
                            <a href="/admin/adminFqna"><button>목록으로</button></a>
						</div>
							
					</div>
				</div>
			</div>
		</div>

	</div>


	<script type="text/javascript">
$(document).ready(function() {
	loadTableData();
	let tbodySection = $("tbody");
    let fileButton = $(".filebtn");

    tbodySection.hide();

    fileButton.click(function () {
        tbodySection.slideToggle();
    });
		let formObj = $("form");
		$(".btn").click(function() {
			let operation = $(this).data("oper");
			console.log(operation);
			
			if(operation == "modify"){
				formObj.attr("action","/admin/fqnaAnswer")
				.attr("method","post");
			}
			formObj.submit();
		});
		function loadTableData() {
			$.ajax({
				url : "/center/cscenter/fqnaFile",
				type : "POST",
				dataType : "json",
				data : {
					qno : $(".form-group").find("input[name='qno']").val()
				},
				success : function(data) {
					let boardTbody = $("tbody");
					$.each(data, function(index,qfile){
						let row = $("<tr>");

						let image = $("<img>").attr("src", "../../../resources/upload/"+qfile.filename).attr("alt", "이미지");

						row.append(image);
						
						boardTbody.append(row);
					});
				},
				error : function(e) {
					console.log(e);
					console.log("문제")
				}
			});
		}
	});
	</script>
</body>

</html>