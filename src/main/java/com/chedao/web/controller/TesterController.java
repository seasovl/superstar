package com.chedao.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import javax.validation.Valid;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.Target;
import org.apache.tools.ant.taskdefs.Zip;
import org.apache.tools.ant.types.FileList;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.ZipFileSet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jcm.task.ClassBean;
import com.jcm.task.FunctionBean;
import com.jcm.task.TesterBean;
import com.ztools.xml.XMLWriter;


@Controller
@RequestMapping(value="/tester")
public class TesterController {
	private String testxmlName="app_test_pro.xml";
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getTaskForm(Model model) {
		model.addAttribute(new TesterBean());
		return new ModelAndView( "test");
	}
	protected static void valiFunction(List<FunctionBean> functions)
	{
		for(FunctionBean fb:functions){
			if(fb.getFunctionName()!=null && fb.getFunctionName().trim().equals(""))
			{
				fb.setFunctionName(null);
			}
			if(fb.getParamFileParseClass()!=null && fb.getParamFileParseClass().trim().equals(""))
			{
				fb.setParamFileParseClass(null);
			}
			if(fb.getParamFileParseFunc()!=null && fb.getParamFileParseFunc().trim().equals(""))
			{
				fb.setParamFileParseFunc(null);
			}
			if(fb.getParamFilePath()!=null && fb.getParamFilePath().trim().equals(""))
			{
				fb.setParamFilePath(null);
			}
		}
	}
	public static File fileZip(File direct ,List<String> include,List<String> exclude)
	{
		try {
			Zip zip=new Zip();
			zip.setEncoding("gbk");
			zip.setDestFile(new File(direct.getAbsolutePath()+"/"+direct.getName()+".zip."+new Date().getTime()));
			zip.setBasedir(direct);
			for(String in: include)
			{
				zip.setIncludes(in);
			}
			for(String ex: exclude)
			{
				//ex=new String(ex.getBytes("utf-8"),"gbk");
				zip.setExcludes(ex);
			}

			Target target=new Target();
			target.setName("zip");
			target.addTask(zip);
			Project project=new Project();
			project.setBaseDir(direct);
			zip.setProject(project);
			project.addTarget(target);
			target.execute();
			return zip.getDestFile();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView createTaskForm(@Valid TesterBean testerBean, BindingResult result,Model model) {
		if (result.hasErrors()) {
			return new ModelAndView( "development");
		}
		try {
			for(ClassBean bc : testerBean.getClassBeans())
			{
				if(bc.getClassName().trim().equals(""))
				{
					bc.setClassName(null);
				}
				valiFunction(bc.getFunList());
			}
			Properties conf=new Properties();
			conf.load(this.getClass().getResourceAsStream("/conf.properties"));
			String confpath=conf.getProperty("save_path");
			String path=this.getClass().getResource("").getPath();
			String str=""+new Date().getTime();//时间戳
			path=path.substring(0,path.indexOf("WEB-INF"));
			path+="resources/xmlData/";
			path+=testxmlName;
			path+=("."+str);
			confpath+=("/"+testxmlName);
			model.addAttribute("filename",testxmlName+"."+str);
			XMLWriter.writeObjectToXmlFile(testerBean, path);
			XMLWriter.writeObjectToXmlFile(testerBean, confpath);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView( "success");
	}
}
