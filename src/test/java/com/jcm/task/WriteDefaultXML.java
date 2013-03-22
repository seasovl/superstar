package com.jcm.task;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import com.ztools.xml.XMLWriter;


public class WriteDefaultXML {
	private String xmlName="./app_test_task.xml";
	private String xmlName1="./app_test_pro.xml";
	
	@Test
	public void aa(){
		TaskBean taskBean=new TaskBean();
		
		JarBean jarBean=new JarBean();
		jarBean.setIvypath("ivypath");
		jarBean.setLibPath("libPath");
		List<String> list=new ArrayList<String>();
		list.add("./lib/feed.jar");
		list.add("./lib/monitor.jar");
		jarBean.setJarList(list);
		taskBean.setJar(jarBean);
		
		taskBean.setConfpath("confpath");
		
		ClassBean classBean=new ClassBean();
		FunctionBean funBean=new FunctionBean();
		funBean.setFunctionName("functionName");

		List<FunctionBean> funList=new ArrayList<FunctionBean>();
		funList.add(funBean);
		classBean.setClassName("package.className");

		classBean.setFunList(funList);

		taskBean.setTestclass(classBean);
		
		ClassBean classBean1=new ClassBean();
		FunctionBean funBean1=new FunctionBean();
		funBean1.setFunctionName("functionName");

		List<FunctionBean> funList1=new ArrayList<FunctionBean>();
		funList1.add(funBean1);
		
		classBean1.setClassName("package.className");

		classBean1.setFunList(funList1);

		taskBean.setTestinerface(classBean1);
		
		try {
			XMLWriter.writeObjectToXmlFile(taskBean, xmlName);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void bb(){
		
		
		ClassBean classBean=new ClassBean();
		classBean.setClassName("newlink.test.rmi.Test111");
		List<FunctionBean> listFunctionBeans=new ArrayList<FunctionBean>();
		FunctionBean functionBean=new FunctionBean();
		functionBean.setFunctionName("writeXML");
		functionBean.setParamFileParseClass("org.databene.feed4testng.FeedTest");
		functionBean.setParamFilePath("test0.xls");
		functionBean.setParamFileParseFunc("feeder");
		
		FunctionBean functionBean1=new FunctionBean();
		functionBean1.setFunctionName("aaa");
		functionBean1.setParamFileParseClass("org.databene.feed4testng.FeedTest");
		functionBean1.setParamFilePath("test1.xls");
		functionBean1.setParamFileParseFunc("feeder");
		
		FunctionBean functionBean2=new FunctionBean();
		functionBean2.setFunctionName("aaa");
		functionBean2.setParamFileParseClass("org.databene.feed4testng.FeedTest");
		functionBean2.setParamFilePath("test2.xls");
		functionBean2.setParamFileParseFunc("feeder");
		
		listFunctionBeans.add(functionBean);
		listFunctionBeans.add(functionBean1);
		listFunctionBeans.add(functionBean2);
		
		classBean.setFunList(listFunctionBeans);
		
		List<ClassBean> classBeans=new ArrayList<ClassBean>();
		classBeans.add(classBean);
		TesterBean testerBean=new TesterBean();
		testerBean.setAllSwitchType(1);
		testerBean.setAllTestType(1);
		testerBean.setClassBeans(classBeans);
		
		try {
			XMLWriter.writeObjectToXmlFile(testerBean, xmlName1);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
