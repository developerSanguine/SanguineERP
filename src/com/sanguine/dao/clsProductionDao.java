package com.sanguine.dao;

import java.util.List;

import com.sanguine.model.clsProductionDtlModel;
import com.sanguine.model.clsProductionHdModel;

public interface clsProductionDao {
	public long funGetLastNo(String tableName, String masterName, String columnName);

	public boolean funAddPDHd(clsProductionHdModel PDHd);

	public void funAddUpdatePDDtl(clsProductionDtlModel PDDtl);

	public List<clsProductionHdModel> funGetList();

	public clsProductionHdModel funGetObject(String code, String clientCode);

	public List<clsProductionDtlModel> funGetDtlList(String PDCode, String clientCode);

	public void funDeleteDtl(String PDCode, String clientCode);

	public List funGetWOHdData(String workOrderCode, String clientCode);

	public int funUpdateWorkOrderStatus(String strWOCode, String strStatus, String strUser, String dteModifieddate, String strClientCode);

	public Double funGetPdProdQty(String workOrderCode, String ProdCode, String clientCode);

	public List funGetWorkOrdersComplete(String[] woCodes, String clientCode);
}
