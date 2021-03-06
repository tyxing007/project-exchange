package com.throne212.fupin.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionContext;
import com.throne212.fupin.biz.ReportBiz;
import com.throne212.fupin.common.ReportParam;
import com.throne212.fupin.common.Util;
import com.throne212.fupin.common.WebConstants;
import com.throne212.fupin.dataobject.State;
import com.throne212.fupin.domain.Org;
import com.throne212.fupin.domain.Report;
import com.throne212.fupin.domain.Report1;
import com.throne212.fupin.domain.Report2;
import com.throne212.fupin.domain.User;

public class ReportAction extends BaseAction {

	private ReportBiz reportBiz;
	private Report r;
	private Integer maxMonth;
	private Integer maxSeason;
	private Integer maxYear;
	
	private Boolean showZanCun = false;

	// excel导出文件
	private InputStream downloadFile;

	// 导出Excel
	public String excelReport1() {
		if (r == null) {
			this.setMsg("导出Excel失败，请检查参数是否正确");
			return viewReport1();
		}
		String filePath = null;
		try {
			filePath = reportBiz.getExcelReportFilePath(r, "1");
			if (filePath != null) {
				downloadFile = new FileInputStream(filePath);
				this.setMsg("report1_" + r.getYear() + "_" + r.getType() + "_" + r.getTime());
			} else {
				this.setMsg("报表文件生成失败，数据不完整或参数错误，请联系管理员");
				return viewReport1();
			}
		} catch (Exception e) {
			logger.error("报表文件生成失败", e);
			this.setMsg("报表文件生成失败，请联系管理员");
			return viewReport1();
		}
		return "excel";
	}

	// 解锁
	public String requstUnlock1() {
		reportBiz.requestUnlock(r, "1");
		this.setMsg("已经发送解锁请求");
		return viewReport1();
	}

	public String viewReport1() {
		
		//如果该单位用户未指定村帮扶，不能进行操作
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if(user instanceof Org){
			Org org = (Org) user;
			if(org.getCun() == null){
				this.setMsg("未指定存帮扶，请联系管理员指定村帮扶以后再进行报表操作");
				return "report_edit1";
			}
		}
		
		if (r == null) {// 默认条件打开，定向到当前的年得月份
			Calendar c = GregorianCalendar.getInstance();
			Integer year = c.get(Calendar.YEAR);
			String type = "month";
			String time = (c.get(Calendar.MONTH)) + "";
			if("0".equals(time)){
				year--;
				time = "12";
			}
			r = reportBiz.getReport("1", year, type, time);
			if (r == null) {
				r = new Report1();
				r.setYear(year);
				r.setTime(time);
				r.setType(type);
			}
		} else if (r != null && r.getId() == null) {// 按条件搜索
			Integer year = r.getYear();
			String type = r.getType();
			String time = r.getTime();
			if(("month".equals(type) || "season".equals(type)) && Util.isEmpty(time)){//如果时间为空，则采用默认的时间
				r = null;
				return viewReport1();
			}
			Report report = reportBiz.getReport("1", year, type, time);
			if (report != null)
				r = report;
			else {
				r = new Report1();
				r.setYear(year);
				r.setType(type);
				r.setTime(time);
			}
		}

		// 最大的月份和季度
		maxYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		maxMonth = GregorianCalendar.getInstance().get(Calendar.MONTH);
		maxSeason = maxMonth % 3 == 0 ? maxMonth / 3 : maxMonth / 3 + 1;

		// 填充灰色项目
		reportBiz.fillReport(r);
		
		//只有每月的1号到10号，可以暂存
		if(user instanceof Org){
			Calendar now = Calendar.getInstance();
			int day = now.get(Calendar.DAY_OF_MONTH);
			if(day >= 1 && day <= 10){
				//showZanCun = true;
			}
		}
		showZanCun = true;
		
		if(r != null){
			if(r.getLock()!=null && r.getLock().equals(1) ){
				msg = "该报表已经提交，如需修改请点击申请解锁";
			}else if(r.getLock()!=null && r.getLock().equals(0) ){
				msg = "该报表已解锁为可填报状态，可以填报";
			}
		}

		return "report_edit1";
	}

	public String tmpSaveReport1() {
		if (r != null && "month".equals(r.getType())) {
			String time = r.getTime();
			int month = GregorianCalendar.getInstance().get(Calendar.MONTH) + 1;
			int year = GregorianCalendar.getInstance().get(Calendar.YEAR);
			if (r.getYear() > year) {
				this.setMsg("对不起，您只能选择之前的年份，年份数需小于等于" + year);
				return viewReport1();
			} else if (r.getYear() == year && Integer.valueOf(time) > month) {
				this.setMsg("对不起，您只能选择之前的月份，月份数需小于" + month);
				return viewReport1();
			}
		}
		r = reportBiz.saveReport(r, "1");
		if (r == null) {
			this.setMsg("暂时保存报表失败");
		} else {
			r.setLock(3);// 3代表暂存
			reportBiz.saveOrUpdateEntity(r);
			this.setMsg("暂时报表保存成功");
		}
		return viewReport1();
	}

	public String saveReport1() {
		if (r != null && "month".equals(r.getType())) {
			String time = r.getTime();
			int month = GregorianCalendar.getInstance().get(Calendar.MONTH) + 1;
			int year = GregorianCalendar.getInstance().get(Calendar.YEAR);
			if (r.getYear() > year) {
				this.setMsg("对不起，您只能选择之前的年份，年份数需小于等于" + year);
				return viewReport1();
			} else if (r.getYear() == year && Integer.valueOf(time) > month) {
				this.setMsg("对不起，您只能选择之前的月份，月份数需小于等于" + month);
				return viewReport1();
			}
		}
		r = reportBiz.saveReport(r, "1");
		if (r == null) {
			this.setMsg("保存报表失败");
		} else {
			this.setMsg("报表保存成功");
		}
		return viewReport1();
	}

	// report2
	public String viewReport2() {
		if (r == null) {// 默认条件打开，定向到当前的年得月份
			Calendar c = GregorianCalendar.getInstance();
			Integer year = c.get(Calendar.YEAR);
			String type = "month";
			String time = (c.get(Calendar.MONTH)) + "";
			if("0".equals(time)){
				year--;
				time = "12";
			}
			r = reportBiz.getReport("2", year, type, time);
			if (r == null) {
				r = new Report2();
				r.setYear(year);
				r.setTime(time);
				r.setType(type);
			}
		} else if (r != null && r.getId() == null) {// 按条件搜索
			Integer year = r.getYear();
			String type = r.getType();
			String time = r.getTime();
			if(("month".equals(type) || "season".equals(type)) && Util.isEmpty(time)){//如果时间为空，则采用默认的时间
				r = null;
				return viewReport2();
			}
			Report report = reportBiz.getReport("2", year, type, time);
			if (report != null)
				r = report;
			else {
				r = new Report2();
				r.setYear(year);
				r.setType(type);
				r.setTime(time);
			}
		}

		// 最大的月份和季度
		maxYear = GregorianCalendar.getInstance().get(Calendar.YEAR);
		maxMonth = GregorianCalendar.getInstance().get(Calendar.MONTH);
		maxSeason = maxMonth % 3 == 0 ? maxMonth / 3 : maxMonth / 3 + 1;

		if(r != null){
			if(r.getLock()!=null && r.getLock().equals(1) ){
				msg = "该报表已经提交，如需修改请点击申请解锁";
			}else if(r.getLock()!=null && r.getLock().equals(0) ){
				msg = "该报表已解锁为可填报状态，可以填报";
			}
		}
		
		return "report_edit2";
	}

	public String saveReport2() {
		if (r != null && "month".equals(r.getType())) {
			String time = r.getTime();
			int month = GregorianCalendar.getInstance().get(Calendar.MONTH) + 1;
			int year = GregorianCalendar.getInstance().get(Calendar.YEAR);
			if (r.getYear() > year) {
				this.setMsg("对不起，您只能选择之前的年份，年份数需小于等于" + year);
				return viewReport2();
			} else if (r.getYear() == year && Integer.valueOf(time) > month) {
				this.setMsg("对不起，您只能选择之前的月份，月份数需小于等于" + month);
				return viewReport2();
			}
		}
		r = reportBiz.saveReport(r, "2");
		if (r == null) {
			this.setMsg("保存报表失败");
		} else {
			this.setMsg("报表保存成功");
		}
		return viewReport2();
	}

	public String tmpSaveReport2() {
		if (r != null && "month".equals(r.getType())) {
			String time = r.getTime();
			int month = GregorianCalendar.getInstance().get(Calendar.MONTH) + 1;
			int year = GregorianCalendar.getInstance().get(Calendar.YEAR);
			if (r.getYear() > year) {
				this.setMsg("对不起，您只能选择之前的年份，年份数需小于等于" + year);
				return viewReport2();
			} else if (r.getYear() == year && Integer.valueOf(time) > month) {
				this.setMsg("对不起，您只能选择之前的月份，月份数需小于" + month);
				return viewReport2();
			}
		}
		r = reportBiz.saveReport(r, "2");
		if (r == null) {
			this.setMsg("暂时保存报表失败");
		} else {
			r.setLock(3);// 3代表暂存
			reportBiz.saveOrUpdateEntity(r);
			this.setMsg("暂时报表保存成功");
		}
		return viewReport2();
	}

	public String requstUnlock2() {
		reportBiz.requestUnlock(r, "2");
		this.setMsg("已经发送解锁请求");
		return viewReport2();
	}

	// 报表列表，给sa用的
	private List<Report> reportList;

	public String reportList() {
		reportList = reportBiz.getEntitiesByColumn(Report.class, "lock", 2);
		return "report_list";
	}

	public String unlock() {
		String[] ids = (String[]) ActionContext.getContext().getParameters().get("ids");
		if (ids != null && ids.length > 0) {
			for (String idStr : ids) {
				Report report = reportBiz.getEntityById(Report.class, Long.parseLong(idStr));
				report.setLock(0);// 0表示已经解锁
				reportBiz.saveOrUpdateEntity(report);
			}
			this.setMsg("成功解锁" + ids.length + "个报表");
		}
		return reportList();
	}

	// 导出Excel2
	public String excelReport2() {
		if (r == null) {
			this.setMsg("导出Excel失败，请检查参数是否正确");
			return viewReport2();
		}
		String filePath = null;
		try {
			filePath = reportBiz.getExcelReportFilePath(r, "2");
			if (filePath != null) {
				downloadFile = new FileInputStream(filePath);
				this.setMsg("report2_" + r.getYear() + "_" + r.getType() + "_" + r.getTime());
			} else {
				this.setMsg("报表文件生成失败，数据不完整或参数错误，请联系管理员");
				return viewReport2();
			}
		} catch (Exception e) {
			logger.error("报表文件生成失败", e);
			this.setMsg("报表文件生成失败，请联系管理员");
			return viewReport2();
		}
		return "excel";
	}

	private ReportParam reportParam;

	public String export() {
		if (reportParam == null)
			return "report_export";
		if(Util.isEmpty(reportParam.getMonth()) || Util.isEmpty(reportParam.getMonth2())){
			this.setMsg("月份不可为空");
			return "report_export"; 
		}
		String filePath = null;
		try {
			filePath = reportBiz.getExcelReportFilePath(reportParam);
			if (filePath != null) {
				downloadFile = new FileInputStream(filePath);
				this.setMsg(filePath.substring(filePath.lastIndexOf(File.separator),filePath.lastIndexOf(".")));
				return "excel";
			} else {
				this.setMsg("报表文件生成失败，数据不完整或参数错误，请联系管理员");
			}
		} catch (Exception e) {
			logger.error("报表文件生成失败", e);
			this.setMsg("报表文件生成失败，请联系管理员");
		}
		return "report_export";
	}
	//统计
	private List<String[]> statList;
	public String stat() {
		if (reportParam == null)
			return "report_stat";
		if(Util.isEmpty(reportParam.getMonth()) || Util.isEmpty(reportParam.getMonth2())){
			this.setMsg("月份不可为空");
			return "report_stat"; 
		}
		try {
			statList = reportBiz.statReport(reportParam);
		} catch (Exception e) {
			logger.error("统计失败", e);
			this.setMsg("统计失败，请联系管理员");
		}
		return "report_stat";
	}
	public String statExport() {
		if (reportParam == null)
			return "report_stat";
		if(Util.isEmpty(reportParam.getMonth()) || Util.isEmpty(reportParam.getMonth2())){
			this.setMsg("月份不可为空");
			return "report_stat"; 
		}
		String filePath = null;
		try {
			statList = reportBiz.statReport(reportParam);
			filePath = reportBiz.getExcelStatFilePath(statList);
			if (filePath != null) {
				downloadFile = new FileInputStream(filePath);
				this.setMsg(filePath.substring(filePath.lastIndexOf(File.separator),filePath.lastIndexOf(".")));
				return "excel";
			} else {
				this.setMsg("报表文件生成失败，数据不完整或参数错误，请联系管理员");
			}
		} catch (Exception e) {
			logger.error("报表文件生成失败", e);
			this.setMsg("报表文件生成失败，请联系管理员");
		}
		return "report_stat";
	}
	
	public String autoSaveReport(){
		Calendar now = Calendar.getInstance();
		int nowDay = now.get(Calendar.DAY_OF_MONTH);
		//last month
		Calendar last = Calendar.getInstance();
		last.setTimeInMillis(now.getTimeInMillis() - 30L * 24 * 60 * 60 * 1000);
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH);
		if(nowDay >= 11){
			try {
				reportBiz.autoSaveReports(year, month);
				this.setMsg("保存当月报表成功");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				this.setMsg("保存失败，系统错误");
			}
		}else{
			this.setMsg("11号之前不能进行此操作");
		}
		return "report_export";
	}

	private Integer year;
	private Integer rType;
	private String title;
	
	public String state(){
		if(rType != null && rType == 1){
			title = "表一二填报情况";
		}else if(rType != null && rType == 2){
			title = "表三填报情况";
		}
		if(year == null || year == 0){
			Calendar c = GregorianCalendar.getInstance();
			year = c.get(Calendar.YEAR);
			int m = c.get(Calendar.MONTH);
			if(m == 0){
				year--;
			}
			return "report_state"; 
		}
		List<State> list = reportBiz.state(rType,year);
		Map<String, Object> mapJson = new Hashtable<String, Object>();
		mapJson.put("total", list.size());// easyUI需要total的大小，就是list的大小
		mapJson.put("rows", list);// 把list放到map里面，一定要写成rows
		JSONObject jsonObject = JSONObject.fromObject(mapJson); // 这个是net.sf.json.JSONObject;下面的方法，将map转换成JSON格式的字符串
		ActionContext actionContext = ActionContext.getContext();
		actionContext.getValueStack().set("jsonObject", jsonObject);// 将转换出来的jsonObject保存起，传到页面上去
		logger.debug("jsonObject:" + jsonObject.toString());
		
		return "report_state";
	}
	
	public Report getR() {
		return r;
	}

	public void setR(Report r) {
		this.r = r;
	}

	public ReportBiz getReportBiz() {
		return reportBiz;
	}

	public void setReportBiz(ReportBiz reportBiz) {
		this.reportBiz = reportBiz;
	}

	public List<Report> getReportList() {
		return reportList;
	}

	public void setReportList(List<Report> reportList) {
		this.reportList = reportList;
	}

	public InputStream getDownloadFile() {
		return downloadFile;
	}

	public void setDownloadFile(InputStream downloadFile) {
		this.downloadFile = downloadFile;
	}

	public Integer getMaxMonth() {
		return maxMonth;
	}

	public void setMaxMonth(Integer maxMonth) {
		this.maxMonth = maxMonth;
	}

	public Integer getMaxSeason() {
		return maxSeason;
	}

	public void setMaxSeason(Integer maxSeason) {
		this.maxSeason = maxSeason;
	}

	public ReportParam getReportParam() {
		return reportParam;
	}

	public void setReportParam(ReportParam reportParam) {
		this.reportParam = reportParam;
	}

	public Integer getMaxYear() {
		return maxYear;
	}

	public void setMaxYear(Integer maxYear) {
		this.maxYear = maxYear;
	}

	public Boolean getShowZanCun() {
		return showZanCun;
	}

	public void setShowZanCun(Boolean showZanCun) {
		this.showZanCun = showZanCun;
	}

	public List<String[]> getStatList() {
		return statList;
	}

	public void setStatList(List<String[]> statList) {
		this.statList = statList;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getRType() {
		return rType;
	}

	public void setRType(Integer rType) {
		this.rType = rType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
