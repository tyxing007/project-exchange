package com.throne212.info168.web.domain;

import java.util.HashSet;
import java.util.Set;

public class Category {
	private Long id;
	private String name;
	private Category parent;
	private Integer grade;
	private Set<Category> childs = new HashSet<Category>();
	
	

	public Category(String name) {
		super();
		this.name = name;
	}

	public Category(String name, Integer grade) {
		super();
		this.name = name;
		this.grade = grade;
	}

	public Category(String name, Category parent) {
		super();
		this.name = name;
		this.parent = parent;
	}

	public Category(String name, Category parent, Integer grade, Set<Category> childs) {
		super();
		this.name = name;
		this.parent = parent;
		this.grade = grade;
		this.childs = childs;
	}

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

	public Category getParent() {
		return parent;
	}

	public void setParent(Category parent) {
		this.parent = parent;
	}

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public Set<Category> getChilds() {
		return childs;
	}

	public void setChilds(Set<Category> childs) {
		this.childs = childs;
	}

}
