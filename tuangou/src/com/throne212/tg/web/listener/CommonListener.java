package com.throne212.tg.web.listener;

import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.throne212.tg.web.biz.CommonBiz;
import com.throne212.tg.web.common.WebConstants;
import com.throne212.tg.web.domain.City;
import com.throne212.tg.web.domain.TeamCategory;

public class CommonListener implements ServletContextListener {
	private Logger logger = Logger.getLogger(this.getClass());
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub

	}

	public void contextInitialized(ServletContextEvent e) {
		// 获取spring容器
		ApplicationContext ac = WebApplicationContextUtils.getRequiredWebApplicationContext(e.getServletContext());
		// 设置应用程序上下文和标题，关键字
		e.getServletContext().setAttribute(WebConstants.APP_PATH, e.getServletContext().getContextPath());
		logger.debug(WebConstants.APP_PATH+"--->"+e.getServletContext().getContextPath());
		String imgSavedPath= e.getServletContext().getContextPath()+"/upload";
		//设置上传图片存储路径
		e.getServletContext().setAttribute(WebConstants.APP_IMG_SAVED_PATH, imgSavedPath);
		logger.debug(WebConstants.APP_IMG_SAVED_PATH+"------>"+e.getServletContext().getAttribute(WebConstants.APP_IMG_SAVED_PATH));
		String path = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
		path = path.substring(0, path.indexOf("WEB-INF"));
		path += "upload";
	
		logger.debug(Thread.currentThread().getContextClassLoader().getResource("/").getPath());
		e.getServletContext().setAttribute(WebConstants.APP_TITLE, "团购导航网站");
		e.getServletContext().setAttribute(WebConstants.APP_KEY_WORDS, "团购导航网站关键词");
		e.getServletContext().setAttribute(WebConstants.APP_DESC, "团购导航网站描述");
		
		CommonBiz commonBiz = (CommonBiz) ac.getBean("commonBiz");
		List<City> cities = commonBiz.getAll(City.class, "orderNum", "asc");
		e.getServletContext().setAttribute(WebConstants.APP_CITIES, cities);
		e.getServletContext().setAttribute(WebConstants.SESS_CITY, cities.get(0));
		List<TeamCategory> cates = commonBiz.getAll(TeamCategory.class, "orderNum", "asc");
		e.getServletContext().setAttribute(WebConstants.APP_CATEGOTIES, cates);
		
	}

}
