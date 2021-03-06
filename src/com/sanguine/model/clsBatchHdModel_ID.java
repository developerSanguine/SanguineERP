package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
@SuppressWarnings("serial")
public class clsBatchHdModel_ID implements Serializable {

	private String strTransCode;
	private String strProdCode;
	private String strClientCode;
	private String strBatchCode;
	public clsBatchHdModel_ID() {
	}

	public clsBatchHdModel_ID(String strTransCode, String strProdCode, String strClientCode, String strBatchCode) {
		this.strTransCode = strTransCode;
		this.strProdCode = strProdCode;
		this.strClientCode = strClientCode;
		this.strBatchCode= strBatchCode;
	}

	@Override
	public boolean equals(Object obj) {
		clsBatchHdModel_ID Batchobj = (clsBatchHdModel_ID) obj;
		if (this.strTransCode.equals(Batchobj.getStrTransCode()) && this.strProdCode.equals(Batchobj.getStrProdCode()) && this.strClientCode.equals(Batchobj.getStrClientCode()) && this.strBatchCode.equals(Batchobj.getStrBatchCode())) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.strTransCode.hashCode() + this.strProdCode.hashCode() + this.strClientCode.hashCode();
	}

	public String getStrTransCode() {
		return strTransCode;
	}

	public void setStrTransCode(String strTransCode) {
		this.strTransCode = strTransCode;
	}

	public String getStrProdCode() {
		return strProdCode;
	}

	public void setStrProdCode(String strProdCode) {
		this.strProdCode = strProdCode;
	}

	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	public String getStrBatchCode() {
		return strBatchCode;
	}

	public void setStrBatchCode(String strBatchCode) {
		this.strBatchCode = strBatchCode;
	}

}
