package com.sanguine.dao;

import java.util.List;

import com.sanguine.model.clsPurchaseReturnDtlModel;
import com.sanguine.model.clsPurchaseReturnHdModel;
import com.sanguine.model.clsPurchaseReturnTaxDtlModel;

public interface clsPurchaseReturnDao {

	public long funGetLastNo(String tableName, String masterName, String columnName);

	public void funAddPRHd(clsPurchaseReturnHdModel PRHd);

	public void funAddUpdatePRDtl(clsPurchaseReturnDtlModel PRDtl);

	public List<clsPurchaseReturnHdModel> funGetList();

	public clsPurchaseReturnHdModel funGetObject(String code, String strClientCode);

	public List funGetDtlList(String PRCode, String clientCode);

	public void funDeleteDtl(String PRCode, String clientCode);

	
	int funDeletePRTaxDtl(String PRCode, String clientCode);

	void funAddUpdatePRTaxDtl(clsPurchaseReturnTaxDtlModel objTaxDtlModel);
	
	public List funGetGRNDtlList(String GRNCode, String clientCode);
}
