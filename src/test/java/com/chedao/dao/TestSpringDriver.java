package com.chedao.dao;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestSpringDriver {
	@Test
	public void getConnection()
	{
		ApplicationContext context=new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		SqlSession session= (SqlSession) context.getBean("sqlSession");
	}
}
