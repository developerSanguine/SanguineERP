package com.sanguine.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sanguine.dao.clsReportGroupMasterDao;
import com.sanguine.model.clsReportGroupMasterModel;

@Service("objReportGroupMasterService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class clsReportGroupMasterServiceImpl implements clsReportGroupMasterService {

	@Autowired
	private clsReportGroupMasterDao objReportGroupMasterDao;

	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public List<clsReportGroupMasterModel> funListProperty(String clientCode) {

		return objReportGroupMasterDao.funListProperty(clientCode);
	}

	@Override
	public clsReportGroupMasterModel funGetProperty(String strPropertyCode, String clientCode , String groupcode) {

		return objReportGroupMasterDao.getProperty(strPropertyCode, clientCode , groupcode);
	}

	public long funGetLastNo(String tableName, String masterName, String columnName) {
		return objReportGroupMasterDao.funGetLastNo(tableName, masterName, columnName);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public void funAddUpdateReportGrp(clsReportGroupMasterModel objHdModel) {
		// TODO Auto-generated method stub
		objReportGroupMasterDao.funAddUpdateReportGrp(objHdModel);
		
	}

	
	@Override
	public clsReportGroupMasterModel funGetGroup(String groupcode,
			String clientCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public clsReportGroupMasterModel funGetProperty(String strPropertyCode,
			String clientCode) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public List funGetList(String groupCode, String clientCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<clsReportGroupMasterModel> funListGroups(String clientCode) {
		// TODO Auto-generated method stub
		return null;
	}

/*	@Override
	public Map<String, String> funGetProperties(String clientCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<clsReportGroupMasterModel> funGetListProperty(
			String propertyCode, String clientCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String funCheckPropertyName(String propertyName, String clientCode) {
		// TODO Auto-generated method stub
		return null;
	}*/

}
