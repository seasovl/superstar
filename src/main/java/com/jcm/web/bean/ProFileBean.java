package com.jcm.web.bean;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class ProFileBean {
	@NotNull
	@Size(min=5)
	private String savepath;
	@NotNull
	@Size(min=5)
	private String getpath;
	@NotNull
	@Size(min=5)
	private String ivypath;
	public String getSavepath() {
		return savepath;
	}
	public void setSavepath(String savepath) {
		this.savepath = savepath;
	}
	public String getGetpath() {
		return getpath;
	}
	public void setGetpath(String getpath) {
		this.getpath = getpath;
	}
	public String getIvypath() {
		return ivypath;
	}
	public void setIvypath(String ivypath) {
		this.ivypath = ivypath;
	}
	
}
