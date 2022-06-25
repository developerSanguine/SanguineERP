package com.sanguine.model;

import java.io.Serializable;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "tblproductmaster")
@IdClass(clsAllProductModel.class)
public class clsAllProductModel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public clsAllProductModel() {
	}

	public clsAllProductModel(clsAllProductModel_ID clsAllProductModel) {
	
		strClientCode = clsAllProductModel.getStrClientCode();
		strProdCode = clsAllProductModel.getStrProdCode();
	}

	

	@Column(name = "strProdCode")
	private String strProdCode;

	@Column(name = "strClientCode")
	private String strClientCode;


	@Transient
	private String strProductName;

	@Transient
	private double dblCostRM;

	
	public double getDblCostRM() {
		return dblCostRM;
	}

	public void setDblCostRM(double dblCostRM) {
		this.dblCostRM = dblCostRM;
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

	
	public String getStrProductName() {
		return strProductName;
	}

	public void setStrProductName(String strProductName) {
		this.strProductName = strProductName;
	}

	

	
}
