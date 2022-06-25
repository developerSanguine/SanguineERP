package com.sanguine.service;

import java.util.List;
import java.util.Map;

import com.sanguine.model.clsSubGroupCategoryMasterModel;

public interface clsSubGroupCategoryMasterService {
	public void funAddUpdate(clsSubGroupCategoryMasterModel object);

	public List<clsSubGroupCategoryMasterModel> funGetList();

	public clsSubGroupCategoryMasterModel funGetObject(String code, String clientCode);

	public Map<String, String> funGetSubgroups(String GroupCode, String clientCode);

	public Map<String, String> funGetSubgroupsCombobox(String clientCode);
}
