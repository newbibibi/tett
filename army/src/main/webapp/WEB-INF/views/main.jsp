<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="banner-carousel banner-carousel-1 mb-0">
  <div class="banner-carousel-item" style="background-image:url(../../../resources/images/slider-main/할인배너.png)">
    <div class="slider-content">
        <div class="container h-100">
          <div class="row align-items-center h-100">
              <div class="col-md-12 text-center">
                <h2 class="slide-title" data-animation-in="slideInLeft">국군의 날</h2>
                <h3 class="slide-sub-title" data-animation-in="slideInRight">군 장병 할인 혜택</h3>
                <p data-animation-in="slideInLeft" data-duration-in="1.2">
                    
                    <a href="/center/information/benefit" class="slider btn btn-primary border">자세히 보기</a>
                </p>
              </div>
          </div>
        </div>
    </div>
  </div>

  <div class="banner-carousel-item" style="background-image:url(../../../resources/images/slider-main/배너2.png)">
    <div class="slider-content text-left">
        <div class="container h-100">
          <div class="row align-items-center h-100">
              <div class="col-md-12">
                <h2 class="slide-title-box" data-animation-in="slideInDown">군적금</h2>
                <h3 class="slide-title" data-animation-in="fadeIn">당신도 할 수 있다!</h3>
                <h3 class="slide-sub-title" data-animation-in="slideInLeft">군 장병 금융혜택</h3>
                <p data-animation-in="slideInRight">
                    <a href="services.html" class="slider btn btn-primary border">자세히 보기</a>
                </p>
              </div>
          </div>
        </div>
    </div>
  </div>

  <div class="banner-carousel-item" style="background-image:url(../../../resources/images/slider-main/배너3.png)">
    <div class="slider-content text-right">
        <div class="container h-100">
          <div class="row align-items-center h-100">
              <div class="col-md-12">
                <h2 class="slide-title" data-animation-in="slideInDown">군 할인 혜택</h2>
                <h3 class="slide-sub-title" data-animation-in="fadeIn">군 장병 할인 혜택</h3>
                <p class="slider-description lead" data-animation-in="slideInRight">현역 병사라면 누구나</p>
                <div data-animation-in="slideInLeft">
                    
                    <a href="/center/information/benefit" class="slider btn btn-primary border" aria-label="learn-more-about-us">확인하기</a>
                </div>
              </div>
          </div>
        </div>
    </div>
  </div>
</div>

<section class="call-to-action-box no-padding">
  <div class="container">
    <div class="action-style-box">
        <div class="row align-items-center">
          <div class="col-md-8 text-center text-md-left">
              <div class="call-to-action-text">
                <h3 class="action-title">모두가 함께쓰는 커뮤니티 게시판</h3>
              </div>
          </div><!-- Col end -->
          <div class="col-md-4 text-center text-md-right mt-3 mt-md-0">
              <div class="call-to-action-btn">
                <a class="btn btn-dark" href="#">바로 가기</a>
              </div>
          </div><!-- col end -->
        </div><!-- row end -->
    </div><!-- Action style box -->
  </div><!-- Container end -->
</section><!-- Action end -->

<section id="ts-features" class="ts-features">
  <div class="container">
  </div>
        </div><!-- Col end -->
	<section id="news" class="news">
  <div class="container">
    <div class="row text-center">
        <div class="col-12">
          <h2 class="section-title">your army</h2>
          <h3 class="section-sub-title">Utility Services</h3>
        </div>
    </div>
    <!--/ Title row end -->

    <div class="row">
        <div class="col-lg-4 col-md-6 mb-4">
          <div class="latest-post">
              <div class="latest-post-media">
                <a href="news-single.html" class="latest-post-img">
                    <img loading="lazy" class="img-fluid" src="../../../resources/images/news/calendar.PNG" alt="img">
                </a>
              </div>
              <div class="post-body">
                <h4 class="post-title">
                    <a href="news-single.html" class="d-inline-block">오늘의 일정 확인하기</a>
                </h4>
                <div class="latest-post-meta">
                    <span class="post-item-date">
                      <i class="fa fa-clock-o"></i>
                    </span>
                </div>
              </div>
          </div><!-- Latest post end -->
        </div><!-- 1st post col end -->

        <div class="col-lg-4 col-md-6 mb-4">
          <div class="latest-post">
              <div class="latest-post-media">
                <a href="news-single.html" class="latest-post-img">
                    <img loading="lazy" class="img-fluid" src="../../../resources/images/news/food.PNG" alt="img">
                </a>
              </div>
              <div class="post-body">
                <h4 class="post-title">
                    <a href="news-single.html" class="d-inline-block">오늘의 메뉴 확인하기</a>
                </h4>
                <div class="latest-post-meta">
                    <span class="post-item-date">
                      <i class="fa fa-clock-o"></i>
                    </span>
                </div>
              </div>
          </div><!-- Latest post end -->
        </div><!-- 2nd post col end -->

        <div class="col-lg-4 col-md-6 mb-4">
          <div class="latest-post">
              <div class="latest-post-media">
                <a href="news-single.html" class="latest-post-img">
                    <img loading="lazy" class="img-fluid" src="../../../resources/images/news/center.PNG" alt="img">
                </a>
              </div>
              <div class="post-body">
                <h4 class="post-title">
                    <a href="news-single.html" class="d-inline-block">FAQ</a>
                </h4>
                <div class="latest-post-meta">
                    <span class="post-item-date">
                      <i class="fa fa-clock-o"></i> 자주묻는 질문
                    </span>
                </div>
              </div>
          </div><!-- Latest post end -->
        </div><!-- 3rd post col end -->
    </div>
    <!--/ Content row end -->


  </div>
  <!--/ Container end -->
</section>
<!--/ News end -->
        
    </div><!-- Row end -->
  </div><!-- Container end -->
</section><!-- Feature are end -->



<section id="project-area" class="project-area solid-bg">
  <div class="container">
    <div class="row text-center">
     
    </div>
    <!--/ Title row end -->

    <div class="row">
<div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">공지사항 게시판</h6>
                        <a href="">더 보기</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                   
                                    <th scope="col">제목</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">추천</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                   
                                    <td><a href="#">서머너즈 워 “1,600여 종 몬스터 관리 더 쉽고 편리하게”</a></td>
                                    <td>운영자</td>
                                    <td>50</td>
                                    
                                </tr>
                                <tr>
                                    
                                    <td><a href="#">2024 LCK 스프링, 다양한 프로그램으로 팬 시선 잡는다</a></td>
                                    <td>익명</td>
                                    <td>40</td>
                                    
                                </tr>
                                <tr>
                                   
                                    <td><a href="#">하스스톤 미니 세트, ‘심원의 영지 심층 탐험’ 1월 19일 출시</a></td>
                                    <td>홍길동</td>
                                    <td>46</td>
                                    
                                </tr>
                                <tr>
                                    
                                    <td><a href="#">부활도 진행도 더 빨라진다! 오버워치2, '더 빠른 대전' 공개</a></td>
                                    <td>임꺽정</td>
                                    <td>76</td>
                                    
                                </tr>
                                <tr>
                                    
                                    <td><a href="#">CES 2024, 게이머들이 주목할 포인트는?</a></td>
                                    <td>익명</td>
                                    <td>23</td>
                                    
                                </tr>
                            </tbody>
                        </table>
                        
                    </div>
                </div>
                <div class="bg-light text-center rounded p-4 ">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">커뮤니티 게시판</h6>
                        <a href="">더 보기</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                   
                                    <th scope="col">제목</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">추천</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                   
                                    <td><a href="#">서머너즈 워 “1,600여 종 몬스터 관리 더 쉽고 편리하게”</a></td>
                                    <td>운영자</td>
                                    <td>50</td>
                                    
                                </tr>
                                <tr>
                                    
                                    <td><a href="#">2024 LCK 스프링, 다양한 프로그램으로 팬 시선 잡는다</a></td>
                                    <td>익명</td>
                                    <td>40</td>
                                    
                                </tr>
                                <tr>
                                   
                                    <td><a href="#">하스스톤 미니 세트, ‘심원의 영지 심층 탐험’ 1월 19일 출시</a></td>
                                    <td>홍길동</td>
                                    <td>46</td>
                                    
                                </tr>
                                <tr>
                                    
                                    <td><a href="#">부활도 진행도 더 빨라진다! 오버워치2, '더 빠른 대전' 공개</a></td>
                                    <td>임꺽정</td>
                                    <td>76</td>
                                    
                                </tr>
                                <tr>
                                    
                                    <td><a href="#">CES 2024, 게이머들이 주목할 포인트는?</a></td>
                                    <td>익명</td>
                                    <td>23</td>
                                    
                                </tr>
                            </tbody>
                        </table>
                        
                    </div>
                </div>
            </div>
      

    </div><!-- Content row end -->
    
  </div>
  <!--/ Container end -->
</section><!-- Project area end -->


<%@include file="includes/footer.jsp"%>


 