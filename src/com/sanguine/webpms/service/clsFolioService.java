package com.sanguine.webpms.service;

import java.util.List;

import com.sanguine.model.clsPropertyMaster;
import com.sanguine.webpms.model.clsFolioDtlBackupModel;
import com.sanguine.webpms.model.clsFolioDtlModel;
import com.sanguine.webpms.model.clsFolioHdModel;

public interface clsFolioService {
	public void funAddUpdateFolioHd(clsFolioHdModel objHdModel);

	public clsFolioHdModel funGetFolioList(String folioNo, String clientCode, String propertyCode);

	public List funGetParametersList(String sqlParameters);
	
	public void funAddDocNo(clsFolioDtlModel docNo);

	void funAddUpdateFolioBackupDtl(clsFolioDtlBackupModel objHdModel);

	

	
}
