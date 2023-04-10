<%@ taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date"/>
<fmt:formatDate value="${today}" pattern="yyyyMMddHH" var="nowDate"/>

	<%@include file="/resources/wrms/inc/default.inc"%>

	<%@include file="/resources/wrms/inc/sha.inc"%>
	
	<c:choose>
		<c:when test="${chkPageGroup == 'qms'}">
			<%@include file="/resources/wrms/inc/zingchart_new.inc"%>
		</c:when>
		<c:otherwise>
				<%@include file="/resources/wrms/inc/zingchart.inc"%>
		</c:otherwise>
	</c:choose>
	
	<%@include file="/resources/wrms/inc/utils.inc"%>

	<c:choose>
		<c:when test="${chkPageGroup == 'equipRegist'}">
			<script src="<c:url value='/resources/wrms/js/equip_mng.js?'><c:param name="v" value="${nowDate}"/></c:url>"></script> 
		</c:when>
		<c:otherwise>
			<script src="<c:url value='/resources/wrms/js/searchForm.js?'><c:param name="v" value="${nowDate}"/></c:url>"></script> 
		</c:otherwise>
	</c:choose>
	
	
	<script type="text/javascript">
		var searchConditionObj 	= {
				s_kind_time : 'minute'
			,	uBcd		: '${details.level_buseo_code}'
			,	uBlvl		: Number('${details.buseo_level}')
			,	uBorg		: '${details.orgin_buseo_code}'
	   		,	db_type		: 'rims'
	    };
	</script>
		
	
