package org.spring.controller;

import java.util.List;

import org.spring.domain.Criteria;
import org.spring.domain.PageDTO;
import org.spring.domain.QuestionsVO;
import org.spring.service.AdminService;
import org.spring.service.CenterService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
@Log4j
public class AdminController {
	private final AdminService adminService;
	private final CenterService centerService;
	
	@GetMapping("/adminFqna")
	public void adminFqna(Criteria cri,Model model) {
		int total = centerService.getfqnaTotal(cri);
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker",pageResult);
	}
	
	@ResponseBody
	@RequestMapping(value="/adminFqnaList",method=RequestMethod.POST)
	public List<QuestionsVO> getFqnaList(Criteria cri){
		return centerService.FqnaListAll(cri);
	}
	
	@GetMapping("/fqnaAnswer")
	public void fqnaAnswer(Integer qno, Model model) {
		QuestionsVO vo = centerService.selectFqna(qno);
		model.addAttribute("board",vo);
	}
	
	@PostMapping("/fqnaAnswer")
	public String fqnaAnswerModify(QuestionsVO vo, RedirectAttributes rttr) {
		int num = adminService.updateAnswer(vo);
		return "redirect:/admin/adminFqna";
	}
	
}
