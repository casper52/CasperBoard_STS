package org.casper.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.casper.domain.PageParam;
import org.casper.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(int bno);
	
	public int delete(int bno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(
			@Param("pageparam") PageParam param,
			@Param("bno") int bno);
}
