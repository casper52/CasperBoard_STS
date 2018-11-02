package org.casper.service;

import java.util.List;

import org.casper.domain.PageParam;
import org.casper.domain.ReplyPageDTO;
import org.casper.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	
	public ReplyVO read(int rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(int rno);
	
	public List<ReplyVO> getList(PageParam param, int bno);

	public ReplyPageDTO getListPage(PageParam param, int bno);
}
