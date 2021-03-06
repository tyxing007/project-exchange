package com.throne212.oa.dao;

import java.lang.reflect.Field;
import java.text.Collator;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import org.hibernate.Query;
import org.hibernate.Session;

import com.throne212.oa.HibernateSessionFactory;
import com.throne212.oa.common.PageBean;
import com.throne212.oa.common.Util;
import com.throne212.oa.domain.DropdownList;
import com.throne212.oa.domain.muyingworker.Worker;


public class WorkerDao {
	public Worker getWorkerById(long id) {
		Session s = HibernateSessionFactory.getSession();
		s.beginTransaction();
		Worker doc = (Worker) s.get(Worker.class, Long.valueOf(id));
		s.getTransaction().commit();
		s.close();
		return doc;
	}

	public void addNewWorker(Worker doc) {
		Session s = HibernateSessionFactory.getSession();
		s.beginTransaction();
		s.saveOrUpdate(doc);
		s.getTransaction().commit();
		s.close();
	}

	public void updateWorker(Worker doc) {
		Session s = HibernateSessionFactory.getSession();
		s.beginTransaction();
		s.saveOrUpdate(doc);
		s.getTransaction().commit();
		s.close();
	}

	public int deleteWorker(long id) {
		Session s = HibernateSessionFactory.getSession();
		s.beginTransaction();
		String hql = "delete from Worker d where d.id=?";
		int rst = s.createQuery(hql).setLong(0, id).executeUpdate();
		if (rst > 0) {
			System.out.println("删除医生注册成功");
		}
		s.getTransaction().commit();
		s.close();
		return rst;
	}

	public PageBean findWorkers(int currPage, Worker condition, Map other) {
		PageBean page = new PageBean();
		page.setPageIndex(currPage);
		page.setRowPerPage(20);

		Session s = HibernateSessionFactory.getSession();

		Object[] hqlObjArr = this.buildFilterHQL(condition, other);
		String hql = (String) hqlObjArr[0];
		List values = (List) hqlObjArr[1];

		String countHql = "select count(*) " + hql;
		Query countQuery = s.createQuery(countHql);
		for (int i = 0; i < values.size(); i++) {
			countQuery.setParameter(i, values.get(i));
		}
		Long count = (Long) countQuery.uniqueResult();
		System.out.println("记录总数为：" + count);

		if (count.longValue() > 0) {
			Query query = s.createQuery(hql);
			for (int i = 0; i < values.size(); i++) {
				query.setParameter(i, values.get(i));
			}
			query.setMaxResults(page.getRowPerPage());
			int startIndex = (currPage - 1) * page.getRowPerPage();
			query.setFirstResult(startIndex);
			page.setResultList(query.list());
		}

		page.setTotalRow(count.longValue());
		s.close();
		return page;
	}

	private Object[] buildFilterHQL(Worker condition, Map other) {
		Object[] rst = new Object[2];
		StringBuffer sb = new StringBuffer("from Worker where 1=1");
		List paramValueList = new ArrayList();
		// 构建下拉项的条件
		Field[] fs = Worker.class.getDeclaredFields();
		for (int i = 0; i < fs.length; i++) {
			Field f = fs[i];
			if (!f.isAccessible())
				f.setAccessible(true);
			try {
				if (f.get(condition) != null && DropdownList.class.isInstance(f.get(condition))) {
					DropdownList drop = (DropdownList) f.get(condition);
					if (drop.getId() != null) {
						sb.append(" and " + f.getName() + "=?");
						paramValueList.add(drop);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 性别
		if(condition.getGender() != null){
			sb.append(" and gender=?");
			paramValueList.add(condition.getGender());
		}
		// 姓名
		if(!Util.isEmpty(condition.getName())){
			sb.append(" and name like ?");
			paramValueList.add("%"+condition.getName()+"%");
		}
		// 考核子
		if(!Util.isEmpty(condition.getNo())){
			sb.append(" and no like ?");
			paramValueList.add("%"+condition.getNo()+"%");
		}
		// 年龄段
		if (other.get("startAge") != null && ((String[]) other.get("startAge")).length > 0 && !Util.isEmpty(((String[]) other.get("startAge"))[0])) {
			long startAge = Long.parseLong(((String[]) other.get("startAge"))[0]);
			Date startDate = new Date(System.currentTimeMillis() - startAge * 365 * 24 * 60 * 60 * 1000);
			sb.append(" and birthday<=?");
			paramValueList.add(startDate);
		}
		if (other.get("endAge") != null && ((String[]) other.get("endAge")).length > 0 && !Util.isEmpty(((String[]) other.get("endAge"))[0])) {
			// if (!Util.isEmpty((String) other.get("endAge"))) {
			long endAge = Long.parseLong(((String[]) other.get("endAge"))[0]);
			Date startDate = new Date(System.currentTimeMillis() - endAge * 365 * 24 * 60 * 60 * 1000);
			sb.append(" and birthday>=?");
			paramValueList.add(startDate);
		}
		// 发证日期段
		if (other.get("startPiZhunDate") != null && ((String[]) other.get("startPiZhunDate")).length > 0
				&& !Util.isEmpty(((String[]) other.get("startPiZhunDate"))[0])) {
			// if (!Util.isEmpty((String) other.get("startPiZhunDate"))) {
			try {
				Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(((String[]) other.get("startPiZhunDate"))[0]);
				sb.append(" and date>=?");
				paramValueList.add(startDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (other.get("endPiZhunDate") != null && ((String[]) other.get("endPiZhunDate")).length > 0
				&& !Util.isEmpty(((String[]) other.get("endPiZhunDate"))[0])) {
			try {
				Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(((String[]) other.get("endPiZhunDate"))[0]);
				endDate.setTime(endDate.getTime() + 24L * 60 * 60 * 1000);
				sb.append(" and date<=?");
				paramValueList.add(endDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		sb.append(" order by id desc");
		System.out.println("hql=[" + sb.toString() + "]");
		rst[0] = sb.toString();
		rst[1] = paramValueList;
		return rst;
	}

	// 数组字典
	public Map getAllDic() {
		Map rst = new TreeMap(new Comparator() {
			public int compare(Object o1, Object o2) {
				return Collator.getInstance(Locale.CHINESE).compare(o1, o2);
			}
		});
		Map entities = HibernateSessionFactory.getSessionFactory().getAllClassMetadata();
		for (Iterator it = entities.keySet().iterator(); it.hasNext();) {
			String eName = (String) it.next();
			try {
				Class clazz = Class.forName(eName);
				if (DropdownList.class.isInstance(clazz.newInstance()) && !clazz.getName().equals(DropdownList.class.getName())
						&& clazz.getPackage().getName().equals(Worker.class.getPackage().getName())) {
					Field f = clazz.getDeclaredField("componentName");
					String name = (String) f.get(clazz.newInstance());
					rst.put(clazz.getSimpleName(), name);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return rst;
	}

	public List getDicValueList(String className) {
		Session s = HibernateSessionFactory.getSession();
		String hql = "from " + className + " order by listorder";
		List list = s.createQuery(hql).list();
		s.close();
		return list;
	}

}
