<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<script>
	$(function() {
		$("#tester").button().click(function(event) {
			event.preventDefault();
			window.location.href = "tester";
		});
		$("#task").button().click(function(event) {
			event.preventDefault();
			window.location.href = "task";
		});
		$("#downFile").button().click(function(event) {
			event.preventDefault();
			window.location.href = "file/listdownfile";
		});
		$("#startServer").button().click(function(event) {
			event.preventDefault();
			window.location.href = "startServer";
		});
		$("#profile").button().click(function(event) {
			event.preventDefault();
			window.location.href = "file/profile";
		});
		$("#listfile").button().click(function(event) {
			event.preventDefault();
			window.location.href = "file/listfile";
		});
	});
</script>
<style type="text/css">
        	body{
        			text-align: center;
        			background-color: #696969;
        	}

        </style>
    </head>
<body>
	<table width="100%" height="380">
		<tr align="center" >
			<td align="center" >
				<div>
					<div class="ui-widget-content"
						style="text-align: center; width: 50%; height: 370px; margin-top: 5em;">
						<h1 class="ui-state-active">bean转xml 生成工具</h1>
						<div style="padding-top: 3em;">
							<table border="0" width="100%">
								<tr>
									<td><a href="#" id="tester">测试人员入口</a></td>
									<td><a href="#" id="downFile">测试文件下载</a></td>
								</tr>
								<tr>
									<td><a href="#" id="task">开发人员入口</a></td>
									<td><a href="#" id="startServer">服务启动程序</a></td>
								</tr>
								<tr>
									<td><a href="#" id="profile">配置文件修改</a></td>
									<td><a href="#" id="listfile">测试文件列表</a></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>

</body>
</html>
