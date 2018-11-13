package org.casper.service;

import java.util.List;

import org.casper.domain.Board;
import org.casper.domain.BoardAttachVO;
import org.casper.domain.PageParam;
import org.casper.mapper.BoardAttachMapper;
import org.casper.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;



@Service
@Log4j
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;

	@Override
	public List<Board> getList(PageParam param) {
		
		return mapper.getList(param);
	}

	@Transactional
	@Override
	public int insert(Board board) {
		
		int result = mapper.insert(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return result;
		}
		
		board.getAttachList().forEach(attach ->{
			log.info(board);
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		return result;
	}

	@Override
	public Board read(PageParam param) {
		
		return mapper.read(param);
	}

	@Transactional
	@Override
	public int remove(PageParam param) {
		
		attachMapper.deleteall(param.getBno());
		return mapper.remove(param);
	}

	@Transactional
	@Override
	public int modify(Board board) {
		
		
		attachMapper.deleteall(board.getBno());
		boolean modifyResult = mapper.modify(board) == 1;
		
		if(modifyResult && ( board.getAttachList() != null && board.getAttachList().size() > 0) ) {
			board.getAttachList().forEach(attach -> {
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return mapper.modify(board);
	}

	@Override
	public int getTotal() {
		
		return mapper.count();
	}

	@Override
	public List<BoardAttachVO> getAttachList(int bno) {
		
		return attachMapper.findByBno(bno);
	}
	
	
	
	
	
	
}
