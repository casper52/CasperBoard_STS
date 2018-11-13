package org.casper.service;

import org.casper.domain.AuthVO;
import org.casper.domain.MemberVO;

public interface MemberService {

	public int insert(MemberVO vo);
	
	public int insertAuth(AuthVO vo);
}
