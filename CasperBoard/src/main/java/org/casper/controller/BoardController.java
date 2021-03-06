package org.casper.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.casper.domain.Board;
import org.casper.domain.BoardAttachVO;
import org.casper.domain.PageParam;
import org.casper.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.jdbc.StringUtils;

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
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int bno){
		log.info("getAttachList "+bno);
		
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
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
	public void readGET(@ModelAttribute("pageObj") PageParam param, Model model, @CookieValue(value="view",required=false) String view) {
		log.info("read page.....");
		log.info(view);
		
		model.addAttribute("board", service.read(param));
		
		if(view == null) {
			service.updateView(param);
			return;
		}
		boolean check=true;
		String views[] = view.split("_");
		log.info(views);
		for(int i = 0; i < views.length; i++) {
			 String viewValue = views[i];
		
			 if(viewValue.equals(String.valueOf(param.getBno()))) {
				 log.info(check);
				check=false;
				 break;
			 }
			 
		}
		log.info(check);
		if(check==true) {
			service.updateView(param);
		}
		
		
	}

	
	@PreAuthorize("principal.username == #board.mid")
	@PostMapping("/modify")
	public String modify(PageParam param, Board board, RedirectAttributes rttr) {
		rttr.addFlashAttribute("result",service.modify(board) == 1?"SUCCESS":"FAIL");
		
		return param.getLink("redirect:/board/read");
	}
	
	@PreAuthorize("principal.username == #mid")
	@PostMapping("/remove")
	public String remove(PageParam param, RedirectAttributes rttr, String mid) {
		log.info("remove page.....");
		
		List<BoardAttachVO> attachList = service.getAttachList(param.getBno());
		int count = service.remove(param);
		
		if(count == 1) {
			
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", count == 1? "SUCCESS":"FAIL");
		}		
		return "redirect:/board/list";
	}
	
	public void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files...");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
	
	@GetMapping("/profile")
	public void profile() {
		log.info("profile page.....");
	}
	
	
}
