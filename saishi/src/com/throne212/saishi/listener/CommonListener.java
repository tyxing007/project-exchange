package com.throne212.saishi.listener;

import java.io.IOException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.throne212.saishi.biz.DataBiz;
import com.throne212.saishi.common.WebConstants;
import com.throne212.saishi.comunicate.Handler;
import com.throne212.saishi.comunicate.MultiThreadServer;



public class CommonListener implements ServletContextListener {

	private Logger logger = Logger.getLogger(this.getClass());

	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	public void contextInitialized(ServletContextEvent e) {
		// 获取spring容器
		ApplicationContext ac = WebApplicationContextUtils.getRequiredWebApplicationContext(e.getServletContext());
		// 设置上下文路径
		String appPath = e.getServletContext().getContextPath();
		logger.info("appPath=" + appPath);
		if (!appPath.equals("/")) {
			appPath = appPath + "/";
		}
		e.getServletContext().setAttribute(WebConstants.APP_PATH, appPath);
		//设置系统名称
		e.getServletContext().setAttribute(WebConstants.APP_TITLE, "赛事管理系统");
		//启动服务端服务
		try {
			new Thread(new MultiThreadServer(),"service").start();
			Handler.dataBiz = (DataBiz) ac.getBean("dataBiz");
		} catch (IOException e1) {
			e1.printStackTrace();
			logger.warn("服务端服务启动失败", e1);
		}
	}

}

