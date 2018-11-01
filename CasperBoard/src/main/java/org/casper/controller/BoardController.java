package org.casper.controller;

import org.casper.domain.Board;
import org.casper.domain.PageParam;
import org.casper.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	@GetMapping("/list")
	public void list(@ModelAttribute("pageObj") PageParam param, Model model) {
		log.info("list page......");
		param.setTotal(service.getTotal());
		model.addAttribute("list",service.getList(param));
	}
	
	@GetMapping("/register")
	public void registerGET() {
		log.info("registerGET.....");
	}
	
	@PostMapping("/register")
	public String registerPOST(Board board, RedirectAttributes rttr) {
		log.info("registerPOST....");
		log.info(board);
		
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		int result = service.insert(board);
		log.info(result);
		rttr.addFlashAttribute("result",result == 1?"SUCCESS":"FAIL");
		
		return "redirect:/board/list";
	}
	
	
	@GetMapping({"/read","/modify"})
	public void readGET(@ModelAttribute("pageObj") PageParam param, Model model) {
		log.info("read page.....");
		model.addAttribute("board", service.read(param));
		
	}
	
	@PostMapping("/modify")
	public String modify(PageParam param, Board board, RedirectAttributes rttr) {
		rttr.addFlashAttribute("result",service.modify(board) == 1?"SUCCESS":"FAIL");
		
		return param.getLink("redirect:/board/read");
	}
	
	@PostMapping("/remove")
	public String remove(PageParam param, RedirectAttributes rttr) {
		log.info("remove page.....");
		
		int count = service.remove(param);
		rttr.addFlashAttribute("result", count == 1? "SUCCESS":"FAIL");
		
		return "redirect:/board/list";
	}

}