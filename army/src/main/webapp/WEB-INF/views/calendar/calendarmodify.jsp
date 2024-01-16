<%@ include file="../includes/header.jsp" %>
		<div id="showing">

			<div id="mainpage">
				<!-- Banner -->
				<div id="schedule">
					${vo.content }
					${vo.nickname }
					${vo.startDate }
					${vo.endDate }
				</div>
				<!-- Main -->
				<div id="main">
					<ul id="liTitle">
						<li><a href="">BBBÂ </a></li>
						<li><a href="">CCC</a></li>
						<li><a href="">DDD</a></li>
					</ul>
					<ul>
						<li>dasdasdas</li>
						<li>adasdasda</li>
						<li>asdasdasdas</li>
					</ul>
				</div>
			</div>
			<form id="form">
				<input type="hidden" name="calNo" value="${vo.calNo }">
				<input type="hidden" name="nickname" value="${vo.nickname }">
				<input type="date" name="startDate" id="sd" value="${vo.startDate }" >
				<input type="date" name="endDate" id="ed" value="${vo.endDate }">
				<textarea name="content" rows="" cols="">
				${vo.content }
				</textarea>
				<button class="btn" type="submit" data-oper="modify">dd</button>
				<button class="btn" type="submit" data-oper="delete">&times;</button>
			</form>
			<aside>
				<div id="date">
					EEEÂÂ
				</div>
				<div id="bap">
					FF
				</div>
			</aside>
		</div>
		<section id="mobile_showing">
			<div id="date">
				GGGÂÂ
			</div>
			<div id="bap">
				HHH
			</div>
		</section>
		
	<script type="text/javascript">
	$(document).ready(function() {
		
		let formObj = $("form");
		
			$(".btn").click(function() {
				let operation = $(this).data("oper");
				console.log(operation);
				
				if(operation == "delete"){
					formObj.attr("action","/calendar/remove")
						.attr("method", "post");
				}
				else if(operation == "modify"){
					formObj.attr("action","/calendar/calendarmodify")
					.attr("method", "post");
				}
				formObj.submit();
			});
		});
</script>
	<!-- Footer -->
<%@ include file="../includes/footer.jsp" %>	