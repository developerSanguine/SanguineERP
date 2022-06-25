package com.sanguine.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sanguine.dao.clsSubGroupCategoryMasterDao;

import com.sanguine.model.clsSubGroupCategoryMasterModel;


@Service("objSubGrpMasterService1")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class clsSubGroupCategoryMasterServiceImpl implements clsSubGroupCategoryMasterService {
	@Autowired
	private clsSubGroupCategoryMasterDao objSubGrpMasterDao1;

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public List<clsSubGroupCategoryMasterModel> funGetList() {
		return objSubGrpMasterDao1.funGetList();
	}

	public clsSubGroupCategoryMasterModel funGetObject(String code, String clientCode) {
		return objSubGrpMasterDao1.funGetObject(code, clientCode);
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public void funAddUpdate(clsSubGroupCategoryMasterModel objModel) {

		objSubGrpMasterDao1.funAddUpdate(objModel);
	}

	public long funGetLastNo(String tableName, String masterName, String columnName) {
		return objSubGrpMasterDao1.funGetLastNo(tableName, masterName, columnName);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public Map<String, String> funGetSubgroups(String GroupCode, String clientCode) {

		return objSubGrpMasterDao1.funGetSubgroups(GroupCode, clientCode);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public Map<String, String> funGetSubgroupsCombobox(String clientCode) {
		return objSubGrpMasterDao1.funGetSubgroupsCombobox(clientCode);
	}
}
