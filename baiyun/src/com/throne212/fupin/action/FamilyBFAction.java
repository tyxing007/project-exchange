package com.throne212.fupin.action;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.throne212.fupin.biz.FamilyBFBiz;
import com.throne212.fupin.biz.OrgBiz;
import com.throne212.fupin.common.PageBean;
import com.throne212.fupin.common.Util;
import com.throne212.fupin.common.WebConstants;
import com.throne212.fupin.domain.Admin;
import com.throne212.fupin.domain.AreaWorkOrg;
import com.throne212.fupin.domain.ChengxiaoFamily;
import com.throne212.fupin.domain.Cun;
import com.throne212.fupin.domain.CuoshiFamily;
import com.throne212.fupin.domain.Family;
import com.throne212.fupin.domain.Leader;
import com.throne212.fupin.domain.LeaderHelp;
import com.throne212.fupin.domain.Org;
import com.throne212.fupin.domain.PicFamily;
import com.throne212.fupin.domain.Reason;
import com.throne212.fupin.domain.Recheck;
import com.throne212.fupin.domain.Record;
import com.throne212.fupin.domain.User;
import com.throne212.fupin.domain.ZhenWorkOrg;

public class FamilyBFAction extends BaseAction {
	private FamilyBFBiz familyBFBiz;
	private PageBean pageBean;
	private Integer pageIndex;
	private CuoshiFamily cuoshi;
	private ChengxiaoFamily chengxiao;
	private Reason reason;
	private Record record;
	private Cun cun;
	
	private Long zhenId;
	private Long cunId;
	
	private List<Family> familyList;
	
	public String selectFamily(){
		familyList = new ArrayList<Family>();
		String fName = ServletActionContext.getRequest().getParameter("familyName");
		Org org = (Org) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		List<Family> list = familyBFBiz.getEntitiesByColumn(Family.class, "cun", org.getCun());
		if(!Util.isEmpty(fName)){
			for(Family f : list){
				if(f.getName().contains(fName)){
					familyList.add(f);
				}
			}
		}else{
			familyList = list;
		}
		return "select_family";
	}

	// 户帮扶措施列表
	public String cuoshiFamilyList() {
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);

		if (user instanceof Admin || user instanceof AreaWorkOrg || user instanceof ZhenWorkOrg) {
			pageBean = familyBFBiz.getAllCuoshiFamily(cuoshi,zhenId,cunId, pageIndex);
			return "cuoshifamily_list";
		}

		if (user instanceof Org) {
			Org org = (Org) user;
			if (org.getCun() == null) {
				this.setMsg("尚未指定帮扶村，不能进行操作");
				return "cuoshifamily_list";
			}
			pageBean = familyBFBiz.getAllCuoshiFamilyByCunId(cuoshi, org.getCun().getId(), pageIndex);
		}
		addLeaderData();
		return "cuoshifamily_list";
	}

	// 增加或修改户帮扶措施
	private Long leaderId;

	public String saveOrUpdateCuoshiFamily() {
		if (cuoshi == null) {
			this.setMsg("保存失败，请检查数据是否录入完整");
			return "cuoshifamily_edit";
		}
		if (cuoshi != null && !Util.isEmpty(cuoshi.getYear())) {// 添加或更新信息
			if (cuoshi.getYear() == null) {
				this.setMsg("请选择帮扶年度！");
				return "cuoshifamily_edit";
			}
			User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
			if (user instanceof Admin) {
				this.setMsg("超级管理员无权进行此操作！");
				return "cuoshifamily_edit";
			}
			Family family = null;
			if (cuoshi.getFamily() != null && cuoshi.getFamily().getId() != null) {
				family = familyBFBiz.getEntityById(Family.class, cuoshi.getFamily().getId());
				cuoshi.setFamily(family);
			}
			if (family != null && leaderId != null) {
				Leader leader = familyBFBiz.getEntityById(Leader.class, leaderId);
				leader.setFamily(family);
			}
			cuoshi.setFamily(family);
			cuoshi.setStatus(WebConstants.SHENHE_STATUS_UNCOMMIT);
			cuoshi = familyBFBiz.saveOrUpdateCuoshiFamily(cuoshi);
			this.setMsg("保存成功");
			this.setSucc("Y");
			cuoshi = null;
		} else if (cuoshi != null && cuoshi.getId() != null) {// 查看详情
			cuoshi = familyBFBiz.getEntityById(CuoshiFamily.class, cuoshi.getId());
		}
		return "cuoshifamily_edit";
	}

	// 确定提交
	public String confirmCuoshi() {
		if (cuoshi.getId() != null) {
			cuoshi = familyBFBiz.getEntityById(CuoshiFamily.class, cuoshi.getId());
			cuoshi.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
			// 自动为审核通过
			cuoshi.setStatus(WebConstants.SHENHE_STATUS_PASS);
			familyBFBiz.saveOrUpdateEntity(cuoshi);
			this.setMsg("提交成功！");
		}
		return cuoshiFamilyList();

	}

	// 删除措施
	public String deleteCuoshiFamily() {
		String[] cuoshiFamilyIds = (String[]) ActionContext.getContext().getParameters().get("cuoshiFamily_ids");
		if (cuoshiFamilyIds != null && cuoshiFamilyIds.length > 0) {
			for (String idStr : cuoshiFamilyIds) {
				Long id = Long.parseLong(idStr);
				familyBFBiz.deleteEntity(CuoshiFamily.class, id);
			}
			this.setMsg("删除措施成功");
		}
		return cuoshiFamilyList();
	}

	// 户帮扶成效列表
	public String chengxiaoFamilyList() {
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);

		if (user instanceof Admin || user instanceof AreaWorkOrg || user instanceof ZhenWorkOrg) {
			pageBean = familyBFBiz.getAllChengxiaoFamily(chengxiao,zhenId,cunId, pageIndex);
			return "chengxiaofamily_list";
		}
		Org org = (Org) user;
		if (org.getCun() == null) {
			this.setMsg("尚未指定帮扶村，不能进行操作");
			return "reason_list";
		}
		pageBean = familyBFBiz.getAllChengxiaoFamilyByCunId(chengxiao, org.getCun().getId(), pageIndex);
		addLeaderData();
		return "chengxiaofamily_list";
	}

	// 增加或修改户帮扶成效
	public String saveOrUpdateChengxiaoFamily() {
		if (chengxiao == null) {
			this.setMsg("保存失败，请检查数据是否录入完整");
			return "chengxiaofamily_edit";
		}
		if (chengxiao != null && !Util.isEmpty(chengxiao.getYear())) {// 添加或更新信息
			if (chengxiao.getYear() == null) {
				this.setMsg("请选择帮扶年度！");
				return "chengxiaofamily_edit";
			}
			User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
			if (user instanceof Admin) {
				this.setMsg("超级管理员无权进行此操作！");
				return "chengxiaofamily_edit";
			}
			Family family = null;
			if (chengxiao.getFamily() != null && chengxiao.getFamily().getId() != null) {
				family = familyBFBiz.getEntityById(Family.class, chengxiao.getFamily().getId());
				chengxiao.setFamily(family);
			}
			if (family != null && leaderId != null) {
				Leader leader = familyBFBiz.getEntityById(Leader.class, leaderId);
				leader.setFamily(family);
			}
			chengxiao.setFamily(family);
			chengxiao.setStatus(WebConstants.SHENHE_STATUS_UNCOMMIT);
			chengxiao = familyBFBiz.saveOrUpdateChengxiaoFamily(chengxiao);
			this.setMsg("保存成功");
			this.setSucc("Y");
			chengxiao = null;
		} else if (chengxiao != null && chengxiao.getId() != null) {// 查看详情
			chengxiao = familyBFBiz.getEntityById(ChengxiaoFamily.class, chengxiao.getId());
		}
		return "chengxiaofamily_edit";
	}

	// 确定提交
	public String confirmChengxiao() {
		if (chengxiao.getId() != null) {
			chengxiao = familyBFBiz.getEntityById(ChengxiaoFamily.class, chengxiao.getId());
			chengxiao.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
			// 自动为审核通过
			chengxiao.setStatus(WebConstants.SHENHE_STATUS_PASS);
			familyBFBiz.saveOrUpdateEntity(chengxiao);
			this.setMsg("提交成功！");
		}
		return chengxiaoFamilyList();
	}

	// 删除成效
	public String deleteChengxiaoFamily() {
		String[] chengxiaoFamilyIds = (String[]) ActionContext.getContext().getParameters().get("chengxiaoFamily_ids");
		if (chengxiaoFamilyIds != null && chengxiaoFamilyIds.length > 0) {
			for (String idStr : chengxiaoFamilyIds) {
				Long id = Long.parseLong(idStr);
				familyBFBiz.deleteEntity(ChengxiaoFamily.class, id);
			}
			this.setMsg("删除措施成功");
		}
		return chengxiaoFamilyList();
	}

	// 贫困原因列表
	public String reasonList() {
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);

		if (user instanceof Admin || user instanceof AreaWorkOrg || user instanceof ZhenWorkOrg) {
			pageBean = familyBFBiz.getAllReason(reason, zhenId,cunId,pageIndex);
			return "reason_list";
		}
		Org org = (Org) user;
		if (org.getCun() == null) {
			this.setMsg("尚未指定帮扶村，不能进行操作");
			return "reason_list";
		}
		pageBean = familyBFBiz.getAllReasonByCunId(reason, org.getCun().getId(), pageIndex);
		// 添加干部数据
		addLeaderData();
		return "reason_list";
	}

	// 增加或修改贫困原因
	public String saveOrUpdateReason() {
		if (reason == null) {
			this.setMsg("保存失败，请检查数据是否录入完整");
			return "reason_edit";
		}
		if (reason != null && !Util.isEmpty(reason.getYear())) {// 添加或更新信息
			if (reason.getYear() == null) {
				this.setMsg("请选择帮扶年度！");
				return "reason_edit";
			}
			User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
			if (user instanceof Admin) {
				this.setMsg("超级管理员无权进行此操作！");
				return "reason_edit";
			}
			Family family = null;
			if (reason.getFamily() != null && reason.getFamily().getId() != null) {
				family = familyBFBiz.getEntityById(Family.class, reason.getFamily().getId());
				reason.setFamily(family);
			}
			// if (family!=null&&leaderId!=null) {
			// Leader leader =familyBFBiz.getEntityById(Leader.class, leaderId);
			// leader.setFamily(family);
			// }
			reason.setFamily(family);
			reason.setStatus(WebConstants.SHENHE_STATUS_UNCOMMIT);
			reason = familyBFBiz.saveOrUpdateReason(reason);
			this.setMsg("保存成功");
			this.setSucc("Y");
			reason = null;
		} else if (reason != null && reason.getId() != null) {// 查看详情
			reason = familyBFBiz.getEntityById(Reason.class, reason.getId());
		}
		return "reason_edit";
	}

	// 确定提交
	public String confirmReason() {
		if (reason.getId() != null) {
			reason = familyBFBiz.getEntityById(Reason.class, reason.getId());
			reason.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
			// 自动为审核通过
			reason.setStatus(WebConstants.SHENHE_STATUS_PASS);
			familyBFBiz.saveOrUpdateEntity(reason);
			this.setMsg("提交成功！");
		}
		return reasonList();
	}

	// 删除原因
	public String deleteReason() {
		String[] reasonIds = (String[]) ActionContext.getContext().getParameters().get("reason_ids");
		if (reasonIds != null && reasonIds.length > 0) {
			for (String idStr : reasonIds) {
				Long id = Long.parseLong(idStr);
				familyBFBiz.deleteEntity(Reason.class, id);
			}
			this.setMsg("删除原因成功");
		}
		return reasonList();
	}

	// 帮扶图片信息列表
	public String picFamilyList() {
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		Cun cun = null;
		if (user instanceof Admin) {
			this.setMsg("超级管理员无权进行此操作！");
			return "pic_list";
		} else if (user instanceof Org) {
			Org org = (Org) user;
			List<Cun> list = familyBFBiz.getEntitiesByColumn(Cun.class, "org", org);
			if (list != null && list.size() > 0) {
				cun = list.get(0);
			}
		}
		if (cun == null) {
			this.setMsg("尚未指定帮扶村，不能进行操作!");
			return "pic_list";
		}
		pageBean = familyBFBiz.getAllPicFamilyByCunId(pic, cun.getId(), pageIndex);

		return "pic_list";
	}

	private PicFamily pic;

	public String saveOrUpdatePicFamily() {
		if (pic == null) {
			this.setMsg("保存失败，请检查数据是否录入完整");
			return "pic_edit";
		}
		if (pic != null && !Util.isEmpty(pic.getYear()) && !Util.isEmpty(pic.getType())) {// 添加或更新市扶贫账号信息
			User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
			Family family = null;
			if (user instanceof Admin) {
				this.setMsg("超级管理员无权进行此操作！");
				return "pic_edit";
			} else if (user instanceof Org) {
				Org org = (Org) user;
				List<Family> list = familyBFBiz.getEntitiesByColumn(Family.class, "cun.org", org);
				if (list != null && list.size() > 0) {
					family = list.get(0);
				}
			}
			if (family == null) {
				this.setMsg("尚未指定帮扶村，不能进行操作!");
				return "pic_edit";
			}
			// 设置户
			if (pic.getFamily() != null && pic.getFamily().getId() != null)
				family = orgBiz.getEntityById(Family.class, pic.getFamily().getId());
			pic.setFamily(family);
			String image = (String) ActionContext.getContext().getSession().get(WebConstants.SESS_IMAGE);
			if (image != null) {
				pic.setPath(image);
				ActionContext.getContext().getSession().remove(WebConstants.SESS_IMAGE);
			} else {
				this.setMsg("图片未能上传，请先上传图片，再确认操作");
				return "pic_edit";
			}
			pic.setStatus(WebConstants.SHENHE_STATUS_UNCOMMIT);
			pic = familyBFBiz.saveOrUpdatePicFamily(pic);
			this.setMsg("保存成功");
			this.setSucc("Y");
			pic = null;
		} else if (pic != null && pic.getId() != null) {// 查看详情
			pic = familyBFBiz.getEntityById(PicFamily.class, pic.getId());
		}
		return "pic_edit";

	}

	public String viewPic() {
		pic = familyBFBiz.getEntityById(PicFamily.class, pic.getId());
		return "show_pic";
	}

	// 确定提交
	public String confirmPic() {
		if (pic.getId() != null) {
			pic = familyBFBiz.getEntityById(PicFamily.class, pic.getId());
			pic.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
			// 自动为审核通过
			pic.setStatus(WebConstants.SHENHE_STATUS_PASS);
			familyBFBiz.saveOrUpdateEntity(pic);
			this.setMsg("提交成功！");
		}
		return picFamilyList();
	}

	// 删除图片
	public String deletePicFamily() {
		String[] picFamilyIds = (String[]) ActionContext.getContext().getParameters().get("picFamily_ids");
		if (picFamilyIds != null && picFamilyIds.length > 0) {
			for (String idStr : picFamilyIds) {
				Long id = Long.parseLong(idStr);
				familyBFBiz.deleteEntity(PicFamily.class, id);
			}
			this.setMsg("删除图片成功！");
		}
		return picFamilyList();
	}

	// 贫困户帮扶记录列表
	private Date fromDate;
	private Date toDate;

	public String recordList() {
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if (fromDate != null && toDate != null) {
			if (fromDate.getTime() > toDate.getTime()) {
				this.setMsg("起始时间必须小于结束时间！");
				return "record_list";
			}
		}

		if (user instanceof Admin || user instanceof AreaWorkOrg || user instanceof ZhenWorkOrg) {
			pageBean = familyBFBiz.getAllRecord(record, pageIndex, fromDate, toDate,zhenId,cunId);
			return "record_list";
		}
		Org org = (Org) user;
		if (org.getCun() == null) {
			this.setMsg("尚未指定帮扶村，不能进行操作");
			return "reason_list";
		}
		pageBean = familyBFBiz.getAllRecordByCunId(record, org.getCun().getId(), pageIndex, fromDate, toDate);
		addLeaderData();
		return "record_list";
	}

	// 增加或修改帮扶记录
	public String saveOrUpdateRecord() {
		if (record == null) {
			this.setMsg("保存失败，请检查数据是否录入完整");
			return "record_edit";
		}
		if (record != null && !Util.isEmpty(record.getYear())) {// 添加或更新信息
			User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
			if (user instanceof Admin) {
				this.setMsg("超级管理员无权进行此操作！");
				return "record_edit";
			}
			Family family = null;
			if (record.getFamily() != null && record.getFamily().getId() != null) {
				family = familyBFBiz.getEntityById(Family.class, record.getFamily().getId());
				record.setFamily(family);
			}
			if (family != null && leaderId != null) {
				Leader leader = familyBFBiz.getEntityById(Leader.class, leaderId);
				leader.setFamily(family);
			}
			record.setFamily(family);
			record.setStatus(WebConstants.SHENHE_STATUS_UNCOMMIT);
			record = familyBFBiz.saveOrUpdateRecord(record);
			this.setMsg("保存成功");
			this.setSucc("Y");
			record = null;
		} else if (record != null && record.getId() != null) {// 查看详情
			record = familyBFBiz.getEntityById(Record.class, record.getId());
		}
		return "record_edit";
	}

	// 确定提交
	public String confirmRecord() {
		if (record.getId() != null) {
			record = familyBFBiz.getEntityById(Record.class, record.getId());
			record.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
			// 自动为审核通过
			record.setStatus(WebConstants.SHENHE_STATUS_PASS);
			familyBFBiz.saveOrUpdateEntity(record);
			this.setMsg("提交成功！");
		}
		return recordList();
	}

	// 删除记录
	public String deleteRecord() {
		String[] recordIds = (String[]) ActionContext.getContext().getParameters().get("record_ids");
		if (recordIds != null && recordIds.length > 0) {
			for (String idStr : recordIds) {
				Long id = Long.parseLong(idStr);
				familyBFBiz.deleteEntity(Record.class, id);
			}
			this.setMsg("删除扶持记录成功");
		}
		return recordList();
	}

	// 规划到户
	private OrgBiz orgBiz;
	private Family family;
	private String queryKey;

	public String familyMappingList() {

		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if (user instanceof Admin || user instanceof AreaWorkOrg || user instanceof ZhenWorkOrg) {
			pageBean = orgBiz.getAllFamily(queryKey,pageIndex,2L,zhenId,cunId);
		} else if (user instanceof Org) {
			pageBean = orgBiz.getAllFamily((Org) user, queryKey, pageIndex);
		}
		// 添加干部数据
		addLeaderData();
		return "family_mapping_list";
	}

	// 添加干部数据
	private void addLeaderData() {
		if (pageBean.getResultList() != null && pageBean.getResultList().size() > 0) {
			// 清除垃圾数据
			orgBiz.deleteNonLeaderData();
			for (Object o : pageBean.getResultList()) {
				Family f = null;
				if (o instanceof Family)
					f = (Family) o;
				else if (o instanceof Reason)
					f = ((Reason) o).getFamily();
				else if (o instanceof CuoshiFamily)
					f = ((CuoshiFamily) o).getFamily();
				else if (o instanceof Record)
					f = ((Record) o).getFamily();
				else if (o instanceof ChengxiaoFamily)
					f = ((ChengxiaoFamily) o).getFamily();

				SortedSet sortSet = new TreeSet();

				List leaderList = orgBiz.getEntitiesByColumn(Leader.class, "family", f);
				if (leaderList != null && leaderList.size() > 0)
					sortSet.addAll(leaderList);

				// 通过映射表获取
				List<LeaderHelp> leaderHelperList = orgBiz.getEntitiesByColumn(LeaderHelp.class, "family", f);
				for (LeaderHelp lh : leaderHelperList) {
					sortSet.add(lh.getLeader());
				}

				f.setLeaderList(new ArrayList<Leader>(sortSet));
				f.setLeaderHelpList(leaderHelperList);
			}
		}
	}

	private List leaderList;

	public String editFamilyMapping() {
		family = familyBFBiz.getEntityById(Family.class, family.getId());
		List list = orgBiz.getEntitiesByColumn(Leader.class, "family", family);
		family.setLeaderList(list);
		if(list != null && list.size() > 0){
			Leader l = (Leader) list.get(0);
			startDate = l.getStartDate();
		}
		List<LeaderHelp> lhList = orgBiz.getEntitiesByColumn(LeaderHelp.class, "family", family);
		if(lhList != null && lhList.size()>0){
			LeaderHelp lh = lhList.get(0);
			startDate = lh.getStartDate();
		}

		// 获取领导列表
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if (user instanceof Org) {
			leaderList = orgBiz.getEntitiesByColumn(Leader.class, "org", user);
		}
		Family f = family;
		SortedSet sortSet = new TreeSet();
		List leaderList = orgBiz.getEntitiesByColumn(Leader.class, "family", f);
		if (leaderList != null && leaderList.size() > 0)
			sortSet.addAll(leaderList);
		// 通过映射表获取
		List<LeaderHelp> leaderHelperList = orgBiz.getEntitiesByColumn(LeaderHelp.class, "family", f);
		for (LeaderHelp lh : leaderHelperList)
			sortSet.add(lh.getLeader());
		f.setLeaderList(new ArrayList<Leader>(sortSet));

		return "family_mapping_edit";
	}

	private Date startDate;
	public String saveFamilyMapping() {
		String[] s = (String[]) ActionContext.getContext().getParameters().get("startDate");
		if(s != null && s.length > 0){
			try {
				startDate = Util.getDateByTxt(s[0]);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		String[] ids = (String[]) ActionContext.getContext().getParameters().get("leaderIds");
		// 清除原有的帮扶
		family = orgBiz.getEntityById(Family.class, family.getId());
		List<Leader> leaderList = orgBiz.getEntitiesByColumn(Leader.class, "family", family);
		if (leaderList != null && leaderList.size() > 0)
			for (Leader l : leaderList) {
				l.setFamily(null);
				orgBiz.saveOrUpdateEntity(l);
			}
		List<LeaderHelp> leaderHelperList = orgBiz.getEntitiesByColumn(LeaderHelp.class, "family", family);
		if (leaderHelperList != null && leaderHelperList.size() > 0)
			for (LeaderHelp lh : leaderHelperList) {
				orgBiz.deleteEntity(LeaderHelp.class, lh.getId());
			}

		if (ids != null && ids.length > 0) {
			for (String id : ids) {
				Leader leader = orgBiz.getEntityById(Leader.class, Long.parseLong(id));
				leader.setFamily(family);
				leader.setStartDate(startDate);
				orgBiz.saveOrUpdateEntity(leader);

				// 保存映射
				List<LeaderHelp> lhList = familyBFBiz.getEntitiesByTwoColumn(LeaderHelp.class, "leader", leader, "family", family);
				if (lhList == null || lhList.size() == 0) {
					LeaderHelp lh = new LeaderHelp();
					lh.setFamily(family);
					lh.setLeader(leader);
					lh.setStartDate(startDate);
					orgBiz.saveOrUpdateEntity(lh);
				}
			}
		}
		this.setSucc("Y");
		this.setMsg("帮扶方式保存成功");
		return "family_mapping_edit";
	}

	// 修改申请
	private String updateReason;
	private Long currId;

	public String updateApplyChengxiao() {
		Recheck r = new Recheck();
		r.setCreateDate(new Date());
		r.setModule("户帮扶成效");
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if (user instanceof Org) {
			r.setOrg((Org) user);
		}
		r.setReason(updateReason);
		r.setRecordId(currId);
		r.setState("待审核");
		familyBFBiz.saveOrUpdateEntity(r);

		// 修改状态
		chengxiao = familyBFBiz.getEntityById(ChengxiaoFamily.class, currId);
		chengxiao.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
		familyBFBiz.saveOrUpdateEntity(chengxiao);
		cuoshi = null;

		this.setMsg("提交修改申请成功");
		return chengxiaoFamilyList();
	}

	public String updateApplyCuoshi() {
		Recheck r = new Recheck();
		r.setCreateDate(new Date());
		r.setModule("户帮扶措施");
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if (user instanceof Org) {
			r.setOrg((Org) user);
		}
		r.setReason(updateReason);
		r.setRecordId(currId);
		r.setState("待审核");
		familyBFBiz.saveOrUpdateEntity(r);

		// 修改状态
		cuoshi = familyBFBiz.getEntityById(CuoshiFamily.class, currId);
		cuoshi.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
		familyBFBiz.saveOrUpdateEntity(cuoshi);
		cuoshi = null;

		this.setMsg("提交修改申请成功");
		return cuoshiFamilyList();
	}

	public String updateApplyReason() {
		Recheck r = new Recheck();
		r.setCreateDate(new Date());
		r.setModule("户贫困原因");
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if (user instanceof Org) {
			r.setOrg((Org) user);
		}
		r.setReason(updateReason);
		r.setRecordId(currId);
		r.setState("待审核");
		familyBFBiz.saveOrUpdateEntity(r);

		// 修改状态
		reason = familyBFBiz.getEntityById(Reason.class, currId);
		reason.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
		familyBFBiz.saveOrUpdateEntity(reason);
		cuoshi = null;

		this.setMsg("提交修改申请成功");
		return reasonList();
	}

	public String updateApplyRecord() {
		Recheck r = new Recheck();
		r.setCreateDate(new Date());
		r.setModule("户帮扶内容");
		User user = (User) ActionContext.getContext().getSession().get(WebConstants.SESS_USER_OBJ);
		if (user instanceof Org) {
			r.setOrg((Org) user);
		}
		r.setReason(updateReason);
		r.setRecordId(currId);
		r.setState("待审核");
		familyBFBiz.saveOrUpdateEntity(r);

		// 修改状态
		record = familyBFBiz.getEntityById(Record.class, currId);
		record.setStatus(WebConstants.SHENHE_STATUS_PROCECING);
		familyBFBiz.saveOrUpdateEntity(record);
		cuoshi = null;

		this.setMsg("提交修改申请成功");
		return recordList();
	}

	public String getUpdateReason() {
		return updateReason;
	}

	public void setUpdateReason(String updateReason) {
		this.updateReason = updateReason;
	}

	public Long getCurrId() {
		return currId;
	}

	public void setCurrId(Long currId) {
		this.currId = currId;
	}

	public PageBean getPageBean() {
		return pageBean;
	}

	public void setPageBean(PageBean pageBean) {
		this.pageBean = pageBean;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public CuoshiFamily getCuoshi() {
		return cuoshi;
	}

	public void setCuoshi(CuoshiFamily cuoshi) {
		this.cuoshi = cuoshi;
	}

	public ChengxiaoFamily getChengxiao() {
		return chengxiao;
	}

	public void setChengxiao(ChengxiaoFamily chengxiao) {
		this.chengxiao = chengxiao;
	}

	public FamilyBFBiz getFamilyBFBiz() {
		return familyBFBiz;
	}

	public void setFamilyBFBiz(FamilyBFBiz familyBFBiz) {
		this.familyBFBiz = familyBFBiz;
	}

	public Cun getCun() {
		return cun;
	}

	public void setCun(Cun cun) {
		this.cun = cun;
	}

	public Reason getReason() {
		return reason;
	}

	public void setReason(Reason reason) {
		this.reason = reason;
	}

	public Long getLeaderId() {
		return leaderId;
	}

	public void setLeaderId(Long leaderId) {
		this.leaderId = leaderId;
	}

	public PicFamily getPic() {
		return pic;
	}

	public void setPic(PicFamily pic) {
		this.pic = pic;
	}

	public Record getRecord() {
		return record;
	}

	public void setRecord(Record record) {
		this.record = record;
	}

	public Date getFromDate() {
		return fromDate;
	}

	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	public Date getToDate() {
		return toDate;
	}

	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}

	public OrgBiz getOrgBiz() {
		return orgBiz;
	}

	public void setOrgBiz(OrgBiz orgBiz) {
		this.orgBiz = orgBiz;
	}

	public Family getFamily() {
		return family;
	}

	public void setFamily(Family family) {
		this.family = family;
	}

	public String getQueryKey() {
		return queryKey;
	}

	public void setQueryKey(String queryKey) {
		this.queryKey = queryKey;
	}

	public List getLeaderList() {
		return leaderList;
	}

	public void setLeaderList(List leaderList) {
		this.leaderList = leaderList;
	}

	public Long getZhenId() {
		return zhenId;
	}

	public void setZhenId(Long zhenId) {
		this.zhenId = zhenId;
	}

	public Long getCunId() {
		return cunId;
	}

	public void setCunId(Long cunId) {
		this.cunId = cunId;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public List<Family> getFamilyList() {
		return familyList;
	}

	public void setFamilyList(List<Family> familyList) {
		this.familyList = familyList;
	}

}
