<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="UTF-8">
    <title>여기에 제목을 입력하세요</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        #page-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        button {
            padding: 8px;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        #firstFAQ {
            margin-top: 20px;
        }

        #catebtn {
            margin-bottom: 20px;
        }

        #catebtn button {
            margin-right: 10px;
        }

        #faqboard {
            border: 1px solid #ddd;
            padding: 10px;
        }

        #faqul {
            list-style: none;
            padding: 0;
        }

        #faqli {
            margin-bottom: 10px;
            border: 1px solid #ddd;
            padding: 10px;
            cursor: pointer;
        }

        #faqtitle {
            font-weight: bold;
        }

        #faqcontentbox {
            display: none;
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
</body>

</html>