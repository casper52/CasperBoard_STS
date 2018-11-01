package org.casper.mapper;

import org.casper.domain.Board;
import org.casper.domain.PageParam;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {


	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testAll() {
		PageParam param = new PageParam();
		log.info(mapper.getList(param));
		mapper.getList(param).forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		Board board = new Board();
		
		board.setTitle("MapperTest title");
		board.setContent("MapperTest content");
		board.setMid("user00");
		
		log.info(mapper.insert(board));
	}
	
	@Test
	public void testRead() {
		PageParam param = new PageParam();
		log.info(mapper.read(param));
		
	}
	
	@Test
	public void testRemove() {
		PageParam param = new PageParam();
		log.info(mapper.remove(param));
	}
	
	@Test
	public void testModify() {
		Board board = new Board();
		
		board.setTitle("제목수정테스트");
		board.setContent("내용수정테스트");
		board.setBno(10);
		
		log.info(mapper.modify(board));
	}

	@Test
	public void testSearch() {
		PageParam param = new PageParam();
		param.setType("tc");
		param.setKeyword("근데");
		
		log.info(mapper.getList(param));
		
		mapper.getList(param).forEach(board -> log.info(board));
		
		log.info("--------------------");
		log.info("COUNT: " + mapper.count());
	}
}
