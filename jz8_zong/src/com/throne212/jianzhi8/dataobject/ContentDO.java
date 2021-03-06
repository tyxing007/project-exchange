package com.throne212.jianzhi8.dataobject;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.throne212.jianzhi8.common.Util;

//位列表页专用
public class ContentDO {

	private static SimpleDateFormat fmt = new SimpleDateFormat("MM月dd日");

	private String ctNo;
	private String ctClass;
	private String title;
	private String simpleDes;
	private String typeId;
	private String types;
	private Date date;
	private Date regdate;
	private Date enddate;
	private String isPay;
	private String isYz;
	private String userFile;
	private String companyName;
	private String typeName;
	private String cityCode;
	private String cityId;
	private String cityName;
	private String salary;
	private String age;
	private String sex;
	private String userId;

	public boolean getDing() {
		if ("1".equals(isPay) && enddate != null) {
			long now = System.currentTimeMillis();
			long endTime = enddate.getTime();
			if (now < endTime)
				return true;
		}
		return false;
	}
	
	public boolean getIng(){
    	if ("1".equals(isYz) && enddate != null) {
			long now = System.currentTimeMillis();
			long endTime = enddate.getTime();
			if (now < endTime)
				return true;
		}
    	return false;
    }
	
	public String getDateTxt() {
		if (date == null)
			return "";
		return fmt.format(date);
	}

	public String getCtNo() {
		return ctNo;
	}

	public void setCtNo(String ctNo) {
		this.ctNo = ctNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSimpleDes() {
		return simpleDes;
	}

	public void setSimpleDes(String simpleDes) {
		this.simpleDes = simpleDes;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getTypeId() {
		if (typeId == null || !typeId.contains("-"))
			return typeId;
		String[] arr = typeId.split("-");
		if (arr != null && arr.length > 0)
			return arr[0];
		else
			return null;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getIsPay() {
		return isPay;
	}

	public void setIsPay(String isPay) {
		this.isPay = isPay;
	}

	public String getIsYz() {
		return isYz;
	}

	public void setIsYz(String isYz) {
		this.isYz = isYz;
	}

	public String getUserFile() {
		return userFile;
	}

	public void setUserFile(String userFile) {
		this.userFile = userFile;
	}

	public String getCtClass() {
		return ctClass;
	}

	public void setCtClass(String ctClass) {
		this.ctClass = ctClass;
	}

	public String getTypeName() {
		if (typeName == null || !typeName.contains(";"))
			return typeName;
		String[] arr = typeName.split(";");
		if (arr != null && arr.length > 0)
			return arr[0];
		else
			return null;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}
	
	
	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	
	public String getArea(){
		if(!Util.isEmpty(cityCode) && cityCode.length() == 6 && !Util.isEmpty(cityName)){
			return cityName.split(",")[1];
		}
		return null;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public int getTypeNameLen(){
		if(typeName != null)
			return typeName.length();
		else
			return 0;
	}

}
