package com.chedao.web.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.tools.ant.util.DOMElementWriter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import com.chedao.web.bean.FileBean;
import com.chedao.web.bean.ProFileBean;

@Controller
@RequestMapping(value="/file")
public class FileController {
	@RequestMapping(value="/listfile")
	public ModelAndView listFile(String filepath,HttpServletResponse response,Model model) throws IOException{
		if(filepath==null	)
			filepath="";
		Properties conf = new Properties();
		conf.load(this.getClass().getResourceAsStream("/conf.properties"));
		String root = conf.getProperty("save_path")+"/";
		File file=new File(root+filepath);
		List<FileBean> listfile = fileList(root,root+filepath);
		model.addAttribute("listfile", listfile);
		model.addAttribute("path", filepath.lastIndexOf("/") < 0 ?"/":filepath.substring(0, filepath.lastIndexOf("/")));
		model.addAttribute("showtext", false);
		if (! file.isDirectory()) {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			Document doc=null;
			try {
				DocumentBuilder builder = factory.newDocumentBuilder();
				doc = builder.parse(file);
			} catch (ParserConfigurationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SAXException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Writer writer=new StringWriter();
			 DOMElementWriter docwriter=new DOMElementWriter();
			 docwriter.write( doc.getDocumentElement(),writer,0," ");
			model.addAttribute("showtext", true);
			model.addAttribute("text", writer.toString());
			 writer.flush();
			 writer.close();
		}
		return new ModelAndView("listfile");
	}
	
	@RequestMapping(value="/profile")
	public ModelAndView proFile(  ProFileBean profile, HttpServletResponse response,Model model ) throws IOException{

		if(profile.getGetpath()==null||profile.getGetpath()==null||profile.getIvypath()==null)
		{
			Properties conf = new Properties();
			conf.load(this.getClass().getResourceAsStream("/conf.properties"));
			String savepath = conf.getProperty("save_path");
			String getpath = conf.getProperty("getfile_path");
			String ivypath = conf.getProperty("ivy_path");
			profile=new ProFileBean();
			profile.setSavepath(savepath);
			profile.setGetpath(getpath);
			profile.setIvypath(ivypath);
			model.addAttribute("profile",profile);
			return new ModelAndView("profile");
		}else{
			Properties conf = new Properties();
			conf.load(this.getClass().getResourceAsStream("/conf.properties"));
			conf.setProperty("save_path", profile.getSavepath());
			conf.setProperty("getfile_path", profile.getGetpath());
			conf.setProperty("ivy_path", profile.getIvypath());
			Writer writer=new FileWriter(this.getClass().getResource("/conf.properties").getPath());
			conf.store(writer, "");
			writer.close();
			return new ModelAndView("home");
		}

	}

	//文件修改
	@RequestMapping(value="/updatefile")
	public ModelAndView updatefile(String filepath,String text,HttpServletResponse response,Model model) throws IOException{
			if(filepath==null	)
				filepath="";
			Properties conf = new Properties();
			conf.load(this.getClass().getResourceAsStream("/conf.properties"));
			String root = conf.getProperty("save_path")+"/";
			File file=new File(root+filepath);
			FileWriter fileWriter=new FileWriter(file);
			fileWriter.write(text);
			fileWriter.close();
		 return listFile(filepath,response,model);
	}
	@RequestMapping(value="/delfile")
	public ModelAndView delFile(String filepath,HttpServletResponse response,Model model) throws IOException{
		if(filepath==null	)
			filepath="";
		Properties conf = new Properties();
		conf.load(this.getClass().getResourceAsStream("/conf.properties"));
		String root = conf.getProperty("save_path")+"/";
		File file=new File(root+filepath);
		root=new File(root).getPath();
		String path=file.getParent();
		deletefiles(file);
		path=path.substring(path.indexOf(root)+root.length());
		return listFile(path, response, model);
	}


	protected void deletefiles(File file)
	{
		if(file.isDirectory())
		{
			for(File f : file.listFiles())
			{
				deletefiles(f);
			}
		}
		file.delete();
	}
	@RequestMapping(value="/listdownfile")
	public ModelAndView downFile(HttpServletResponse response,Model model) throws IOException{
		Properties conf=new Properties();
		 conf.load(this.getClass().getResourceAsStream("/conf.properties"));
		 String root=conf.getProperty("save_path");
		 List<FileBean>listfile= fileList(root,root);
		model.addAttribute("listfile", listfile);
		return new ModelAndView("downfile");
	}
	/**
	 * 
	 * @param path
	 * @return
	 */
	protected List<FileBean> fileList(String root,String path) {
		List<FileBean>listfile=new ArrayList<FileBean>();
		File file=new File(path);
		String prix="";
		if(path.indexOf(root)>=0)
		{
			prix=path.substring(path.indexOf(root)+root.length())+"/";
		}
		if(file.isDirectory())
		{
			File[] fileset=file.listFiles();
			for(File f: fileset)
			{
				FileBean fb=new FileBean();
				fb.setFilename(f.getName());
				fb.setFiledate(f.lastModified());
				fb.setFilepath(prix+f.getName());
				long size=f.length();
				fb.setIsDirectory(f.isDirectory()?true : false);
				Double db=new Double(size/1027.0);
				DecimalFormat df = new DecimalFormat("#0.00");
				fb.setFilesize(fb.getIsDirectory()?"":(df.format(db)+"KB"));
				listfile.add(fb);
			}
		}else{
			FileBean fb=new FileBean();
			fb.setFilename(file.getName());
			fb.setFiledate(file.lastModified());
			fb.setFilepath(prix);
			fb.setIsDirectory(false);
			long size=file.length();
			Double db=new Double(size/1027.0);
			DecimalFormat df = new DecimalFormat("#0.00");
			fb.setFilesize(fb.getIsDirectory()?"":(df.format(db)+"KB"));
			listfile.add(fb);
		}
		return listfile;
	}
}
