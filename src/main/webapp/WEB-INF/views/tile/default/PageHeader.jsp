<%@ page contentType="text/html;charset=utf-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

var g_top_menu_inited = false;

$(document).ready(function(){ 
	load_top_menu();
});

function load_top_menu() {
	if(g_top_menu_inited || "anonymousUser" == "${user}")
		return;

	g_top_menu_inited = true;

	ajaxPost({
			sid		  : "TopMenuList"
		,	sql		  : "rawris.krc.menumgt.user_top_menu_list"
		, 	cmd 	  : "selectList"
		, 	db_type   : "rawris"
		//,	user_id	  : "${user}"
		,	user_id	  : "test10"
		,	async     : false
		,	successFn : function(sid, rslt) { makeTopMenu(sid, rslt); }
	});
}

function makeTopMenu(sid, rslt) {
	var contxtroot = getContextPath();
	var top_menu_id, top_menu_nm, top_menu_url, top_menu_html, top_menu_split;
	$.each(rslt, function(indx, menuInfo) {
		top_menu_id = menuInfo.MENU_ID;
		top_menu_nm = menuInfo.MENU_NM;
		top_menu_url = menuInfo.MAIN_URL;
		
		top_menu_html = '<li><a href="' + contxtroot + top_menu_url + '" id="top_menu_' + top_menu_id + '" class="top_menu">' + top_menu_nm + '</a></li>';
		$(".main-menu").append(top_menu_html);

		if(top_menu_url) top_menu_split = top_menu_url.split('/')[1];
		if(top_menu_url && location.pathname.search(top_menu_split) != -1)
			$("#top_menu_"+top_menu_id).addClass("on");
	});
}
</script>
	
	<header id="header">
       <div class="header__wrap">
            <h1><a href=""><img src="<c:url value='/resources/sass/images/common/logo.png'/>" alt="DIMAS 재난안전종합상황실"></a></h1>
            <nav id="nav">
                <ul class="main-menu"></ul>
            </nav>
            <div class="sub-menu">
                <ul class="menu">
                    <li><a href="" class="news"><span class="new">1</span><i class="fa-sharp fa-solid fa-bell"><span class="hidden">알람</span></i></a></li>
                    <li><a href="" class="settings"><i class="fa-sharp fa-solid fa-gear"><span class="hidden">설정</span></i></a></li>
                    <li><a href="" class="user"><i class="fa-solid fa-user"></i><span class="hidden">정보수정</span></a></li>                  
                </ul>
                <a href="" class="logout">로그아웃</a>
            </div>
       </div>
    </header>     
