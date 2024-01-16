package org.spring.controller;

import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.spring.domain.Criteria;
import org.spring.domain.FAQVO;
import org.spring.domain.FileVO;
import org.spring.domain.PageDTO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.SaleVO;
import org.spring.service.CenterService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/center/*")
@AllArgsConstructor
@Log4j
public class CenterController {
	private final CenterService centerService;
	
	@GetMapping("/information/benefit")
	public void benefitlist(Criteria cri ,Model model) {
		log.info("benefit시작");
		int total = centerService.getTotal(cri);
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		log.info(pageResult);
	}
	
	@ResponseBody
	@RequestMapping(value="/information/getList",method = RequestMethod.POST)
	public List<SaleVO> getbenefitlist(Criteria cri){
		log.info("getbenefitlist Ajax실행");
		log.info("start값 : "+cri.getStart());
		return centerService.searchBenefit(cri);
	}
	
	@GetMapping("/cscenter/faq")
	public void faqlist() {
		
	}
	
	@ResponseBody
	@RequestMapping(value="/cscenter/faqList",method = RequestMethod.POST)
	public List<FAQVO> getFAQlist(String category){
		log.info("getfaqlist Ajax실행");
		return centerService.FaqList(category);
	}
	
	@GetMapping("/cscenter/fqna")
	public void fqnalist(Criteria cri ,Model model) {
		cri.setNickname("홍길동");
		// 닉네임가져오는 부분은 나중에 수정
		int total = centerService.getfqnaTotal(cri);
		log.info("nickname : " +cri.getNickname());
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
	}
	
	@ResponseBody
	@RequestMapping(value="/cscenter/fqnaList",method = RequestMethod.POST)
	public List<QuestionsVO> getFqnalist(Criteria cri){
		log.info("getfqnalist Ajax실행");
		log.info("nickname : "+cri.getNickname());
		log.info("start값 : "+cri.getStart());
		return centerService.myFqnaList(cri);
	}
	
	@GetMapping("/cscenter/fqnaRegister")
	public void fqnaRegisterPage() {
		
	}
	
	@PostMapping("/cscenter/fqnaRegister")
	public String fqnaRegister(QuestionsVO vo, RedirectAttributes rttr) {
		int num = centerService.addFqna(vo);
		rttr.addFlashAttribute("alert", num);
		return "redirect:/center/cscenter/fqna";
	}
	
	@GetMapping({"/cscenter/fqnaSelect","/cscenter/fqnaModify"})
	public void fqnaSelect(Integer qno, Model model) {
		QuestionsVO vo = centerService.selectFqna(qno);
		model.addAttribute("board",vo);
	}
	
	@PostMapping("/cscenter/fqnaModify")
	public String fqnaModify(QuestionsVO vo , RedirectAttributes rttr) {
		int num = centerService.modifyFqna(vo);
		return "redirect:/center/cscenter/fqna";
	}
	@GetMapping("/cscenter/fqnaRemove")
	public String fqnaRemove(Integer qno,RedirectAttributes rttr) {
		int num = centerService.delFqna(qno);
		return "redirect:/center/cscenter/fqna";
	}
	
	@ResponseBody
	@RequestMapping(value="/cscenter/fqnaFile",method = RequestMethod.POST)
	public List<FileVO> fqnaFile(Integer qno){
		log.info("qno : " +qno);
		return centerService.fileList(qno);
	}
	
	@ResponseBody
	@RequestMapping(value = "/file-upload", method = RequestMethod.POST)
	public String fileUpload(
			@RequestParam("article_file") List<MultipartFile> multipartFile
			, HttpServletRequest request , Integer qno) {
		log.info("qno : "+qno);
		try {
	        Thread.sleep(1000); // 1000 milliseconds = 1 second
	    } catch (InterruptedException e) {
	        Thread.currentThread().interrupt();
	    }
		if(qno==null) {
			qno = centerService.maxqno();
		}
		log.info("qno : "+qno);
		String strResult = "{ \"result\":\"FAIL\" }";
//		ServletContext context = request.getServletContext();
		String context = "C:/Users/keduit/git/DangGun/army/src/main/webapp/";

		// 가상 경로에 대한 실제 경로 가져오기
//		String contextRoot = context.getRealPath("/");
		String fileRoot;
		try {
			// 파일이 있을때 탄다.
			if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				
				for(MultipartFile file:multipartFile) {
					fileRoot = context + "resources/upload/";
					System.out.println("fileRoot : "+fileRoot);
					
					String originalFileName = file.getOriginalFilename();	//오리지날 파일명
					String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
					String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
					
					FileVO vo = new FileVO(savedFileName, fileRoot, extension, qno);
					centerService.upload(vo);
					File targetFile = new File(fileRoot + savedFileName);	
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); //파일 저장
						
					} catch (Exception e) {
						//파일삭제
						FileUtils.deleteQuietly(targetFile);	//저장된 현재 파일 삭제
						e.printStackTrace();
						break;
					}
				}
				strResult = "{ \"result\":\"OK\" }";
			}
			// 파일 아무것도 첨부 안했을때 탄다.(게시판일때, 업로드 없이 글을 등록하는경우)
			else
				strResult = "{ \"result\":\"OK\" }";
		}catch(Exception e){
			e.printStackTrace();
		}
		return strResult;
	}

}
