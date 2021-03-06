package org.casper.mapper;

import org.casper.domain.AuthVO;
import org.casper.domain.MemberVO;

public interface MemberMapper {

	public MemberVO getMember(String mid);
	
	public int insert(MemberVO vo);
	
	public int insertAuth(AuthVO vo);
}
