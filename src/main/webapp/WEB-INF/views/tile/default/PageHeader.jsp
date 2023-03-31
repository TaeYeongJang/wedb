<%@ page contentType="text/html;charset=utf-8" %> 
<sec:authorize access="isAuthenticated()">
	<header class="main-header"> 
		<a href="<c:url value='/gis/main'/>" class="logo">
			<span class="logo-mini" style="padding-top: 10px;"><img src="<c:url value='/resources/wrms/image/layout/krc_ci_S.png'/>" style="width: 100%;"></span>
			<span class="logo-lg"><b style="color: #ffffff;">RAWRIS</b></span>
		</a>
		<nav class="navbar navbar-static-top"> 
			<div class="navbar-custom-menu">
				<ul class="nav navbar-nav"> 
					<li class="dropdown user user-menu">
						<a href="<c:url value='/j_spring_security_logout'/>" class="dropdown-toggle">
							<span class="hidden-xs">로그아웃</span>
						</a>
					</li> 
				</ul>
			</div>
		</nav>
	</header>
</sec:authorize>