<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
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
	//tab interface
	
	$(function() {
		var tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>", 
		tabCounter = 2;
		var tabs = $("#tabs").tabs();
  
		function addTab() {
			var index=tabCounter-1;
			var label = "Function " + tabCounter,
			id = "tabs-"+ tabCounter, 
			li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)), 
			tabContentHtml =$("#tabs-"+index).html();
			tabs.find(".ui-tabs-nav").append(li);
			tabContentHtml=tabContentHtml.replace(/funList\[\d\]/g,"funList["+index+"]").replace(/funList\d/g,"funList"+index);
			tabs.append("<div id='" + id + "'>" + tabContentHtml+ "</div>");
			tabs.tabs("refresh");
			tabCounter++;
		}
		// addTab button: just opens the dialog    
	
	$("#add_tab").button({
			icons : {
				primary : "ui-icon-gear"
			}
		}).click(function() {
			addTab();
		});
		// close icon: removing the tab on click    
		$("#tabs span.ui-icon-close").live("click", function() {
			var panelId = $(this).closest("li").remove().attr("aria-controls");
			$("#" + panelId).remove();
			tabs.tabs("refresh");
		});
	});
	
	//class
	$(function() {
		var tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>", 
		tabCounter = 2;
		var tabs = $("#testtabs").tabs();
  
		function addTab() {
			var index=tabCounter-1;
			var label = "Function " + tabCounter,
			id = "testtabs-"+ tabCounter, 
			li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)), 
			tabContentHtml =$("#testtabs-"+index).html();
			tabs.find(".ui-tabs-nav").append(li);
			tabContentHtml=tabContentHtml.replace(/funList\[\d\]/g,"funList["+index+"]").replace(/funList\d/g,"funList"+index);
			tabs.append("<div id='" + id + "'>" + tabContentHtml+ "</div>");
			tabs.tabs("refresh");
			tabCounter++;
		}
		// addTab button: just opens the dialog    
	
	$("#testadd_tab").button({
			icons : {
				primary : "ui-icon-gear"
			}
		}).click(function() {
			addTab();
		});
		// close icon: removing the tab on click    
		$("#testtabs span.ui-icon-close").live("click", function() {
			var panelId = $(this).closest("li").remove().attr("aria-controls");
			$("#" + panelId).remove();
			tabs.tabs("refresh");
		});
	});
	
	
	//jar 
	$(function() {
		var tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>", 
		jarCounter = 2;
		var tabs = $("#jartabs").tabs();
  
		function addJar() {
			var index=jarCounter-1;
			var label = "jar path " + jarCounter,
			id = "jartabs-"+ jarCounter, 
			li = $(tabTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label)), 
			tabContentHtml =$("#jartabs-"+index).html();
			tabs.find(".ui-tabs-nav").append(li);
			tabContentHtml=tabContentHtml.replace(/jarList\[\d\]/g,"jarList["+index+"]").replace(/jarList\d/g,"jarList"+index);
			tabs.append("<div id='" + id + "'>" + tabContentHtml+ "</div>");
			tabs.tabs("refresh");
			jarCounter++;
		}
		// addTab button: just opens the dialog    
	
	$("#add_jar").button({
			icons : {
				primary : "ui-icon-gear"
			}
		}).click(function() {
			addJar();
		});
		// close icon: removing the tab on click    
		$("#testtabs span.ui-icon-close").live("click", function() {
			var panelId = $(this).closest("li").remove().attr("aria-controls");
			$("#" + panelId).remove();
			tabs.tabs("refresh");
		});
	});
</script>
<style>

</style>
</head>
<body>

	<form:form action="task" modelAttribute="taskBean" method="post"  id="task" >

		<div id="accordion">
		<h3>Project Name</h3>
			<div>
				<label>为此添加项目名称:</label><input type="text" name="projectname" title="必须添加一个项目名称">
			</div>
			<h3>配置confpaht</h3>
			<div>
				<form:label for="confpath" path="confpath" cssErrorClass="error">configPaht：</form:label>
				<form:input path="confpath"  title="配置文件路径，如果有多个以英文的逗号隔开"/>
				<form:errors path="confpath" />
			</div>
			<h3 title="jar包说明：优先采用libpath，如果libpath没有配置，则采用ivypath去线上下载">配置jar</h3>
			<div>
				<table>
					<tr>
						<td><form:label for="jar.ivypath" path="jar.ivypath" cssErrorClass="error">配置ivy路径：</form:label></td>
						<td><form:input path="jar.ivypath" title="ivypath:ivy.xml的目录位置和名称(jar名/路径)，通过ant去线上下载" /><form:errors path="jar.ivypath" /></td>
					</tr>
					<tr>
						<td><form:label for="jar.libPath" path="jar.libPath" cssErrorClass="error">配置lib路径：</form:label></td>
						<td><form:input path="jar.libPath"  title="libpath:如果jar包所在的目录(jar名/路径)（前提：jar包已经打入项目jar包或者已经在测试机存在）"/><form:errors path="jar.libPath" /></td>
					</tr>
				</table>
				<div id="cart">
					<div class="ui-widget-header">配置jar路径：</div>
					<div class="ui-widget-content">
						<a id="add_jar"
							title="指定加载的jar包，如果不填写加载所有的jar包(jar包名称，无需带版本号)（选填 ）">add</a>
						<div id="jartabs">
							<ul>
								<li><a href="#jartabs-1">jar path 1</a> <span
									class="ui-icon ui-icon-close">Remove Tab</span></li>
							</ul>
							<div id="jartabs-1">
								<table>
									<tr>
										<td><form:label for="jar.jarList[0]" path="jar.jarList[0]" cssErrorClass="error">配置jar路径：</form:label></td>
										<td><form:input path="jar.jarList[0]" /><form:errors path="jar.jarList[0]" /></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<h3 title="测试接口说明： 用于生成需测试的接口配置">配置测试接口</h3>
			<div>
			<form:label for="testinerface.className" path="testinerface.className"
				cssErrorClass="error">测试接口的完整类名:</form:label>
			<form:input path="testinerface.className" title="需测试的接口名（包名+接口名）" />
			<form:errors path="testinerface.className" /><br/>
				<div id="cart">
					<div class="ui-widget-header">测试接口的方法名:</div>
					<div class="ui-widget-content">
						<a id="add_tab"  title="将配置中的方法生成测试方法，如果不填写将所有public的方法生成测试方法（选填）">add</a>
						<div id="tabs">
							<ul>
								<li>
								<a href="#tabs-1">Function 1</a>
								<span class="ui-icon ui-icon-close">Remove Tab</span>
								</li>
							</ul>
							<div id="tabs-1">
								<table>
									<tr>
										<td><form:label for="testinerface.funList[0].functionName" path="testinerface.funList[0].functionName" cssErrorClass="error">测试接口的方法名:</form:label></td>
										<td><form:input path="testinerface.funList[0].functionName" /><form:errors path="testinerface.funList[0].functionName" /></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<h3 title="测试类说明： 用于生成标记为@Test的测试类">配置测试类</h3>
		    <div>
			<form:label for="testclass.className" path="testclass.className"
				cssErrorClass="error">测试类的完整类名:</form:label>
			<form:input path="testclass.className" title="需测试的测试类名（包名+类名）" />
			<form:errors path="testclass.className" /><br/>
				<div id="cart">
					<div class="ui-widget-header">测试类的方法名:</div>
					<div class="ui-widget-content">
						<a id="testadd_tab"  title="将配置中的方法生成测试方法，如果不填写将所有public的方法生成测试方法（选填）">add</a>
						<div id="testtabs">
							<ul>
								<li>
								<a href="#testtabs-1">Function 1</a>
								<span class="ui-icon ui-icon-close">Remove Tab</span>
								</li>
							</ul>
							<div id="testtabs-1">
								<table>
									<tr>
										<td><form:label for="testclass.funList[0].functionName" path="testclass.funList[0].functionName" cssErrorClass="error">测试类的方法名:</form:label></td>
										<td><form:input path="testclass.funList[0].functionName" /><form:errors path="testclass.funList[0].functionName" /></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<h3>添加此项目的元数据</h3>
			<div>
				<table width="80%" border="0" align="center" cellspacing="0" cellpadding="0">
					<tr >
						<td width="30%"  align="right"> <label>组名:</label></td>
						<td><input type="text" name="org"  ></td>
					</tr>
					<tr >
						<td align="right"><label>项目名:</label></td>
						<td><input type="text" name="name"  ></td>
					</tr>
					<tr >
						<td align="right"><label>版本:</label></td>
						<td><input type="text" name="rev" ></td>
					</tr>
				</table>
			</div>
		</div>

		<button id="toggle">提交</button>
</form:form>
</body>
</html>
