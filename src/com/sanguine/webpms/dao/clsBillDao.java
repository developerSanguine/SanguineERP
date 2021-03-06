package com.sanguine.webpms.dao;

import java.util.List;

import com.sanguine.webpms.model.clsBillDtlModel;
import com.sanguine.webpms.model.clsBillHdBackupModel;
import com.sanguine.webpms.model.clsBillHdModel;

public interface clsBillDao {

	public void funAddUpdateBillHd(clsBillHdModel objHdModel);

	public void funAddUpdateBillDtl(clsBillDtlModel objDtlModel);

	public clsBillHdModel funLoadBill(String docCode, String clientCode);

	public List<clsBillDtlModel> funLoadBillDtl(String docCode, String clientCode);

	public void funDeleteBill(clsBillHdModel objBillHdModel);
	
	public void funAddUpdateBillHdBackup(clsBillHdBackupModel objHdBackupModel);

	public clsBillHdBackupModel funLoadBillBackup(String docCode, String clientCode);

	void funDeleteBillBackup(clsBillHdBackupModel objBillHdModel);
}
