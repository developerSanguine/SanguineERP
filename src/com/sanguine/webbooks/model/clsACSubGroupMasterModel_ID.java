package com.sanguine.webbooks.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
@SuppressWarnings("serial")
public class clsACSubGroupMasterModel_ID implements Serializable{

//Variable Declaration
	@Column(name="strSubGroupCode")
	private String strSubGroupCode;

	@Column(name="strClientCode")
	private String strClientCode;

	public clsACSubGroupMasterModel_ID(){}
	public clsACSubGroupMasterModel_ID(String strSubGroupCode,String strClientCode){
		this.strSubGroupCode=strSubGroupCode;
		this.strClientCode=strClientCode;
	}

//Setter-Getter Methods
	public String getStrSubGroupCode(){
		return strSubGroupCode;
	}
	public void setStrSubGroupCode(String strSubGroupCode){
		this. strSubGroupCode = strSubGroupCode;
	}

	public String getStrClientCode(){
		return strClientCode;
	}
	public void setStrClientCode(String strClientCode){
		this. strClientCode = strClientCode;
	}


//HashCode and Equals Funtions
	@Override
	public boolean equals(Object obj) {
		clsACSubGroupMasterModel_ID objModelId = (clsACSubGroupMasterModel_ID)obj;
		if(this.strSubGroupCode.equals(objModelId.getStrSubGroupCode())&& this.strClientCode.equals(objModelId.getStrClientCode())){
			return true;
		}
		else{
			return false;
		}
	}

	@Override
	public int hashCode() {
		return this.strSubGroupCode.hashCode()+this.strClientCode.hashCode();
	}

}
