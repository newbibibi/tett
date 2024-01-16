<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f4f4f4;
}

.head {
	border: 1px solid red;
	height: 20vh;
	width: 100vw;
	display: flex;
	justify-content: center;
	align-items: center;
}

.logo {
	width: 200px;
	height: 50px;
	border: 1px solid blue;
	text-align: center;
	padding: 10px;
}

.loginBox {
	max-width: 600px;
	margin: 0 auto;
	margin-top: 50px;
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	align-items: center;
}


.loginBox input[type="text"], .loginBox input[type="password"] {
	margin: 10px 0;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.loginBox button {
	padding: 10px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin: 10px 0;
}

.loginBox button:hover {
	background-color: #0056b3;
}

.loginBtn {
	width: 30px;
	height: 30px;
	margin: px;
}

[onclick='login()'] {
	width: 190px;
}
body{
	background-image: url("/resources/img/background.png");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(() => {
    $(".signup").click(() => {
      window.location.href = "../user/login/join";
    });

    $(".findAccount").click(function(){
    	window.open("../user/login/find", "아이디/비밀번호 찾기", "width=400,height=600,left=100,top=50,resizable=yes,scrollbars=no");
    });
});
	function login(){
		let id=$("[name=id]");
		let pw=$("[name=pw]");
		$.ajax({
			url : '../../user/login/login',
			method : 'POST',
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			data : {
				"id" : id.val(), "pw" : pw.val()
			},
			success : function(data) {
				if(data.includes("성공")){
					window.location.href="../user/main";
				}else{
					$(".loginResult").css("color","red");
					$(".loginResult").html(data);
				}
			},
			error : function(xhr, status, error) {
				console.error(error);
			}
	});
	}

</script>
</head>
<body>
	<div class="head">
		<div class="logo">당군</div>
	</div>
	<div class="loginBox">
		<input type="text" placeholder="아이디" name="id" required="required">
		<input required="required" type="password" placeholder="비밀번호"
			name="pw">

		<div class="loginResult box"></div>
		<button onclick="login()">로그인</button>
		<div>
			<div>
				<button class="findAccount">ID/PW찾기</button>
				<button class="signup">회원가입</button>
			</div>

		</div>

		<div>
			<a href="../user/authReq?v=k"><img class="loginBtn" alt=""
				src="/resources/img/KakaoBtn.png"></a> <a
				href="../user/authReq?v=n"><img class="loginBtn" alt=""
				src="/resources/img/NaverBtn.png"></a> <a
				href="../user/authReq?v=g"><img class="loginBtn" alt=""
				src="/resources/img/GoogleBtn.png"></a>
		</div>

	</div>



</body>
</html>