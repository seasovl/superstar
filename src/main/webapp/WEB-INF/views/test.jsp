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
	    var  classCounter = 1;//记录当前类的数量
		var funArray="1";//记录单前类总的函数数量   下标 跟第几个类对应  比如  '13'   第二个类有3个方法
		var funTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close'>Remove Tab</span></li>";
	$(function() {
		var tabs = $("#temp-0").tabs();
		function addTab() {
			var hiddle=$("#hiddle").html();
			hiddle=hiddle.replace(/\{cin\}/g,classCounter).replace(/classBeans\[\d\]/g, "classBeans[" + classCounter + "]").replace(/classBeans\d/g, "classBeans" + classCounter);
			$("#parent").append(hiddle);//把新类添加进来
			addtablsFun(classCounter);//设置funadd_tab  funtab 应用
			funArray+="1";
			classCounter++;
		}
		// addTab button: just opens the dialog    
	
	$("#add_tab").button({
			icons : {
				primary : "ui-icon-gear"
			}
		}).click(function() {
			addTab();
		});

	/* 		// close icon: removing the tab on click    
		 $("#tabs span.ui-icon-close").live("click", function() {
		 var panelId = $(this).closest("li").remove().attr("aria-controls");
		 $("#" + panelId).remove();
		 tabs.tabs("refresh");
		 }); */
	});

	//function
		// addTab button: just opens the dialog    
	$(function() {
		$("#funadd_tab-0").button().click(function(data) {
		//	alert(data);
			addFunction(0);
		});
		// close icon: removing the tab on click    
		$("#funtabs-0 span.ui-icon-close").live("click", function() {
			var panelId = $(this).closest("li").remove().attr("aria-controls");
			$("#" + panelId).remove();
			funtabs.tabs("refresh");
		});
	});



		function addFunction(index) {
			var funtabs = $("#funtabs-"+index).tabs();
			var ind = parseInt(funArray.charAt(index));
			//alert(ind);
			var label = "Function " + ind, 
			id = "funtabs-" + index+"-" +ind,
			li = $(funTemplate.replace(/#\{href\}/g, "#" + id).replace(/#\{label\}/g,label)),
		    tabContentHtml = $("#funtabs-" +index+"-"+ (ind-1)).html();
			funtabs.find(".ui-tabs-nav").append(li);
			tabContentHtml = tabContentHtml.replace(/funList\[\d\]/g, "funList[" + ind + "]").replace(/funList\d/g, "funList" + ind);
			funtabs.append("<div id='" + id + "'>" + tabContentHtml + "</div>");
			funtabs.tabs("refresh");
			ind++;
			//重新设置数组
			var pre=funArray.substring(0,index);
			var fix=funArray.substring(index+1);
			funArray=pre+ind+fix;
			//alert(funArray);
		}

</script>
<script type="text/javascript">
	

	/* 将 funadd_tab  funtab 应用*/

	function addtablsFun(index) {
		$("#funtabs-" + index).tabs();
		$("#funadd_tab-" + index).button().click(function(data) {
			addFunction(index);
		});
		$("#funtabs-"+index+" span.ui-icon-close").live("click", function() {
			var panelId = $(this).closest("li").remove().attr("aria-controls");
			$("#" + panelId).remove();
			funtabs.tabs("refresh");
		});
	}
	function hiddleinput()
	{
		var inputs=$("#hiddle input").each(function(){
			$(this).attr("disabled",true);
		});
		return true;
	}
</script>
<style>

</style>
</head>
<body>

	<form:form action="tester" modelAttribute="testerBean" method="post"  id="task"  onsubmit="return hiddleinput();">

		<div id="accordion">

			<h3 title="选择你需要测试的类型">配置测试项</h3>
			<div>
				<table>
					<tr>
						<td><form:label for="allTestType" path="allTestType" cssErrorClass="error">测试类型：</form:label></td>
						<td><form:radiobutton path="allTestType" value="0"/>junit &nbsp;</td>
						<td><form:radiobutton path="allTestType" value="1"/>testng</td>
						<td><form:errors path="allTestType" /></td>
					</tr>
					<tr>
						<td><form:label for="allSwitchType" path="allSwitchType" cssErrorClass="error">转换类型：</form:label></td>
						<td><form:radiobutton path="allSwitchType" value="0"/>no &nbsp;</td>
						<td><form:radiobutton path="allSwitchType" value="1"/>xml</td>
						<td> <form:errors path="allSwitchType" /></td>
					</tr>
				</table>
			</div>
			<h3 title="测试接口/类说明： 用于生成需测试的接口/类配置">配置测试接口/类</h3>
			<div>
				<div id="cart">
					<h3 class="ui-widget-header" style="height: 35px;padding: 3px;">测试接口/类列表:</h3>
					<div class="ui-widget-content"  id="parent">
<!-- ============================================================================= -->
						<div id="temp-0">
						<p class="ui-state-active">ClassBean 0</p>
						<p style="margin-left: 1em;">
							<form:label for="classBeans[0].className"
								path="classBeans[0].className" cssErrorClass="error">测试接口/类的完整类名:</form:label>
							<form:input path="classBeans[0].className"
								title="需测试的测试类名（包名+类名）" />
							<form:errors path="classBeans[0].className" />
							</p>
							<div class="ui-widget-header">测试接口/类的方法名:</div>
									<div class="ui-widget-content">
										<div style="width: 200px; font-size: 15px;text-align: center;margin: 1em;">
											<a id="funadd_tab-0"  title="将配置中的方法生成测试方法，如果不填写将所有public的方法生成测试方法（选填）" >添加一个方法</a>
										</div>
										
										<div id="funtabs-0">
											<ul>
												<li><a href="#funtabs-0-0">Function 0</a> <span
													class="ui-icon ui-icon-close">Remove Tab</span></li>
											</ul>
											<div id="funtabs-0-0">
												<table>
													<tr>
														<td><form:label
																for="classBeans[0].funList[0].functionName"
																path="classBeans[0].funList[0].functionName"
																cssErrorClass="error">测试类的方法名:</form:label></td>
														<td><form:input
																path="classBeans[0].funList[0].functionName" />
															<form:errors path="classBeans[0].funList[0].functionName" /></td>
														<td><form:label
																for="classBeans[0].funList[0].paramFilePath"
																path="classBeans[0].funList[0].paramFilePath"
																cssErrorClass="error">传参的文件路径:</form:label></td>
														<td><form:input
																path="classBeans[0].funList[0].paramFilePath" /> <form:errors
																path="classBeans[0].funList[0].paramFilePath" /></td>
													</tr>
													<tr>
														<td><form:label
																for="classBeans[0].funList[0].paramFileParseClass"
																path="classBeans[0].funList[0].paramFileParseClass"
																cssErrorClass="error">传入参数文件的类:</form:label></td>
														<td><form:input
																path="classBeans[0].funList[0].paramFileParseClass" /> <form:errors
																path="classBeans[0].funList[0].paramFileParseClass" /></td>
														<td><form:label
																for="classBeans[0].funList[0].paramFileParseFunc"
																path="classBeans[0].funList[0].paramFileParseFunc"
																cssErrorClass="error">传入参数文件方法:</form:label></td>
														<td><form:input
																path="classBeans[0].funList[0].paramFileParseFunc" /> <form:errors
																path="classBeans[0].funList[0].paramFileParseFunc" /></td>
													</tr>
												</table>
											</div>
										</div>
									</div>
								</div>  
								<p class="ui-widget-content"></p>
						
						
						
					</div>
				</div>



					<div id="hiddle" style="display: none;">
					<div id="temp-{cin}">
					<p class="ui-state-active">ClassBean {cin}</p>
						<p style="margin-left: 1em;">
							<form:label for="classBeans[0].className"
								path="classBeans[0].className" cssErrorClass="error">测试接口/类的完整类名:</form:label>
							<form:input path="classBeans[0].className"
								title="需测试的测试类名（包名+类名）" />
							<form:errors path="classBeans[0].className" />
						</p>
						<div class="ui-widget-header">测试接口/类的方法名:</div>
						<div class="ui-widget-content">
							<div
								style="width: 200px; font-size: 15px; text-align: center; margin: 1em;">
								<a id="funadd_tab-{cin}"
									title="将配置中的方法生成测试方法，如果不填写将所有public的方法生成测试方法（选填）">添加一个方法</a>
							</div>
							<div id="funtabs-{cin}">
								<ul>
									<li><a href="#funtabs-{cin}-0">Function 0</a> <span class="ui-icon ui-icon-close">Remove Tab</span></li>
								</ul>
								<div id="funtabs-{cin}-0" >
									<table>
										<tr>
											<td><form:label
													for="classBeans[0].funList[0].functionName"
													path="classBeans[0].funList[0].functionName"
													cssErrorClass="error">测试类的方法名:</form:label></td>
											<td><form:input
													path="classBeans[0].funList[0].functionName" /> <form:errors
													path="classBeans[0].funList[0].functionName" /></td>
											<td><form:label
													for="classBeans[0].funList[0].paramFilePath"
													path="classBeans[0].funList[0].paramFilePath"
													cssErrorClass="error">传参的文件路径:</form:label></td>
											<td><form:input
													path="classBeans[0].funList[0].paramFilePath" /> <form:errors
													path="classBeans[0].funList[0].paramFilePath" /></td>
										</tr>
										<tr>
											<td><form:label
													for="classBeans[0].funList[0].paramFileParseClass"
													path="classBeans[0].funList[0].paramFileParseClass"
													cssErrorClass="error">传入参数文件的类:</form:label></td>
											<td><form:input
													path="classBeans[0].funList[0].paramFileParseClass" /> <form:errors
													path="classBeans[0].funList[0].paramFileParseClass" /></td>
											<td><form:label
													for="classBeans[0].funList[0].paramFileParseFunc"
													path="classBeans[0].funList[0].paramFileParseFunc"
													cssErrorClass="error">传入参数文件方法:</form:label></td>
											<td><form:input
													path="classBeans[0].funList[0].paramFileParseFunc" /> <form:errors
													path="classBeans[0].funList[0].paramFileParseFunc" /></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<p class="ui-widget-content" ></p>
				</div>

				<a id="add_tab"  title="添加所需生成的测试类" style="margin-top: 1em;float: right; margin-right: 4em; ">添加一个类</a>
			</div>
			
		</div>
		<button id="toggle" >提交</button>
</form:form>
</body>
</html>
