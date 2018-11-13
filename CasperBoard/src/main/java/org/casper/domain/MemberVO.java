package org.casper.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String mid;
	private String password;
	private String mname;
	private String info;
	private boolean enabled;
	private Date regdate, updatedate;
	
	private List<AuthVO> authList;
}
