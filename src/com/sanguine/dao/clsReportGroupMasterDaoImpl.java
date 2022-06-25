package com.sanguine.dao;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sanguine.model.clsBomHdModel;
import com.sanguine.model.clsReportGroupMasterModel;
import com.sanguine.model.clsReportGroupMaster_ID;

@Repository("clsReportGroupMasterDao")
public class clsReportGroupMasterDaoImpl implements clsReportGroupMasterDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void funAddUpdateReportGrp(clsReportGroupMasterModel object) {
		sessionFactory.getCurrentSession().save(object);

	}
	
	

	@SuppressWarnings("unchecked")
	@Override
	public List<clsReportGroupMasterModel> funListProperty(String clientCode) {

		return (List<clsReportGroupMasterModel>) sessionFactory.getCurrentSession().createCriteria(clsReportGroupMasterModel.class, clientCode).list();
	}

	@SuppressWarnings("finally")
	@Override
	public long funGetLastNo(String tableName, String masterName, String columnName) {
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

	@Override
	public clsReportGroupMasterModel getProperty(String propertyCode, String clientCode, String groupCode) {

		return (clsReportGroupMasterModel) sessionFactory.getCurrentSession().get(clsReportGroupMasterModel.class, new clsReportGroupMaster_ID( clientCode , groupCode));

	}



	@Override
	public void funAddProperty(clsReportGroupMasterModel property) {
		// TODO Auto-generated method stub
		
	}

}
