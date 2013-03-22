package com.chedao.web.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.tools.ant.util.DOMElementWriter;
import org.apache.tools.zip.ZipFile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

import com.jcm.task.TaskBean;
import com.ztools.xml.XMLWriter;

@Controller
@RequestMapping(value="/task")
public class TaskController {
	private String taskxmlName="app_test_task.xml";
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView getTaskForm(Model model) {
		model.addAttribute(new TaskBean());
		return new ModelAndView( "development");
	}
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView createTaskForm(TaskBean taskBean,String projectname, BindingResult result,Model model) {
		if (result.hasErrors()) {
			return new ModelAndView( "development");
		}
		try {
			if(taskBean.getConfpath().trim().equals("")){
				taskBean.setConfpath(null);
			}
			if(taskBean.getTestclass().getClassName().trim().equals(""))
			{
				taskBean.getTestclass().setClassName(null);
			}
			if(taskBean.getTestinerface().getClassName().trim().equals(""))
			{
				taskBean.getTestinerface().setClassName(null);
			}
			TesterController.valiFunction(taskBean.getTestclass().getFunList());
			TesterController.valiFunction(taskBean.getTestinerface().getFunList());
			if(taskBean.getJar().getIvypath().trim().equals(""))
			{
				taskBean.getJar().setIvypath(null);
			}
			if(taskBean.getJar().getLibPath().trim().equals(""))
			{
				taskBean.getJar().setLibPath(null);
			}
			if(taskBean.getJar().getJarList().size()<=0)
			{
				taskBean.getJar().setJarList(null);
			}
			Properties conf=new Properties();
			conf.load(this.getClass().getResourceAsStream("/conf.properties"));
			String confpath=conf.getProperty("save_path");
			 String path=this.getClass().getResource("").getPath();
			String str = "" + new Date().getTime();// 时间戳
			 path=path.substring(0,path.indexOf("WEB-INF"));
			 path+="resources/xmlData/";
			 path += taskxmlName; 
			 path+=("."+str);

		//	 配置固定保存的路径
			confpath += ("/" + projectname + "/" + taskxmlName);
			model.addAttribute("filename", taskxmlName + "." + str);
			 XMLWriter.writeObjectToXmlFile(taskBean, path);
			XMLWriter.writeObjectToXmlFile(taskBean, confpath);
			 saveMetadata(confpath.substring(0, confpath.indexOf(taskxmlName))+ "/ivy.metadata" );
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new ModelAndView( "success");
	}
	private void  saveMetadata(String path) throws IOException
	{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String org=request.getParameter("org");
		String name = request.getParameter("name");
		String rev = request.getParameter("rev");
		FileWriter fileWriter=new FileWriter(path);
		fileWriter.write("<dependency org=\""+org.trim()+"\" name=\""+name.trim()+"\" rev=\""+rev.trim()+"\" />");
		fileWriter.close();
	}
	@RequestMapping(value="/download", method=RequestMethod.GET)
	public void download(String filename,HttpServletResponse response) throws IOException{
		try {
			 response.setContentType("application/x-msdownload");
			 String fnm=filename.substring(0, filename.lastIndexOf("."));
			 response.setHeader("Content-disposition","attachment;filename="+fnm);
			String path=this.getClass().getResource("").getPath();
			path=path.substring(0,path.indexOf("WEB-INF"));
			path+="resources/xmlData/";
			path+=filename;
			File file=new File(path);
			FileReader inputStream=new FileReader(file);
			BufferedReader bf=new BufferedReader(inputStream);
			
			ServletOutputStream os= response.getOutputStream();
			while(bf.ready())
			{
				String line=bf.readLine();
				os.print(line);
			}
			bf.close();
			os.close();

		} catch (Exception e) {
		}

	}
	
	
	@RequestMapping(value="/downFile", method=RequestMethod.POST)
	public void downFile(String[] filenames,HttpServletResponse response) throws IOException{
		try {
			((MyFileFilter)filter).getInclude().clear();//清除过滤器的内容
			for(int i=0;filenames!=null && i!=filenames.length;++i)
			{
				filenames[i]=new String(filenames[i].getBytes("iso-8859-1"),"utf-8");
				((MyFileFilter)filter).getInclude().add(filenames[i]);
			}
			 response.setContentType("application/x-msdownload");
			 Properties conf=new Properties();
			 conf.load(this.getClass().getResourceAsStream("/conf.properties"));
			 String path=conf.getProperty("getfile_path"); //获得文件目录 , 基础目录
			 String savepath=conf.getProperty("save_path");//获得需要排除的文件目录 操作文件目录
			 String ivypath=conf.getProperty("ivy_path");//获得ivy文件路径
			 File[] zipSaveList=new File(savepath).listFiles();
			 List<String> exclude=new ArrayList<String>();
			 exclude.add("/**/*.metadata");
			 Set<String> setname=new HashSet<String>();
			 if(filenames != null)
				 setname.addAll( Arrays.asList(filenames));
			 String prix="";
			 if(savepath.indexOf(path)>=0)
			 {
				 prix= savepath.substring(savepath.indexOf(path)+path.length()+1);
				 prix+="/";
			 }
			 //得出排除集
			 for(File sfile:zipSaveList)
			 {
				 if(!setname.contains(sfile.getName().trim()))
				 {
					 String tmp=prix+sfile.getName();
					 if(sfile.isDirectory()){
						 tmp+="/";
					 }
					 exclude.add(tmp);
				 }
			 }
			 File file=new File(path);
			 ServletOutputStream os= response.getOutputStream();
			 File zipFile=null;
			 if(file.isDirectory())
			 {
				 zipFile=TesterController.fileZip(file,new ArrayList<String>(),exclude);
				 String filename=zipFile.getName();
				 filename= filename.substring(0, filename.indexOf(".zip")+4);
				response.setHeader("Content-disposition", "attachment;filename="
						+filename);
				 addIvy(zipFile, ivypath, savepath,os);
			}

			file=new File(zipFile.getAbsolutePath());
			file.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	private  void  addIvy(File zipfile,String ivypath,String readivyDir,OutputStream outputStream) throws Exception
	{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse(ivypath);
		Node node=doc.getElementsByTagName("dependencies").item(0);//获得ivy xml 文件数据
		
		File file=new File(readivyDir);
		List<File>list=new ArrayList<File>();//获得所有的元数据
		this.listivyFile(file, list);
		for(File f:list)
		{
			Document ivymeta=builder.parse(f);
			Element element= doc.createElement("dependency");
			Element ivyNode=(Element)ivymeta.getFirstChild();
			element.setAttribute("org", ivyNode.getAttribute("org"));
			element.setAttribute("name", ivyNode.getAttribute("name"));
			element.setAttribute("rev", ivyNode.getAttribute("rev"));
			node.appendChild( element );
		}
		//将zip 文件写入流
		 ZipInputStream zipInputStream=new ZipInputStream(new FileInputStream(zipfile));
		 ZipOutputStream zipOutputStream=new ZipOutputStream(outputStream);
		 ZipEntry entry=zipInputStream.getNextEntry();
		 while(entry!=null)
		 {
			 zipOutputStream.putNextEntry(entry);
			 byte[]buf=new byte[1024];
			 int size=0;
			 while((size=zipInputStream.read(buf))>=0)
			 {
				 zipOutputStream.write(buf, 0, size);
			 }
			 zipOutputStream.closeEntry();
			 entry=zipInputStream.getNextEntry();
		 }

		//将ivy 写入流
		 ZipEntry ivyEntry=new ZipEntry("ivy.xml");
		 zipOutputStream.putNextEntry(ivyEntry);
		 DOMElementWriter writer=new DOMElementWriter();
		 writer.write((Element) doc.getFirstChild(), zipOutputStream);
		 zipOutputStream.closeEntry();
		 zipOutputStream.close();
		 zipInputStream.close();
	}
	private  static	FileFilter filter=new MyFileFilter();
	static class MyFileFilter implements FileFilter{

		@Override
		public boolean accept(File pathname) {
			if((include.contains(pathname.getName().trim())&&pathname.isDirectory())  || pathname.getName().equals("ivy.metadata"))
				return true;
			return false;
		}
		private Set<String> include =new HashSet<String>();
		public Set<String> getInclude() {
			return include;
		}
		public void setInclude(Set<String> include) {
			this.include = include;
		}
	}
	private   void listivyFile(File readivyDir,List<File> list)
	{
		if(readivyDir.isDirectory())
		{
			File[] files=readivyDir.listFiles(filter);
			for(File file: files)
			{
				listivyFile(file, list);
			}
		}else{
			list.add(readivyDir);
		}
	}
	public static void main(String[] args) throws Exception {
/*		ZipFile zipfile=new ZipFile("E:/chrome/resources.zip");
		 Enumeration<ZipEntry> en=zipfile.getEntries();
		 ZipEntry entry=en.nextElement();
		 InputStream stream=zipfile.getInputStream(entry);
		 byte[] b=new byte[1024];
		 System.out.println(stream.read(b));
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse("D:/workspace/xmlBeanUtil/target/xmlBeanUtil/resources/xmlDatas/bbbbb/ivy.metadata");
		Node node=doc.getFirstChild();
		System.out.println(node.getNodeName());*/
		/*		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
	//	Document doc = builder.parse("D:/workspace/ivyTest1/ivy.xml");
	//D:\workspace\xmlBeanUtil\target\xmlBeanUtil\resources\xmlDatas\11
		Document doc = builder.parse("D:/workspace/xmlBeanUtil/target/xmlBeanUtil/resources/xmlDatas/11/app_test_task.xml");
		DOMElementWriter writer=new DOMElementWriter();
		Element element=doc.createElement("dependency") ;
		element.setAttribute("org", "testorg");
		element.setAttribute("name", "testname");
		element.setAttribute("rev", "testrev");
		Node node=doc.getElementsByTagName("dependencies").item(0);
	//	node.appendChild(element);
		writer.write((Element) doc.getFirstChild().getNextSibling(), System.out);*/
	
//		writer.write((Element) doc.getFirstChild(), new FileOutputStream("D:/workspace/ivyTest1/ivy1.xml"));

	}
}
