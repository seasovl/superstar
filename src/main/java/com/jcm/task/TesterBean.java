package com.jcm.task;

import java.util.List;


public class TesterBean {
	// 是否将参数对象和返回对象转换类型。0 不转换，1 转为xml
	private int allSwitchType;

	// 测试生成类型。0junit 1testng
	private int allTestType;

	private List<ClassBean> classBeans;

	public int getAllSwitchType() {
		return allSwitchType;
	}

	public void setAllSwitchType(int allSwitchType) {
		this.allSwitchType = allSwitchType;
	}

	public int getAllTestType() {
		return allTestType;
	}

	public void setAllTestType(int allTestType) {
		this.allTestType = allTestType;
	}

	public List<ClassBean> getClassBeans() {
		return classBeans;
	}

	public void setClassBeans(List<ClassBean> classBeans) {
		this.classBeans = classBeans;
	}
}
