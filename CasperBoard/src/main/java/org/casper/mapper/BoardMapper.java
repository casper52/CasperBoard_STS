package org.casper.mapper;

import java.util.List;

import org.casper.domain.Board;
import org.casper.domain.PageParam;

public interface BoardMapper {

	public List<Board> getList(PageParam param);
	
	public int insert(Board board);
	
	public void insertSelectKey(Board board);
	
	public Board read(PageParam param);
	
	public int remove(PageParam param);
	
	public int modify(Board board);
	
	public int count();
	
}
