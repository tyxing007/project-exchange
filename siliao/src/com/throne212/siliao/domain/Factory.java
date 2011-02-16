package com.throne212.siliao.domain;

import java.io.Serializable;
import java.util.Date;

//饲料厂商
public class Factory implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long id;// 主键
	private String name;// 名称
	private String head;// 负责人
	private String creator;// 创建人
	private String remark;// 备注
	private Date date;// 创建日期

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}