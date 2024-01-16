<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">/*
.head {
	border: 1px solid red;
	height: 20vh;
	width: 100vw;
}

.logo {width 200px;
	height: 50px;
	border: 1px solid blue;
}

.loginBtn {
	width: 30px;
	height: 30px;
}

.box {
	color: red;
}*/
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f4f4f4;
}

.head {
    background-color: #f8f9fa;
    padding: 20px;
    text-align: center;
}

.logo {
    font-size: 25px;
    color: #343a40;
}

.loginBox {
    max-width: 600px;
    margin: 0 auto;
    margin-top: 50px;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

#sign {
    display: flex;
    flex-direction: column;
}

#sign h1 {
    text-align: center;
    color: #343a40;
}

#sign input[type="text"],
#sign input[type="password"],
#sign input[type="email"],
#sign input[type="date"],
#sign select {
    margin: 10px 0;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

#sign button {
    padding: 10px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 20px;
}

#sign button:hover {
    background-color: #0056b3;
}

</style>



<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	window.onload = function() {
		let ec;
		let nick = $("[name=nickname]");
		let id = $("[name=id]");
		let email = $("[name=email]");
		let nickBox = $(".nickCheck");
		let idBox = $(".idCheck");
		let emailBox = $(".emailCheck");
		let pw = $("[name=pw]");
		let pwc = $("[name=pwc]");
		let pwBox = $(".pwCheck");

		let checker1 = false;
		let checker2 = false;
		let checker3 = false;
		let checker4 = false;
		let checker5 = false;
		let bcheck1=false; // 버튼 생성 한번만 되도록 체크
		let bcheck2=false; // 버튼 생성 한번만 되도록 체크
		let bcheck3=false; // 버튼 생성 한번만 되도록 체크
		
		nick.bind("blur", function() {
			$.ajax({
				url : '../../user/checker',
				method : 'POST',
				data : {
					checkValue : nick.val(), checkColumn : "nickname"
				},
				success : function(data) {
					if (nick.val() != "") {
						if (data != "") {
							nick.css("border", "2px solid red");
							nickBox.text("중복된 닉네임이 존재합니다.");
							checker1 = false;
							nick.focus();
							console.log("c1" + checker1);
						} else {
							nick.css("border", "2px solid green");
							nickBox.html("");
							checker1 = true;
							console.log("c1" + checker1);
						}
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
		});

		id.bind("blur", function() {
			$.ajax({
				url : '../../user/checker',
				method : 'POST',
				data : {
					checkValue : id.val(), checkColumn : "id"
				},
				success : function(data) {
					if (id.val() != "") {
						if (data != "") {
							id.css("border", "2px solid red");
							idBox.text("중복된 아이디가 존재합니다.");
							checker2 = false;
							id.focus();
							console.log("c2" + checker2);
						} else {
							id.css("border", "2px solid green");
							idBox.html("");
							checker2 = true;
							console.log("c2" + checker2);
						}
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
		});

		email.bind("blur", function() {
			$.ajax({
				url : '../../user/checker',
				method : 'POST',
				data : {
					checkValue : email.val(), checkColumn : "email"
				},
				success : function(data) {
					if (email.val() != "") {
						if (data != "") {
							email.css("border", "2px solid red");
							emailBox.text("중복된 이메일이 존재합니다.");
							checker3 = false;
							email.focus();

						} else {
							email.css("border", "2px solid green");
							emailBox.html("");
							checker3 = true;
							if(!bcheck1){
							email.after("<Button type='button' id='eauth'>인증 요청</button>");
							bcheck1=true;
							}
						}
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
		});
		let timeout;
		$("body").on("click",'#eauth',function()
		{ // 인증 버튼을 누르게 되면 ajax로 ec에 랜덤코드 넣어줌
			$.ajax({
				url : '../../user/emailauth',
				method : 'POST',
				data : {
					email : email.val()
				},
				success : function(data) {
					if (data.includes("나라사랑")) {
						emailBox.text(data);
					}else if(data.includes("유효")){
						emailBox.text(data);
					}
					else {
						emailBox.html("");
						ec = data;
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			}); //ajax 종료
			clearInterval(timeout);
			$("#authcheck").remove();
			$("#checkconfirm").remove();
			$("#limit").remove();
			$("#eauth").after("<input type='text' id='authcheck'>");
			$("#authcheck").after("<button type='button' id='checkconfirm'>인증 확인</button> <div id='limit'></div>");
			
			let time=180;
			timeout=setInterval(() => {
			if(time==0){
					ec="";
				clearInterval(timeout);
				$("#authcheck").remove();
				$("#checkconfirm").remove();
				$("#limit").remove();
			}else{
				time-=1;
			}
				$("#limit").html(Math.floor(time / 60) + "분 " + (time % 60) + "초");
			}, 1000);
			
		}); //eauth 종료

		$("body").on("click","#checkconfirm",function() {
			console.log(ec);
			if (ec == $("#authcheck").val()) {
				clearInterval(timeout);
				$("#limit").remove();
				emailBox.text("인증 성공!");
				emailBox.css("color", "green");
				checker5 = true;
				$("#eauth").remove();
				$("#authcheck").remove();
				$("#checkconfirm").remove();
				
			} else {
				emailBox.text("값이 올바르지 않습니다.");
				emailBox.css("color", "red");
				checker5 = false;
			}
		});

		pwc.bind("blur", function() {
			if (pw.val() == null || pw.val() == "") {
				pw.focus();
				pwBox.text("비밀번호를 먼저 입력하세요.");
			} else {
				if (pwc.val() != pw.val()) {
					pw.css("border", "2px solid red");
					pwc.css("border", "2px solid red");
					pwBox.text("비밀번호가 일치하지 않습니다.");
					pw.focus();
					checker4 = false;
				} else {
					pw.css("border", "2px solid green");
					pwc.css("border", "2px solid green");
					pwBox.html("");
					checker4 = true;
				}
			}
		});
		pw.bind("blur", function() {
			pwBox.html("");
		});

		$("#sign").submit(function(event) {
			event.preventDefault();
		});

		$("#signup").click(
				function() {
					console.log(checker1 && checker2 && checker3 && checker4
							&& checker5);
					if (checker1 && checker2 && checker3 && checker4
							&& checker5) {
						$("#sign").unbind("submit");
						$("#sign").submit();
					}
				});
	} //onload 종료
	

</script>
</head>
<body>
	<div class="head">
		<div class="logo">당군</div>
	</div>
	<div class="loginBox">
		<div>
			<div>
				<form action="../login/sign" method="post" id="sign">
					<h1>회 원 가 입</h1>
					<input type="text" placeholder="닉네임" name="nickname"
						required="required"><br>
					<div class="nickCheck box"></div>
					<input type="text" placeholder="아이디" name="id" required="required"><br>
					<div class="idCheck box"></div>
					<input required="required" type="password" placeholder="비밀번호"
						name="pw"> <br> <input required="required"
						type="password" placeholder="비밀번호 확인" name="pwc">
					<div class="pwCheck box"></div>
					<input required="required" type="email" placeholder="이메일"
						name="email"> <br>
					<div class="emailCheck box"></div>
					<input required="required" type="date" placeholder="입대일"
						name="enlisting"> <select name="armygroup">
						<optgroup label="군종"></optgroup>
						<option value="earth">육군</option>
						<option value="sea">해군</option>
						<option value="fly">공군</option>
					</select><br> <input type="hidden" name="sns" value="${snsID}">
					<div class="lastBox box"></div>
					<button id="signup">확인</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>