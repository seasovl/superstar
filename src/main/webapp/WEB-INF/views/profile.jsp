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
//模块
	$(function() {
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
	});
	//title
	$(function() {
		$(document).tooltip(
				{
					position : {
						my : "center bottom-20",
						at : "center top",
						using : function(position, feedback) {
							$(this).css(position);
							$("<div>").addClass("arrow").addClass(
									feedback.vertical).addClass(
									feedback.horizontal).appendTo(this);
						}
					}
				});
	});
</script>
<style>

</style>
</head>
<body>

	<form:form action="file/profile"  method="post"  modelAttribute="profile" id="task" >

		<div id="accordion">
		<h3>配置文件修改</h3>
			<div>
				<table width="80%" border="0" align="center" cellspacing="0" cellpadding="0">
					<tr align="right">
						<td width="30%" > <form:label for="savepath" path="savepath" cssErrorClass="error">保存的文件路径:</form:label></td>
						<td><form:input path="savepath"  size="70%"/> <form:errors path="savepath" /></td>
					</tr>
					<tr align="right">
						<td align="right"><form:label for="getpath" path="getpath" cssErrorClass="error">下载的文件路径:</form:label></td>
						<td><form:input path="getpath" size="70%" /> <form:errors path="getpath" /></td>
					</tr>
					<tr align="right">
						<td align="right"><form:label for="ivypath" path="ivypath" cssErrorClass="error">ivy的文件路径:</form:label></td>
						<td><form:input path="ivypath"  size="70%" /><form:errors path="ivypath" /></td>
					</tr>
				</table>
				
			</div>

		</div>

		<button id="toggle">保存修改</button>
</form:form>
</body>
</html>
