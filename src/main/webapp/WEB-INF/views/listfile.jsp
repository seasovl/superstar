<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	$(".update").button({
        icons: {
            primary: "ui-icon-refresh"
        },text: false});
	$(".del").button({
        icons: {
            primary: "ui-icon-cancel"
        },text: false}).click(function(){
        	var answer = confirm("  是否删除?  ")
        	if(answer)
        		window.location.href ="file/delfile?filepath="+$(this).attr("title");
        });
	$(".cat").button({
        icons: {
            primary: "ui-icon-newwin"
        },text: false}).click(function (data){
        	window.location.href ="file/listfile?filepath="+$(this).attr("title");
        });
	$("#update").button({
        icons: {
            primary: "ui-icon-refresh"
        },text: false}).click(function (data){
        	var answer = confirm("  是否跟新?  ")
        	if(answer)
        	{
        		$("#filepath").val($(this).attr("title"));
        		$("#updateform").submit();
        	}
        });
    $( "#resizable" ).resizable({
        animate: true
    });
});
</script>
<style>
.p_opra {
	font-size: 13px;
	text-align: center;
}

.update {
	width: 40px;
}

.del {
	width: 40px;
}

.cat {
	width: 40px;
	margin-left: -9px;
}


</style>

</head>
<body>
	<div id="accordion">
		<h3>项目文件列表</h3>
		<div>
			<div  class="ui-widget-content" >

				<div class="ui-widget-content" style="width: 90%;padding-left: 5%;">
					<div class="ui-widget-header" style="margin-top: 5px;">
						<table width="100%" style="border-left-color: red;border: graytext 1px dotted ;"cellspacing="0" cellpadding="0" >
							<tr>
								<td width="5%" align="center">&nbsp;</td>
								<td width="35%" >文件名</td>
								<td width="20%">文件长度</td>
								<td width="20%">修改时间</td>
								<td style="padding-left: 15px;">操作</td>
							</tr>
						</table>
					</div>
					<div class="ui-widget-content">
						<table width="100%"cellspacing="0" cellpadding="0">
							<tr>
								<td width="5%" align="center"><span  class="ui-icon ui-icon-folder-open"></span></td>
								<td width="35%">	<a href="file/listfile?filepath=${path}">..</a></td>
								<td width="20%">&nbsp;</td>
								<td width="20%">&nbsp;</td>
								<td >&nbsp;</td>
							</tr>
						</table>
					</div>
					
					
					
					<c:forEach items="${listfile }" var="file" varStatus="index" >
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
									<td width="20%">${file.filedate }</td>
									<td >
									<c:if test="${showtext}">
									<span class="p_opra"> <span class="update"  id="update"  title="${file.filepath }" >修改</span></span>
									</c:if>
									<c:if test="${showtext==false }">
									<span class="p_opra"><span class="del" title="${file.filepath }">删除</span></span>
									<span class="p_opra"><span class="cat" title="${file.filepath }">查看</span></span>
									</c:if>
									</td>
								</tr>
							</table>
						</div>
					</c:forEach>
					<c:if test="${showtext }">
						<div class="ui-widget-content" style=" width: 99%;">
							<form action="file/updatefile" method="post"  id="updateform">
								<input type="hidden"  name="filepath" id="filepath">
								<textarea id="resizable" rows="20"  cols="95%"  style="background-color: #bbbbbb; width: 100%; border: 0px;"name="text">${text }</textarea>
							</form>
						</div>
					</c:if>
						<!-- ========================================================= -->
					
					
					
					
					
				<div style="height: 10px;">&nbsp;</div>
				</div>
				
			</div>
			
		</div>
	</div>
</body>
</html>
