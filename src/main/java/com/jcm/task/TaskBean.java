package com.jcm.task;

import org.junit.Test;


public class TaskBean {
	// 配置文件路径
	private String confpath;
	// jar包路径
	private JarBean jar;
	
	// 需要测试的接口
	private ClassBean testinerface;
	// 需要测试的类
	private ClassBean testclass;

	public String getConfpath() {
		return confpath;
	}

	public void setConfpath(String confpath) {
		this.confpath = confpath;
	}

	public JarBean getJar() {
		return jar;
	}

	public void setJar(JarBean jar) {
		this.jar = jar;
	}

	public ClassBean getTestinerface() {
		return testinerface;
	}

	public void setTestinerface(ClassBean testinerface) {
		this.testinerface = testinerface;
	}

	public ClassBean getTestclass() {
		return testclass;
	}

	public void setTestclass(ClassBean testclass) {
		this.testclass = testclass;
	}

	@Test
	public void re(){
		String str="testinerface.funList[0].functionName";
		str=str.replaceAll("(?<=funList\\[)\\d+(?=\\])", "3");
		System.out.println(str);
	}
}
