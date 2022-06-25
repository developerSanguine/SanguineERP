package com.sanguine.service;

import java.util.List;
import java.util.Map;







import com.sanguine.model.clsReportGroupMasterModel;

public interface clsReportGroupMasterService {
	

	public List<clsReportGroupMasterModel> funListProperty(String clientCode);

	public clsReportGroupMasterModel funGetGroup( String groupcode,String clientCode);
	
	public clsReportGroupMasterModel funGetProperty(String strPropertyCode,String clientCode);
	
	
	public List funGetList(String groupCode, String clientCode);

	public List<clsReportGroupMasterModel> funListGroups(String clientCode);

	clsReportGroupMasterModel funGetProperty(String strPropertyCode,String clientCode, String groupcode);

	void funAddUpdateReportGrp(clsReportGroupMasterModel object);

	

	


	
}
