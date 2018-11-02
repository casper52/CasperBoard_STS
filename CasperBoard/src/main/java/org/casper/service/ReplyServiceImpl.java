package org.casper.service;

import java.util.List;

import org.casper.domain.PageParam;
import org.casper.domain.ReplyVO;
import org.casper.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;


@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO read(int rno) {
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		return mapper.update(vo);
	}

	@Override
	public int remove(int rno) {
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(PageParam param, int bno) {
		
		return mapper.getListWithPaging(param, bno);
	}

	
}
