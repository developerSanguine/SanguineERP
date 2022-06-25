package com.sanguine.bean;
import org.hibernate.validator.constraints.NotEmpty;

public class clsSubGroupCategoryMasterBean{
//Variable Declaration


	private long intSGCId;
	private String strSGCCode;
	private String strSGCode;

	
	private String strSGCName;

	private String strSGCDesc;

	
	private String strUserCreated;

	private String strUserModified;

	private String strClientCode;

//Setter-Getter Methods
	

	
	public String getStrSGCCode() {
		return strSGCCode;
	}
	public void setStrSGCCode(String strSGCCode) {
		this.strSGCCode = strSGCCode;
	}
	public String getStrSGCode() {
		return strSGCode;
	}
	public void setStrSGCode(String strSGCode) {
		this.strSGCode = strSGCode;
	}
	
	public long getIntSGCId() {
		return intSGCId;
	}
	public void setIntSGCId(long intSGCId) {
		this.intSGCId = intSGCId;
	}
	public String getStrSGCName() {
		return strSGCName;
	}
	public void setStrSGCName(String strSGCName) {
		this.strSGCName = strSGCName;
	}
	public String getStrSGCDesc() {
		return strSGCDesc;
	}
	public void setStrSGCDesc(String strSGCDesc) {
		this.strSGCDesc = strSGCDesc;
	}
	public String getStrUserCreated(){
		return strUserCreated;
	}
	public void setStrUserCreated(String strUserCreated){
		this.strUserCreated=strUserCreated;
	}

	public String getStrUserModified(){
		return strUserModified;
	}
	public void setStrUserModified(String strUserModified){
		this.strUserModified=strUserModified;
	}

	public String getStrClientCode(){
		return strClientCode;
	}
	public void setStrClientCode(String strClientCode){
		this.strClientCode=strClientCode;
	}



}
