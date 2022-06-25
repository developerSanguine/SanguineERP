package com.sanguine.dao;

import java.util.List;
import java.util.Map;



import com.sanguine.model.clsSubGroupCategoryMasterModel;


public interface clsSubGroupCategoryMasterDao {
	public void funAddUpdate(clsSubGroupCategoryMasterModel objModel);

	public List<clsSubGroupCategoryMasterModel> funGetList();

	public clsSubGroupCategoryMasterModel funGetObject(String code, String clientCode);

	public long funGetLastNo(String tableName, String masterName, String columnName);

	public Map<String, String> funGetSubgroups(String GroupCode, String clientCode);

	public Map<String, String> funGetSubgroupsCombobox(String clientCode);

}
