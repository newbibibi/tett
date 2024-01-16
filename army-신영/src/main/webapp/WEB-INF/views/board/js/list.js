  $(document)
				.ready(
						function() {

							loadTableData(); // Ajax 함수 호출

							let result = '${result}';
							console.log(result);

							checkModal(result);

							function checkModal(result) {
								if (result === '') {
									return;
								}

								if (result === "success") {
									$(".modal-body").html("정상적으로 처리 되었습니다.");
								} else if (parseInt(result) > 0) {
									$(".modal-body")
											.html(
													parseInt(result)
															+ "번 글이 등록 되었습니다.");
								}

								$("#myModal").modal("show");
							}

							$("#regBtn")
									.click(
											function() {
												var form = $('<form action="/board/register" method="post"></form>');
												var categoryValue = $(
														'#category').val();
												form
														.append('<input type="hidden" name="nickname" value="d">'); // 닉네임 추가
												form
														.append('<input type="hidden" name="categoryval" value="' + categoryValue + '">');
												$('body').append(form);
												form.submit();
											});

							function loadTableData() {
								$
										.ajax({
											url : "/board/getList",
											type : "POST",
											dataType : "json",
											data : {
												pageNum : $(
														"#actionFrom input[name='pageNum']")
														.val(),
												amount : $(
														"#actionFrom input[name='amount']")
														.val(),
												type : $(
														"#searchForm select[name='type']")
														.val(),
												keyword : $(
														"#searchForm input[name='keyword']")
														.val(),
												category : $(
														"#searchForm select[name='category']")
														.val()
											},
											success : function(data) {
												let boardTbody = $("#boardTable tbody");
												boardTbody.empty(); // 새로운 데이터를 추가하기 전에 테이블 바디를 비움

												$
														.each(
																data,
																function(index,
																		list) {
																	let regDate = new Date(
																			list.regDate);
																	console
																			.log(regDate)
																	let options = {
																		year : "numeric",
																		month : "2-digit",
																		day : "2-digit",
																		hour : "2-digit",
																		minute : "2-digit"
																	}
																	let formatDate = regDate
																			.toLocaleString(
																					"ko-KR",
																					options);

																	let row = $("<tr>");
																	row
																			.append($(
																					"<td>")
																					.text(
																							list.bno));

																	let titleLink = $(
																			"<a>")
																			.attr(
																					"href",
																					"/board/get?bno="
																							+ list.bno)
																			.text(
																					list.title);
																	let titleTd = $(
																			"<td>")
																			.append(
																					titleLink);

																	row
																			.append(titleTd);
																	row
																			.append($(
																					"<td>")
																					.text(
																							list.nickname));
																	row
																			.append($(
																					"<td>")
																					.text(
																							formatDate));
																	row
																			.append($(
																					"<td>")
																					.text(
																							list.views));
																	row
																			.append($(
																					"<td>")
																					.text(
																							list.likes));

																	boardTbody
																			.append(row);
																});
											},
											error : function(e) {
												console.log(e);
											}
										});
							}

							let actionForm = $("#actionFrom");
							$(".paginate_button a").on(
									"click",
									function(e) {
										e.preventDefault();
										actionForm
												.find("input[name='pageNum']")
												.val($(this).attr("href"));
										actionForm.submit();
									});

							let searchForm = $("#searchForm");

							$("#searchForm button").on(
									"click",
									function(e) {
										if (!searchForm.find("option:selected")
												.val()) {
											alert("검색종류를 선택하세요");
											return false;
										}

										searchForm
												.find("input[name='pageNum']")
												.val("1");
										e.preventDefault();
										searchForm.submit();
									});
						});