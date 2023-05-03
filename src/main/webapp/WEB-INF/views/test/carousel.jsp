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
     .carousel dd {
  position: absolute;
  top: 0;
  left: 0;
  opacity: 0;
  transition: opacity 1s ease-in-out;
}

.carousel dd.active {
  opacity: 1;
}

.carousel dd.active ~ dd {
  opacity: 0;
}

     </style>
     
     <script type="text/javascript">
	     const ddList = document.querySelectorAll('.carousel dd');
	
	     setInterval(() => {
	       const active = document.querySelector('.carousel dd.active');
	       let next;
	       if (active) {
	         next = active.nextElementSibling || ddList[0];
	         active.classList.remove('active');
	       } else {
	         next = ddList[0];
	       }
	       next.classList.add('active');
	     }, 1000);
	</script>
	
	
</head>
<body>
	   <div class="carousel">
			  <dl>
			    <dt>Slide 1</dt>
			    <dd class="active">Content for slide 1 goes here.</dd>
			    <dd>Content for slide 2 goes here.</dd>
			    <dd>Content for slide 3 goes here.</dd>
			  </dl>
			  <dl>
			    <dt>Slide 2</dt>
			    <dd>Content for slide 4 goes here.</dd>
			    <dd>Content for slide 5 goes here.</dd>
			    <dd>Content for slide 6 goes here.</dd>
			  </dl>
		</div>
    
</body>
</html>