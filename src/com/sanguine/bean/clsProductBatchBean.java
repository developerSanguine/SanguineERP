package com.sanguine.bean;

import java.util.List;

import com.sanguine.model.clsBatchHdModel;

public class clsProductBatchBean {

	private String strMISCode;
	private String strBatchCode;
	private List<clsBatchHdModel> listBatchDtl;

	public List<clsBatchHdModel> getListBatchDtl() {
		return listBatchDtl;
	}

	public void setListBatchDtl(List<clsBatchHdModel> listBatchDtl) {
		this.listBatchDtl = listBatchDtl;
	}

	public String getStrMISCode() {
		return strMISCode;
	}

	public void setStrMISCode(String strMISCode) {
		this.strMISCode = strMISCode;
	}

	public String getStrBatchCode() {
		return strBatchCode;
	}

	public void setStrBatchCode(String strBatchCode) {
		this.strBatchCode = strBatchCode;
	}
}
