package com.throne212.tg.web.action;

import org.apache.log4j.Logger;

//所有Action的基础类
public class BaseAction {
	protected Logger logger = Logger.getLogger(this.getClass());
	protected String msg;// 错误提示信息
	protected String anotherMsg; //其它提示消息

	public String getAnotherMsg() {
		return anotherMsg;
	}

	public void setAnotherMsg(String anotherMsg) {
		this.anotherMsg = anotherMsg;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public String execute() {
		return "success";
	}

	
}
