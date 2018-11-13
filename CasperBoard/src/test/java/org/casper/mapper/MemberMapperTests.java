package org.casper.mapper;

import org.casper.domain.AuthVO;
import org.casper.domain.MemberVO;
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
public class MemberMapperTests {

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Test
	public void testRead() {
		
		MemberVO vo = mapper.getMember("user10");
		log.info(vo);
		
		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
	
	@Test
	public void testInsert() {
		MemberVO vo = new MemberVO();
		
		vo.setMid("CASPER");
		vo.setPassword("0502");
		vo.setMname("박가영");
		vo.setInfo("ㅎㅎ");
		
		log.info(mapper.insert(vo));
	}

	
}
