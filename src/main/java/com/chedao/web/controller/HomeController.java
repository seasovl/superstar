package com.chedao.web.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	@RequestMapping(value="/")
	public ModelAndView home(HttpServletResponse response) throws IOException{
		return new ModelAndView("home");
	}
	@RequestMapping(value="/test")
	public ModelAndView test(HttpServletResponse response) throws IOException{
		return new ModelAndView("test");
	}
	@RequestMapping(value="/development")
	public ModelAndView development(HttpServletResponse response) throws IOException{
		return new ModelAndView("development");
	}

}
