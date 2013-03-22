<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
			<link rel="stylesheet" href="resources/css/dot-luv/jquery-ui.css" />
			<script src="resources/jquery-1.8.3.js"></script>
			<script src="resources/jquery-ui-1.9.1.custom.js"></script>
<script>
	$(function() {
		$("#download").button().click(function(event) {
			event.preventDefault();
			window.location.href ="task/download?filename=${filename}";
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
	<table width="100%" height="310">
		<tr align="center" >
			<td align="center" >
				<div>
					<div class="ui-widget-content"
						style="text-align: center; width: 50%; height: 300px; margin-top: 5em;">
						<h1 class="ui-state-active">bean转xml 生成工具</h1>
						<div style="padding-top: 3em;">
							<table border="0" width="100%">
								<tr>
									<td><a href="#" id="download">下载生成的xml</a></td>
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
