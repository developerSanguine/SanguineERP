package com.sanguine.dao;

import java.sql.Blob;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.sanguine.model.clsAttachDocModel;

public interface clsAttachDocDao {
	public void funSaveDoc(clsAttachDocModel objModel);

	public List<clsAttachDocModel> funListDocs(String docCode, String clientCode);

	public List funGetDoc(String code, String fileNo, String clientCode);

	public void funDeleteDoc(Long id);

	public void funDeleteAttachment(String docName, String dcode, String clientCode);
	
	public Blob funGetBlob(MultipartFile file);
}
