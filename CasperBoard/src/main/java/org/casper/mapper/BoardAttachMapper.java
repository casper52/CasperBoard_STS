package org.casper.mapper;

import java.util.List;

import org.casper.domain.BoardAttachVO;


public interface BoardAttachMapper {

	public int insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(int bno);
	
	public void deleteall(int bno);
}
