package org.casper.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.casper.domain.PageParam;
import org.casper.domain.ReplyVO;
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
public class ReplyMapperTests {

	private int[] bnoArr = { 4159, 4158, 4157, 4156, 4155 };
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1,10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
		
			vo.setBno(bnoArr[ i % 5]);
			vo.setReply("댓글 테스트" + i);
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		
		});

	}
	
	@Test
	public void testRead() {
		int targetRno = 10;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		int targetRno = 1;
		mapper.delete(targetRno);
	}
	
	@Test
	public void testModify() {
		
		int targetRno = 10;
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("Update Reply");
		
		int count = mapper.update(vo);
		log.info("UPDATE COUNT: " + count);
	}
	
	@Test
	public void testList() {
		PageParam param = new PageParam();
		
		List<ReplyVO> replies = mapper.getListWithPaging(param, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		PageParam param = new PageParam(2,5);
		List<ReplyVO> replies = mapper.getListWithPaging(param, 4157);
		replies.forEach(reply -> log.info(reply));
		
	}
	
}
