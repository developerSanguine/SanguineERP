package com.sanguine.dao;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sanguine.model.clsSubGroupCategoryMasterModel;
import com.sanguine.model.clsSubGroupCategoryMasterModel_ID;


@Repository("clsSubGroupCategoryMasterDao")
public class clsSubGroupCategoryMasterDaoImpl implements clsSubGroupCategoryMasterDao {
	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<clsSubGroupCategoryMasterModel> funGetList() {
		return (List<clsSubGroupCategoryMasterModel>) sessionFactory.getCurrentSession().createCriteria(clsSubGroupCategoryMasterModel.class).list();
	}

	public clsSubGroupCategoryMasterModel funGetObject(String code, String clientCode) {
		return (clsSubGroupCategoryMasterModel) sessionFactory.getCurrentSession().get(clsSubGroupCategoryMasterModel.class, new clsSubGroupCategoryMasterModel_ID(code, clientCode));

	}
	public void funAddUpdate(clsSubGroupCategoryMasterModel objModel) {

		sessionFactory.getCurrentSession().saveOrUpdate(objModel);

	}

	@SuppressWarnings("finally")
	public long funGetLastNo(String tableName, String masterName, String columnName)

	{
		long lastNo = 0;
		try {
			@SuppressWarnings("rawtypes")
			List listLastNo = sessionFactory.getCurrentSession().createSQLQuery("select max(" + columnName + ") from " + tableName).list();
			if (listLastNo.size() > 1) {
				lastNo = ((BigInteger) listLastNo.get(0)).longValue();
			}
			lastNo++;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			return lastNo;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, String> funGetSubgroups(String GroupCode, String clientCode) {
		Map<String, String> map = new TreeMap<String, String>();
		Query query = sessionFactory.getCurrentSession().createQuery("from clsSubGroupCategoryMasterModel where strGCode=:GroupCode and strClientCode=:clientCode");
		query.setParameter("GroupCode", GroupCode);
		query.setParameter("clientCode", clientCode);
		List<clsSubGroupCategoryMasterModel> subGroups = query.list();
		System.out.println(subGroups);
		for (clsSubGroupCategoryMasterModel subGroup : subGroups) {
			map.put(subGroup.getStrSGCCode(), subGroup.getStrSGCName());
		}
		return map;

	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, String> funGetSubgroupsCombobox(String clientCode) {
		Map<String, String> map = new TreeMap<String, String>();
		Query query = sessionFactory.getCurrentSession().createQuery("from clsSubGroupCategoryMasterModel where strClientCode=:clientCode");
		query.setParameter("clientCode", clientCode);
		List<clsSubGroupCategoryMasterModel> subGroups = query.list();
		System.out.println(subGroups);
		for (clsSubGroupCategoryMasterModel subGroup : subGroups) {
			map.put(subGroup.getStrSGCCode(), subGroup.getStrSGCName());
		}
		return map;

	}

}
