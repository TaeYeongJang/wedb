<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>부트스트랩 Carousel 예제</title>
    
    <%@include file="/WEB-INF/views/tile/default/PageScript.jsp"%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	 <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> 
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
	    $('.carousel-inner').carousel({
			  interval: 1000
		}) ;
    </script>
    
    
  </head>
  <body>
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="">
        <div class="carousel-item active">
          <img class="d-block w-100" src="<c:url value='/resources/sass/images/common/map_sample.jpg'/>" alt="첫 번째 슬라이드">
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="<c:url value='/resources/sass/images/common/graph_sample.png'/>" alt="두 번째 슬라이드">
        </div>
        <div class="carousel-item">
          <img class="d-block w-100" src="<c:url value='/resources/sass/images/common/graph.png'/>" alt="세 번째 슬라이드">
        </div>
      </div>
      <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">이전</span>
      </a>
      <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">다음</span>
      </a>
    </div>
  </body>
</html>