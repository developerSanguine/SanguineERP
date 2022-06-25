package com.sanguine.model;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "tblloccustmaster")
@IdClass(clsLocCustMasterModel_ID.class)
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class clsLocCustMasterModel {
	private String strCustCode, strLocCode;
	
	@Transient
	private String strCustName;

	private String strClientCode;

	
	
	public clsLocCustMasterModel() {
	}

	public clsLocCustMasterModel(clsLocCustMasterModel_ID clsLocCustMasterModel_ID) {
		this.strCustCode = clsLocCustMasterModel_ID.getStrCustCode();
		this.strLocCode = clsLocCustMasterModel_ID.getStrLocCode();
		this.strClientCode = clsLocCustMasterModel_ID.getStrClientCode();
	}
	@Id
	@AttributeOverrides({ @AttributeOverride(name = "strCustCode", column = @Column(name = "strCustCode")), @AttributeOverride(name = "strLocCode", column = @Column(name = "strLocCode")), @AttributeOverride(name = "strClientCode", column = @Column(name = "strClientCode")) })

	@Column(name = "strCustCode")
	public String getStrCustCode() {
		return strCustCode;
	}

	public void setStrCustCode(String strCustCode) {
		this.strCustCode = strCustCode;
	}

	@Column(name = "strLocCode")
	public String getStrLocCode() {
		return strLocCode;
	}

	public void setStrLocCode(String strLocCode) {
		this.strLocCode = strLocCode;
	}

	public String getStrCustName() {
		return strCustName;
	}

	public void setStrCustName(String strCustName) {
		this.strCustName = strCustName;
	}

	public String getStrClientCode() {
		return strClientCode;
	}

	public void setStrClientCode(String strClientCode) {
		this.strClientCode = strClientCode;
	}

	
	
	private Object setDefaultValue(Object value, Object defaultValue) {
		if (value != null && (value instanceof String && value.toString().length() > 0)) {
			return value;
		} else if (value != null && (value instanceof Double && value.toString().length() > 0)) {
			return value;
		} else if (value != null && (value instanceof Integer && value.toString().length() > 0)) {
			return value;
		} else if (value != null && (value instanceof Long && value.toString().length() > 0)) {
			return value;
		} else {
			return defaultValue;
		}
	}

}
