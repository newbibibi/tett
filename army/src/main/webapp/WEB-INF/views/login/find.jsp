<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<meta charset="UTF-8">
<title>계정 찾기</title>
</head>
<body>
	<div class="container">
		<!-- 모든걸 감쌈 -->
		<div class="wrap">
			<!-- 가운데 정렬해서 위치시킬 박스 -->
			<div class="idpw">
				<div id="idf">ID 찾기</div>
				<div id="pwf">PW 찾기</div>
			</div>
			<!-- 아이디 찾기를 눌렀을 때 표시할 것 -->
			<div class="content">
				<div>
					<h1>나라사랑 email을 입력하세요.</h1>
					<input type="email" name="email" required="required"> <input
						id="idfinder" type="button" value="확인">
					<div id="result"></div>
				</div>
			</div>
			<!-- 종료 -->
		</div>
	</div>
	<script type="text/javascript">
window.onload = function() {
    let content = $(".content");
    let ec;
    let checker=false;
	
    $("body").on("click", "#idf", () => {
        content.html("<div><h1>나라사랑 email을 입력하세요.</h1><input type='email' name='email' required='required' placeholder='Email을 입력'> <input id='idfinder' type='button' value='확인'><div id='result'></div></div>");
    });

    $("body").on("click", "#pwf", () => {
        content.html("<div><h1>비밀번호를 찾을 ID를 입력하세요.</h1><input type='text' name='id' required='required' placeholder='ID를 입력'><input type='button' id='pwfinder' value='확인'><div id='result'></div></div>");
    });

    $("body").on("click", "#idfinder", () => {
    	console.log("email val"+$("[name=email]").val());
    	$.ajax({
            url: '../../user/checker',
            method: 'POST',
            data: {
                checkValue: $("[name=email]").val(),
                checkColumn: "email"
            },
            success: function(data) {
                console.log(data);
 				if(data==""){
 					$("#result").html("해당 Email로 등록된 아이디가 존재하지 않습니다.");
                }else{
                	$("#result").html("ID는 "+'"'+data.id+'"'+"입니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    });
    let limiter;
    let id;
    $("body").on("click","#pwfinder", () => {
        $("#result").text("로딩 중..")
    	$.ajax({
            url: '../../user/checker',
            method: 'POST',
            data: {
                checkValue: $("[name=id]").val(),
                checkColumn: "id"
            },
            success: function(data) {
            	if(data!=""){
            		console.log(data.email);
            		$.ajax({
        				url : '../../user/emailauth',
        				method : 'POST',
        				data : {
        					email : data.email
        				},
        				success : function(email) {
        			    	$("#code").remove();
        			        $("#codecheck").remove();
        			        $("#timeout").remove();
        					if (email.includes("나라사랑")||email.includes("유효")) {
        						$("#result").html(email);
        					}
        					else {
        						id=data.id;
        						ec=email;
        						$("#result").html("");
        						$("#pwfinder").after("<input type='text' id='code' placeholder='인증 코드를 입력해주세요.'><input type='button' id='codecheck' value='인증'><div id='timeout'></div>");
        	                    let timer = 180;
        	                    clearInterval(limiter);
        	                    limiter = setInterval(() => {
        	                        timer -= 1;
        	                        $("#timeout").html(Math.floor(timer / 60) + "분 " + (timer % 60) + "초");
        	                        if (timer == 0) {
        	                            ec="";
        	                        	clearInterval(limiter);
        	                        }
        	                    }, 1000);
        					}
        				},
        				error : function(xhr, status, error) {
        					console.error(error);
        				}
        			}); //ajax 종료
            	}else{
            		 $("#result").html("ID가 존재하지 않습니다.");
            	}
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
        
        
     
        });
        //이 아래는 인증코드 if문으로 분기
         $("body").on("click","#codecheck",()=>{
        	if($("#code").val()==ec){
        		console.log("인증 성공");
        		$('.idpw').html("<h1>비밀번호 수정</h1>");
        		content.html("<input type='password' id='pw' placeholder='비밀번호 입력'><bR><input type='password' id='pwc' placeholder='비밀번호 확인'><br><input type='button' id='modify' value='변경하기'><br><div id='pwBox'>");
        	}else{
        		$("#result").html("인증코드가 일치하지 않습니다.");
        	}
        });
        
         $("body").on("click", "#modify", () => {
        	    if (checker) {
        	        let pw = { "pw": $("#pw").val(), "id":id};
        	        console.log(pw);
        	        $.ajax({
        	            url: '../../user/modify',
        	            method: 'POST',
        	            contentType: "application/json",
        	            data: JSON.stringify(pw),
        	            success: function (data) {
        	                console.log(data);
        	                if(data==1){
        	                	alert("비밀번호 변경이 정상적으로 완료되었습니다.");
        	                	window.close();
        	                	
        	                }else if(data==0){
        	                	alert("아이디가 없거나 변경 불가능한 비밀번호입니다.");
        	                	window.close();
        	               	}else{
        	               		alert("치명적인 에러 관리자에게 문의해주세요.");
        	                	window.close();
        	               	}
        	                
        	                
        	            },
        	            error: function (e) {
        	                console.log(e);
        	            }
        	        });
        	        id="";
        	        pw = "";
        	    }
        	});
        
		$("body").on("blur","#pwc", function() {
			let pw=$("#pw");
			let pwc=$("#pwc");
			if (pw.val() == null || pw.val() == "") {
				pw.focus();
				$("#pwBox").text("비밀번호를 먼저 입력하세요.");
			} else {
				if (pwc.val() != pw.val()) {
					pw.css("border", "2px solid red");
					pwc.css("border", "2px solid red");
					$("#pwBox").text("비밀번호가 일치하지 않습니다.");
					pw.focus();
					checker = false;
				} else {
					pw.css("border", "2px solid green");
					pwc.css("border", "2px solid green");
					$("#pwBox").html("");
					checker = true;
				}
			}
		});
		
   		 $("body").on("blur","#pw", function() {
			$("#pwBox").html("");
		});
}
</script>
</body>
</html>