package com.throne212.fupin.domain;

import java.io.Serializable;

//用户的抽象类
public class User extends MyEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	private String loginName;// 登录名
	private String password;// 密码

	private String remark;
	
//	// 帮扶责任人信息
//	private String name;// 名称
//	private String tel;// 电话
//	private String email;// 邮箱
	
	public String getRoleName(){
		if(this instanceof Admin){
			return "超级管理员";
		}else if(this instanceof Org){
			return ((Org)this).getOrgName()+"•单位管理员";
		}else if(this instanceof ShiWorkOrg){
			return ((ShiWorkOrg)this).getShi().getShiName()+"扶贫办•市级管理员";
		}else if(this instanceof AreaWorkOrg){
			return ((AreaWorkOrg)this).getArea().getAreaName()+"扶贫工作队•区县级管理员";
		}else if(this instanceof ZhenWorkOrg){
			return ((ZhenWorkOrg)this).getZhen().getZhenName()+"扶贫工作组•镇级管理员";
		}
		return null;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	

}