package com.throne212.info168.web.action;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

import com.opensymphony.xwork2.ActionContext;
import com.throne212.info168.web.common.WebConstants;

public class FileUploadAction extends BaseAction {
	
	private File myfile;
	private String myfileContentType;
	private String myfileFileName;

	public String execute(){
		if (myfile != null) {
			String path = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
			path = path.substring(0, path.indexOf("WEB-INF"));
			path += "upload";
			logger.debug("image saved path : " + path);
			int dot = myfileFileName.lastIndexOf(".");
			String subfix = myfileFileName.substring(dot + 1);
			String targetFileName = System.currentTimeMillis()+"."+subfix;
			myfileFileName = targetFileName;
			try {
				FileUtils.copyFile(myfile, new File(path+File.separator+targetFileName));
				ActionContext.getContext().getSession().put(WebConstants.SESS_IMAGE, targetFileName);
				return "success";
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		return "error";
	}

	public File getMyfile() {
		return myfile;
	}

	public void setMyfile(File myfile) {
		this.myfile = myfile;
	}

	public String getMyfileContentType() {
		return myfileContentType;
	}

	public void setMyfileContentType(String myfileContentType) {
		this.myfileContentType = myfileContentType;
	}

	public String getMyfileFileName() {
		return myfileFileName;
	}

	public void setMyfileFileName(String myfileFileName) {
		this.myfileFileName = myfileFileName;
	}

}
