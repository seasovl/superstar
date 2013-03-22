package com.jcm.task;

import java.util.List;

public class JarBean {
	private String libPath;
	private List<String> jarList;

	// ivy路径
	private String ivypath;

	public String getIvypath() {
		return ivypath;
	}

	public void setIvypath(String ivypath) {
		this.ivypath = ivypath;
	}

	public String getLibPath() {
		return libPath;
	}

	public void setLibPath(String libPath) {
		this.libPath = libPath;
	}

	public List<String> getJarList() {
		return jarList;
	}

	public void setJarList(List<String> jarList) {
		this.jarList = jarList;
	}

}
