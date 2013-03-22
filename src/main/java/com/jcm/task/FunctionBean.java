package com.jcm.task;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class FunctionBean {
	@NotNull
	@Size(min=5,max=255)
	private String functionName;
	private int switchType;
	private String paramFilePath;
	private String paramFileParseClass;
	private String paramFileParseFunc;

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public int getSwitchType() {
		return switchType;
	}

	public void setSwitchType(int switchType) {
		this.switchType = switchType;
	}

	public String getParamFilePath() {
		return paramFilePath;
	}

	public void setParamFilePath(String paramFilePath) {
		this.paramFilePath = paramFilePath;
	}

	public String getParamFileParseClass() {
		return paramFileParseClass;
	}

	public void setParamFileParseClass(String paramFileParseClass) {
		this.paramFileParseClass = paramFileParseClass;
	}

	public String getParamFileParseFunc() {
		return paramFileParseFunc;
	}

	public void setParamFileParseFunc(String paramFileParseFunc) {
		this.paramFileParseFunc = paramFileParseFunc;
	}

}
