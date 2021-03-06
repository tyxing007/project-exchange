package com.throne212.fupin.action;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

import com.opensymphony.xwork2.ActionContext;
import com.throne212.fupin.common.Util;
import com.throne212.fupin.common.WebConstants;


public class FileUploadAction extends BaseAction {
	private File myfile;
	private String myfileContentType;
	private String myfileFileName;
	public String execute(){
		if (myfile != null) {
			if (myfile.length()>1024*1024*5) {
				logger.debug(myfile.length());
				this.setMsg("图片太大,请上传小于5M的图片！");
				return "error";
			}
			
			String path = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
			logger.debug(">>>>>>>>>>>>>>>>>>>"+path);
			logger.debug("+++++++++"+Thread.currentThread().getContextClassLoader().getResource("/"));
			path = path.substring(0, path.indexOf("WEB-INF"));
			logger.debug("》》》》》》》》》》》》"+path);
			path += "upload";
			logger.debug("image saved path : " + path);
			int dot = myfileFileName.lastIndexOf(".");
			String subfix = myfileFileName.substring(dot + 1);
			if(Util.isEmpty(subfix)){
				this.setMsg("文件格式错误");
				return "error";
			}else if(!subfix.trim().equalsIgnoreCase("JPG") && !subfix.trim().equalsIgnoreCase("JPEG") && !subfix.trim().equalsIgnoreCase("GIF")){
				this.setMsg("请上传后缀名仅为jpg,jpeg,gif的图片文件");
				return "error";
			}
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
