package org.casper.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Board {

	private Integer bno;
	private String title, content, mid;
	private Date regdate, updatedate;
	
	private List<BoardAttachVO> attachList;
}
