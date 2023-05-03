<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DIMAS 재난안전종합상황실</title>
   
    <%@include file="/WEB-INF/views/tile/default/PageScript.jsp"%>
	<%@include file="/resources/wrms/inc/jsgrid.inc"%>

	
	<link rel="stylesheet" href="<c:url value='/resources/sass/css/main.css?v=01'/>" /> 
    <!-- icon- font awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

 	<style>
	
  .carousel-item {
    display: none;
  }
  .carousel-item.active {
    display: block;
  }
     </style>

</head>
<body>

<div>
  <dl>
    <dt>Slide 1</dt>
    <dd>test1</dd>
    <dd>test2</dd>
    <dd>test3</dd>
  </dl>
  <dl>
    <dt id="slide2">Slide 2</dt>
    <dd class= "carousel-item active" >test4</dd>
    <dd>test5</dd>
    <dd>test6</dd>
  </dl>
</div>
    
    
    
</body>

 <script>
 const slide = document.querySelector("#slide2");
 const dds = slide.parentElement.querySelectorAll("dd");

 dds.forEach(function (dd) {
   dd.classList.add("carousel-item");
 });

 const items = document.querySelectorAll(".carousel-item");
 let index = 0;

 setInterval(function () {
   items[index].classList.remove("active");
   index++;
   if (index === items.length) {
     index = 0;
   }
   items[index].classList.add("active");
 }, 3000);
    </script>
</html>