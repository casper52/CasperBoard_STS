package org.casper.controller;

import org.casper.domain.AuthVO;
import org.casper.domain.MemberVO;
import org.casper.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemberController {

	@Setter(onMethod_=@Autowired)
	private MemberService service;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;
	
	
	@GetMapping("/casper/signUp")
	public void signUpGET() {
		log.info("signUp page....");
	}
	
	@PostMapping("/casper/signUp")
	public String signUpPOST(MemberVO vo, AuthVO avo, RedirectAttributes rttr) {
		log.info("signUp POST.....");
		log.info(vo);
		
		String pw = vo.getPassword();
		vo.setPassword(pwencoder.encode(pw));
		
		String mid = vo.getMid();
		avo.setMid(mid);
		
		int result = service.insert(vo);
		service.insertAuth(avo);
		log.info(result);
		
		
		rttr.addFlashAttribute("result", result == 1?"SUCCESS":"FAIL");
		
		return "redirect:/casper/customLogin";
	}
}
