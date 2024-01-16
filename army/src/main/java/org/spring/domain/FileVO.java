package org.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FileVO {
	private int fno;
	private String filename;
	private String filepath;
	private String filetype;
	private Date uptime;
	private int qno;
	
	public FileVO(String filename, String filepath, String filetype,  int qno) {
		this.filename=filename;
		this.filepath=filepath;
		this.filetype="";
		this.qno=qno;
	}
}
