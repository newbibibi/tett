<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div id="banner-area" class="banner-area" style="background-color: rgb(50 137 76)">
  <div class="banner-text">
    <div class="container">
        <div class="row">
          <div class="col-lg-12">
              <div class="banner-heading">
                <h1 class="banner-title">커뮤니티</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                      <li class="breadcrumb-item"><a href="#">자유</a></li>
                      <li class="breadcrumb-item"><a href="#">베스트</a></li>
                      <li class="breadcrumb-item"><a href="#">썰게시판</a></li>
                      <li class="breadcrumb-item"><a href="#">꿀팁</a></li>
                    </ol>
                </nav>
              </div>
          </div><!-- Col end -->
        </div><!-- Row end -->
    </div><!-- Container end -->
  </div><!-- Banner text end -->
</div><!-- Banner area end --> 
<section id="main-container" class="main-container">
   <div class="container">
      <!--/ Title row end -->
      

	
      <div class="tableset container-md">
      	<div class="tableset-inner">
      		<table class="tableset-table table table-hover">
      			<colgroup>
      				<col>
      				<col>
      				<col>
      				<col>
      			</colgroup>
      			<thead class="thead-border-top">
      				<tr>
      					<th class="bno">번호</th>
      					<th class="#"><span>제목</span></th>
      					<th class="short">작성날짜</th>
      				</tr>
      			</thead>
      			<tbody>
      				<tr>
      					<td class="bno">1</td>
      					<td class="#"><a href="#"><span>제목1</span></a>
      					<td class="short">2022.01.01</td>
      				</tr>
      				<tr>
      					<td class="bno">1</td>
      					<td class="#"><a href="#"><span>제목2</span></a>
      					<td class="short">2022.01.01</td>
      				</tr>
      				<tr>
      					<td class="bno">1</td>
      					<td class="#"><a href="#"><span>제목3</span></a>
      					<td class="short">2022.01.01</td>
      				</tr>
      				<tr>
      					<td class="bno">1</td>
      					<td class="#"><a href="#"><span>제목4</span></a>
      					<td class="short">2022.01.01</td>
      				</tr>
      			</tbody>
      		</table>
      		<nav class="pagiset pagiset-circ">
      			<div class="pagiset-ctrl">
      				<a class="fas fa-angle-double-left pagiset-link pagiset-first" href="#">
      					
      				</a>
      			</div>
      			<div class="pagiset-ctrl">
      				<a class="fas fa-angle-left pagiset-link pagiset-prev" href="#">
      			
      				</a>
      			</div>
      			<div class="pagiset-list">
	      			<a class="pagiset-link active-fill" href="#">1</a>
	      			<a class="pagiset-link" href="#">2</a>
	      			<a class="pagiset-link" href="#">3</a>
      			</div>
      			
      			<div class="pagiset-ctrl">
      				<a class="fas fa-angle-double-right pagiset-link pagiset-next" href="#">
      				
      				</a>
      			</div>
      			<div class="pagiset-ctrl">
      				<a class="fas fa-angle-right pagiset-link pagiset-last" href="#">
      				</a>
      			</div>
      		</nav>
      	</div>
      </div>

   </div><!-- Container end -->
</section><!-- Main container end -->


<%@include file="includes/footer.jsp"%>


 