<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<script type="text/javascript">

var g_sub_menu_inited = false;

$(document).ready(function(){ 	
	load_sub_menu();
});

function load_sub_menu() {
	if(g_sub_menu_inited || "anonymousUser" == "${user}")
		return;

	g_sub_menu_inited = true;

	var on_menu = document.querySelector(".top_menu.on");
	var prt_menu_id = on_menu.id.replace("top_menu_", "");

	ajaxPost({
			sid		  	: "SubMenuList"
		,	sql		  	: "rawris.krc.menumgt.user_sub_menu_list"
		, 	cmd 	  	: "selectList"
		, 	db_type   	: "rawris"
		//,	user_id	  	: "${user}"
		,	user_id	  	: "test10"
		,	prt_menu_id : prt_menu_id
		,	async     	: false
		,	successFn 	: function(sid, rslt) { makeSubMenu(sid, rslt); }
	});
}

function makeSubMenu(sid, rslt) {
	var contxtroot = getContextPath();
	var sub_menu_id, sub_menu_nm, sub_menu_url, sub_menu_html;
	$.each(rslt, function(indx, menuInfo) {
		sub_menu_id = menuInfo.MENU_ID;
		sub_menu_nm = menuInfo.MENU_NM;
		sub_menu_url = menuInfo.MAIN_URL;
		
		sub_menu_html = '<li><a href="' + contxtroot + sub_menu_url + '" id="sub_menu_' + sub_menu_id + '">' + sub_menu_nm + '</a></li>';
		$(".sub_menu>ul").append(sub_menu_html);
		
		if(location.pathname.search(sub_menu_url) != -1) {
			$("#sub_menu_"+sub_menu_id).addClass("on");
			$("#current_menu_class").val(menuInfo.MENU_CLASS);
		}
	});
}
</script>

			<div class="sub_menu">
                <ul></ul>
            </div>
            <input type="hidden" id="current_menu_class">
         