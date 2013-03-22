package com.chedao.web.bean;

import java.text.SimpleDateFormat;
import java.util.Date;


public class FileBean {
 private String filename;
 private String filesize;
 private String filepath;
 private String filedate;
private Boolean isDirectory;
private static SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
public String getFilename() {
	return filename;
}
public void setFilename(String filename) {
	this.filename = filename;
}
public String getFilesize() {
	return filesize;
}
public void setFilesize(String filesize) {
	this.filesize = filesize;
}
public String getFilepath() {
	return filepath;
}
public void setFilepath(String filepath) {
	this.filepath = filepath;
}
public String getFiledate() {
	return filedate;
}
public void setFiledate(String filedate) {
	this.filedate = filedate;
}
public Boolean getIsDirectory() {
	return isDirectory;
}
public void setIsDirectory(Boolean isDirectory) {
	this.isDirectory = isDirectory;
}
public void setFiledate(long lastModified) {
	this.filedate=format.format(new Date(lastModified));
	
}

}
