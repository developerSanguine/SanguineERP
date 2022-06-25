package com.sanguine.dao;

import java.util.List;

import com.sanguine.model.clsBomHdModel;
import com.sanguine.model.clsReportGroupMasterModel;

public interface clsReportGroupMasterDao {
	
	public void funAddProperty(clsReportGroupMasterModel property);

	public List<clsReportGroupMasterModel> funListProperty(String clientCode);

	public clsReportGroupMasterModel getProperty(String propertyCode, String clientCode , String groupcode);

	public long funGetLastNo(String tableName, String masterName, String columnName);
	
	public void funAddUpdateReportGrp(clsReportGroupMasterModel object);

}
