package com.throne212.siliao.action;

import java.util.ArrayList;
import java.util.List;

import com.opensymphony.xwork2.ActionContext;
import com.throne212.siliao.biz.BaseBiz;
import com.throne212.siliao.common.WebConstants;
import com.throne212.siliao.domain.Area;
import com.throne212.siliao.domain.AreaAccount;
import com.throne212.siliao.domain.Factory;
import com.throne212.siliao.domain.Farm;
import com.throne212.siliao.domain.ManagerAccount;
import com.throne212.siliao.domain.Provider;
import com.throne212.siliao.domain.ProviderAccount;

public class AjaxAction extends BaseAction {

	private BaseBiz baseBiz;

	public BaseBiz getBaseBiz() {
		return baseBiz;
	}

	public void setBaseBiz(BaseBiz baseBiz) {
		this.baseBiz = baseBiz;
	}

	public String test() {
		return "msg";
	}

	// 获取所有的管区
	private List list;

	public String getAllArea() {
		list = baseBiz.getAll(Area.class, "id", "asc");
		return "area_list";
	}

	public String getRoleList() {
		list = new ArrayList();
		list.add(WebConstants.USER_NAME_ADMIN);
		list.add(WebConstants.USER_NAME_AREA);
		list.add(WebConstants.USER_NAME_PROVIDER);
		list.add(WebConstants.USER_NAME_MANAGER);
		return "role_list";
	}

	// 获取所有的农场
	public String getAllFarm() {
		list = baseBiz.getAll(Farm.class, "id", "asc");
		return "farm_list";
	}

	public String getManagerList() {
		list = baseBiz.getAll(ManagerAccount.class, "id", "asc");
		return "list";
	}

	public String getAreaAccountList() {
		list = baseBiz.getAll(AreaAccount.class, "id", "asc");
		return "list";
	}

	public String getFarmTypeList() {
		list = new ArrayList();
		list.add(WebConstants.FARM_TYPE_AREA);
		list.add(WebConstants.FARM_TYPE_FARM);
		return "type_list";
	}

	// 获取农场和供应厂
	public String getFarmAndProviders() {
		List farmList = baseBiz.getAll(Farm.class, "id", "asc");
		List providerList = baseBiz.getAll(Provider.class, "id", "asc");
		farmList.addAll(providerList);
		list = farmList;
		return "farm_provider_list";
	}

	public String getFarm() {
		list = baseBiz.getAll(Farm.class, "id", "asc");
		return "farm_provider_list";
	}

	public String getProvider() {
		list = baseBiz.getAll(Provider.class, "id", "asc");
		return "farm_provider_list";
	}

	public String queryRateName() {
		String[] q = (String[]) ActionContext.getContext().getParameters().get("q");
		if (q != null && q.length > 0 && q[0] != null) {
			String key = q[0].trim();
			List farmList = baseBiz.getAllLike(Farm.class, "name", key);
			List proList = baseBiz.getAllLike(Provider.class, "name", key);
			list = new ArrayList();
			if (farmList != null && farmList.size() > 0) {
				list.addAll(farmList);
			}
			if (proList != null && proList.size() > 0) {
				list.addAll(proList);
			}
		}
		return "list";
	}

	public String queryFarmAbsName() {
		String[] q = (String[]) ActionContext.getContext().getParameters().get("q");
		if (q != null && q.length > 0 && q[0] != null) {
			String key = q[0].trim();
			List farmList = baseBiz.getAllLike(Farm.class, "name", key);
			List areaList = baseBiz.getAllLike(Area.class, "name", key);
			list = new ArrayList();
			if (farmList != null && farmList.size() > 0) {
				list.addAll(farmList);
			}
			if (areaList != null && areaList.size() > 0) {
				list.addAll(areaList);
			}
		}
		return "list";
	}

	public String queryFactoryAbsName() {
		String[] q = (String[]) ActionContext.getContext().getParameters().get("q");
		if (q != null && q.length > 0 && q[0] != null) {
			String key = q[0].trim();
			List factoryList = baseBiz.getAllLike(Factory.class, "name", key);
			List providerList = baseBiz.getAllLike(Provider.class, "name", key);
			list = new ArrayList();
			if (factoryList != null && factoryList.size() > 0) {
				list.addAll(factoryList);
			}
			if (providerList != null && providerList.size() > 0) {
				list.addAll(providerList);
			}
		}
		return "list";
	}
	
	public String getFactoryTypeList() {
		list = new ArrayList();
		list.add(WebConstants.FACTORY_TYPE_FACTORY);
		list.add(WebConstants.FACTORY_TYPE_PROVIDER);
		return "type_list";
	}
	
	public String getProviderAccountList(){
		list = baseBiz.getAll(ProviderAccount.class, "id", "asc");
		return "list";
	}
	
	public String getFactoryList() {
		list = baseBiz.getAll(Factory.class, "id", "asc");
		return "list";
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

}
