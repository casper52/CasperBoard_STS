package org.casper.service;

import java.util.List;

import org.casper.domain.Board;
import org.casper.domain.PageParam;

public interface BoardService {

	public List<Board> getList(PageParam param);
	
	public int insert(Board board);
	
	public Board read(PageParam param);
	
	public int remove(PageParam param);
	
	public int modify(Board board);
	
	public int getTotal();
}
