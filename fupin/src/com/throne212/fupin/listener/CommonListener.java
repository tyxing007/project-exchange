package com.throne212.fupin.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

import com.throne212.fupin.common.WebConstants;

public class CommonListener implements ServletContextListener {

	private Logger logger = Logger.getLogger(this.getClass());

	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	public void contextInitialized(ServletContextEvent e) {
		// 获取spring容器
		//ApplicationContext ac = WebApplicationContextUtils.getRequiredWebApplicationContext(e.getServletContext());
		// 设置上下文路径
		String appPath = e.getServletContext().getContextPath();
		logger.info("appPath=" + appPath);
		if (!appPath.equals("/")) {
			appPath = appPath + "/";
		}
		e.getServletContext().setAttribute(WebConstants.APP_PATH, appPath);
		//设置系统名称
		e.getServletContext().setAttribute(WebConstants.APP_TITLE, "扶贫信息管理系统");
	}

}