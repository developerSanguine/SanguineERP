package com.sanguine.bean;


import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

import com.sanguine.model.*;

public class clsReportGroupMasterBean {
	
	private String strGCode;
	
	private String strPropertyCode;
	
	private String strPropertyName;
	
	private String strGName;
	private List<clsPropertyMaster> listPropertyDtlModel;
	
	public String getStrGName() {
		return strGName;
	}
	public void setStrGName(String strGName) {
		this.strGName = strGName;
	}
	
	public String getStrGCode() {
		return strGCode;
	}
	public void setStrGCode(String strGCode) {
		this.strGCode = strGCode;
	}
	
	public String getStrPropertyCode() {
		return strPropertyCode;
	}
	public void setStrPropertyCode(String strPropertyCode) {
		this.strPropertyCode = strPropertyCode;
	}
	
	public String getStrPropertyName() {
		return strPropertyName;
	}
	public void setStrPropertyName(String strPropertyName) {
		this.strPropertyName = strPropertyName;
	}


	public List<clsPropertyMaster> getListPropertyDtlModel() {
		return listPropertyDtlModel;
	}
	public void setListPropertyDtlModel(
			List<clsPropertyMaster> listPropertyDtlModel) {
		this.listPropertyDtlModel = listPropertyDtlModel;
	}


}
