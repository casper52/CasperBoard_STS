package org.casper.service;

import org.casper.domain.AuthVO;
import org.casper.domain.MemberVO;
import org.casper.mapper.MemberMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private MemberMapper mapper;

	@Override
	public int insert(MemberVO vo) {
		
		int result = mapper.insert(vo);
		return result;
	}

	@Override
	public int insertAuth(AuthVO vo) {
		
		int result = mapper.insertAuth(vo);
		return result;
	} 
	
	
	
}
