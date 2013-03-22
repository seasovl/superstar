<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
<link rel="stylesheet" href="resources/css/dot-luv/jquery-ui.css" />
<script src="resources/jquery-1.8.3.js"></script>
<script src="resources/jquery-ui-1.9.1.custom.js"></script>
<!-- <link rel="stylesheet" href="resources/css/demos.css" /> -->
<link rel="stylesheet" href="resources/style.css" />
<script>   
$(function() {
    $( "#selectable" ).selectable();
	var icons = {
		header : "ui-icon-circle-arrow-e",
		activeHeader : "ui-icon-circle-arrow-s"
	};
	$("#accordion").accordion({
		icons : icons,
		heightStyle: "content"
	});
	$("#toggle").button().click(function() {
		//$("#task").submit();
	});

	$(":checkbox").button({
        icons: {
            primary: "ui-icon-plusthick"
        },text: false}).click(function(date){
			
        	// getter
        	var icons = $( this ).button( "option", "icons" );
        	if($(this).attr("checked")=="checked")
        	{        	// setter
        		$( this ).button( "option", "icons", { primary: "ui-icon-check" } );
        	}else{
        		$( this ).button( "option", "icons", { primary: "ui-icon-plusthick" } );
        	}
        });

});
</script>
<style>

</style>

</head>
<body>
<form:form action="task/downFile"  method="post">
	<div id="accordion">
		<h3>配置文件列表</h3>
		<div>
			<div  class="ui-widget-content" >

				<div class="ui-widget-content" style="width: 90%;padding-left: 5%;">
					<div class="ui-widget-header" style="margin-top: 5px;">
						<table width="100%" style="border-left-color: red;border: graytext 1px dotted ;"cellspacing="0" cellpadding="0"  >
							<tr>
								<td width="5%" align="center">&nbsp;</td>
								<td width="35%" >文件名</td>
								<td width="20%">文件长度</td>
								<td width="20%">修改时间</td>
								<td >操作</td>
							</tr>
						</table>
					</div>


						<c:forEach var="file" items="${listfile }" varStatus="index">
							<div class="ui-widget-content">
								<table width="100%" cellspacing="0" cellpadding="0">
									<tr>
										<td width="5%" align="center">
										<c:if test="${file.isDirectory }">
												<span class="ui-icon ui-icon-folder-open"></span>
											</c:if> 
											<c:if test="${ file.isDirectory==false}">
												<span class="ui-icon ui-icon-document"></span>
											</c:if>

										</td>
										<td width="35%">${file.filename }</td>
										<td width="20%">${file.filesize }</td>
										<td width="20%">${file.filedate}</td> 
										<td><span class="p_opra">
											 <input type="checkbox" id="checkbox${index.index }" name="filenames" value="${file.filename }"><label for="checkbox${index.index }"></label>
										</span></td>
									</tr>
								</table>
							</div>
						</c:forEach>





						<!-- ========================================================= -->
					
					
					
					
					
				<div style="height: 10px;">&nbsp;</div>
				</div>
				
			</div>
			<button id="toggle">提交</button>
		</div>
	</div>
</form:form>
</body>
</html>
