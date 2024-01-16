<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="../../includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <h1>자주묻는 질문</h1>
    
    <div id="page-wrapper">
    <a href="/center/cscenter/fqna">
        <button>1:1문의</button>
    </a>
        <div id="firstFAQ">
            <div id="catebtn">
                <button>계정/보안</button>
                <button>홈페이지</button>
            </div>
            <div id="faqboard">
                <ul id="faqul"></ul>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            initialLoad();

            $("#catebtn button").click(function () {
                var selectedCategory = '';

                if ($(this).text() === '홈페이지') {
                    selectedCategory = 'H';
                } else if ($(this).text() === '계정/보안') {
                    selectedCategory = 'A';
                }

                loadTableData(selectedCategory);
            });

            function initialLoad() {
                var initialCategory = 'A';

                loadTableData(initialCategory);
            }

            function loadTableData(category) {
                $.ajax({
                    url: "/center/cscenter/faqList",
                    type: "POST",
                    dataType: "json",
                    data: {
                        category: category
                    },
                    success: function (data) {
                        let faqul = $("#faqul");
                        faqul.empty();

                        $.each(data, function (index, faq) {
                            let row = $("<li id='faqli'>");
                            let title = $("<div id='faqtitle'>").text(faq.title);
                            let contentbox = $("<div id='faqcontentbox'>");
                            contentbox.append($("<div>").text(faq.content));
                            row.append(title);
                            row.append(contentbox);
                            faqul.append(row);

                            row.click(function () {
                                contentbox.slideToggle();
                            });
                        });
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }
        });
    </script>
<%@include file="../../includes/footer.jsp"%>