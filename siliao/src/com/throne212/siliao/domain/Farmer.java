package com.throne212.siliao.domain;

import java.io.Serializable;

//农户
public class Farmer extends MyEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	private Area area;// 所属管区

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

}
