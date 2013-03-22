package com.jcm.task;

import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class ClassBean {
	// 是否将参数对象和返回对象转换类型。0 不转换，1 转为xml
	private int allSwitchType;

	// 测试生成类型。0junit 1testng
	private int allTestType;

	public int getAllTestType() {
		return allTestType;
	}

	public void setAllTestType(int allTestType) {
		this.allTestType = allTestType;
	}
	@NotNull
	@Size(min=5,max=255)
	private String ClassName;
	private List<FunctionBean> funList;

	// 构造函数
	// private String Constructor

	public int getAllSwitchType() {
		return allSwitchType;
	}

	public void setAllSwitchType(int allSwitchType) {
		this.allSwitchType = allSwitchType;
	}

	public String getClassName() {
		return ClassName;
	}

	public void setClassName(String className) {
		ClassName = className;
	}

	public List<FunctionBean> getFunList() {
		return funList;
	}

	public void setFunList(List<FunctionBean> funList) {
		this.funList = funList;
	}

}
