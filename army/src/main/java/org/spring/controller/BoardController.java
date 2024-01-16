package org.spring.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.spring.domain.BoardVO;
import org.spring.domain.CommentVO;
import org.spring.domain.Criteria;
import org.spring.domain.PageDTO;
import org.spring.domain.ReportVO;
import org.spring.service.Board.BoardService;
import org.spring.util.JsonUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {
	
    private final BoardService boardService;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("------- controller in list -------");
		
		if(cri.getCategory() == null) {
			cri.setCategory("best");
			cri.setType("All");
		}
		log.info(cri);
		int total = boardService.getTotal(cri); // tbl_board테이블의 모든 행의 갯수

		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		log.info("------- controller out list -------");
		log.info("total : "+ total);
		log.info(pageResult);
	}
	
	// Ajax가 호출하는 메서드, 반환 타입은 json으로 설정하라는 주석
	@ResponseBody
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	public List<BoardVO> getList(Criteria cri){
		log.info("Ajax");
		return boardService.getPostList(cri);
	}
	
	@PostMapping("/register")
	public String registerPost(HttpServletRequest request, Model model) {
	    String nickname = request.getParameter("nickname");
	    String category = request.getParameter("categoryval");
	    // 여기에서 등록 로직을 수행하거나 다른 처리를 할 수 있습니다.
	    log.info("카테고리:"+category);
	    log.info("닉:"+nickname);
	    // 닉네임을 Model에 담아서 글 등록 페이지로 이동
	    model.addAttribute("nickname", nickname);
	    model.addAttribute("category", category);
	    return "/board/register";
	}
	
	@PostMapping("/register.do")
	public String register(BoardVO vo, @RequestParam(name = "image", required = false) List<MultipartFile> files, RedirectAttributes redirectAttributes) {
	    log.info("register: " + vo);

	    List<String> fileNames = new ArrayList<>();
	    List<String> filePaths = new ArrayList<>();

	    for (MultipartFile file : files) {
	        if (!file.isEmpty()) {
	            try {
	                // 파일 처리 로직을 여기에 구현합니다.
	                String fileName = StringUtils.cleanPath(file.getOriginalFilename());
	                String filePath = boardService.saveFile(file); // 각 파일을 저장하고 경로를 받아옵니다.

	                // 파일 정보를 리스트에 추가합니다.
	                fileNames.add(fileName);
	                filePaths.add(filePath);

	            } catch (Exception e) {
	                log.error("Failed to store file " + file.getOriginalFilename(), e);
	                // 여기서는 단순히 로깅을 하고 계속 진행합니다. 실제로는 사용자에게 오류 메시지를 반환할 수 있습니다.
	            }
	        }
	    }
	    if (!fileNames.isEmpty() && !filePaths.isEmpty()) {
	    	log.info("들어올 수 있음");
	    }
	    if (!fileNames.isEmpty() && !filePaths.isEmpty()) {
	        // 파일 정보를 BoardVO에 설정 (예시에서는 JSON 형태로 저장할 것을 가정합니다.)
	        String filesJson = null;
			try {
				filesJson = new ObjectMapper().writeValueAsString(fileNames);
				log.info("filesJson"+filesJson);
				vo.setImg(filesJson);
				log.info(vo.getImg());
				
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	    }

	    boardService.addPost(vo);
	    log.info(vo.getBno());
	    redirectAttributes.addAttribute("id", vo.getBno()); // 리다이렉트 URL에 게시물 ID를 추가합니다.

	    return "redirect:/board/view/{id}";
	}

	
	@GetMapping("/view/{id}")
	public String viewBoard(@PathVariable("id") int bno, Model model, HttpServletRequest request) {
	    // 게시물 정보 조회
		HttpSession session = request.getSession();
	    BoardVO board = boardService.getPost(bno);
	    // 게시물의 댓글 목록 조회
	    List<CommentVO> comments = boardService.getCommentList(bno);
	    
	    //조회수 증가
	    if(session.getAttribute("view" + bno) == null){
	        boardService.plusView(bno);
	        session.setAttribute("view" + bno, true); // 세션에 'view' + 게시물 ID값을 키로 하는 속성 추가
	    }
	  //(String) session.getAttribute("nickname")
	    String nickname = "d"; // 세션에서 사용자 닉네임 가져오기
	    boolean liked = boardService.isLiked(bno, nickname) >= 1 ? false:true ; // 사용자가 게시물에 좋아요를 눌렀는지 여부 확인
	    log.info("likedCnt:"+boardService.isLiked(bno, nickname));
	    // 모델에 게시물 정보와 댓글 목록 추가
	    if(!(board.getImg() == null || board.getImg().isEmpty())) {
	    	try {
		        List<String> imageList = JsonUtils.parseJsonToArray(board.getImg());
		        model.addAttribute("imageList", imageList);
		    } catch (IOException e) {
		        // JSON 파싱 실패 시 로그를 남기고, 모델에 빈 리스트를 추가하거나 에러 처리를 합니다.
		        log.error("Error parsing JSON", e);
		        model.addAttribute("imageList", Collections.emptyList());
		    }
		    
	    }
	    model.addAttribute("board", board);
	    model.addAttribute("comments", comments);
	    model.addAttribute("liked", liked);
	    log.info("liked:"+liked);
	    
	    return "board/view"; // 게시물 상세 정보와 댓글 목록을 보여주는 view 페이지 반환
	}

	
	@PostMapping("/commentAdd")
    public String addComment(CommentVO comment, RedirectAttributes redirectAttributes) {
        // 댓글 추가 로직을 구현합니다.
        // 예를 들면, boardService.addComment(comment); 와 같이 서비스 계층을 호출할 수 있습니다.
        boardService.addComment(comment);
        boardService.cntcmt(comment.getBno());
       log.info("부모:"+comment.getParentCno());
        // 댓글이 추가된 후에 원래의 게시물 상세보기 페이지로 리다이렉트합니다.
        // 댓글이 추가된 게시물의 ID를 사용하여 리다이렉트 주소를 설정합니다.
        redirectAttributes.addAttribute("id", comment.getBno());
        return "redirect:/board/view/{id}";
    }
	

	@PostMapping("/update")
	public String showEditForm(@RequestParam("bno") int bno, Model model) {
	    BoardVO board = boardService.getPost(bno); // 게시물 정보 조회
	    if (board == null) {
	        // 게시물이 없으면 사용자에게 에러 메시지를 보여주고 게시물 목록으로 리다이렉트
	        // 예: 에러 메시지를 Flash Attribute로 추가
	        return "redirect:/board/list";
	    }

	    // 이미지 정보 파싱
	    if (!(board.getImg() == null || board.getImg().isEmpty())) {
	        try {
	            List<String> imageList = JsonUtils.parseJsonToArray(board.getImg()); // JSON을 List로 변환하는 메서드 호출
	            model.addAttribute("imageList", imageList);
	        } catch (IOException e) {
	            // JSON 파싱 실패 시 로그를 남기고, 모델에 빈 리스트를 추가하거나 에러 처리를 합니다.
	            log.error("JSON 파싱 오류", e);
	            model.addAttribute("imageList", Collections.emptyList());
	        }
	    } else {
	        model.addAttribute("imageList", Collections.emptyList());
	    }

	    model.addAttribute("board", board); // 조회된 게시물 정보를 모델에 추가
	    return "board/modify"; // 게시물 수정 페이지 뷰 이름 반환
	}

	
	@PostMapping("/modify.do")
	public String modifyBoard(BoardVO board, @RequestParam(name = "image", required = false) List<MultipartFile> files, RedirectAttributes redirectAttributes) {

	    log.info("익명여부: " + board.getAnonymous());
	    
	    List<String> fileNames = new ArrayList<>();
	    List<String> filePaths = new ArrayList<>();

	    for (MultipartFile file : files) {
	        if (!file.isEmpty()) {
	            try {
	                // 파일 처리 로직을 여기에 구현합니다.
	                String fileName = StringUtils.cleanPath(file.getOriginalFilename());
	                String filePath = boardService.saveFile(file); // 각 파일을 저장하고 경로를 받아옵니다.

	                // 파일 정보를 리스트에 추가합니다.
	                fileNames.add(fileName);
	                filePaths.add(filePath);

	            } catch (Exception e) {
	                log.error("Failed to store file " + file.getOriginalFilename(), e);
	                // 여기서는 단순히 로깅을 하고 계속 진행합니다. 실제로는 사용자에게 오류 메시지를 반환할 수 있습니다.
	            }
	        }
	    }
	    
	    if (!fileNames.isEmpty() && !filePaths.isEmpty()) {
	        // 파일 정보를 BoardVO에 설정 (예시에서는 JSON 형태로 저장할 것을 가정합니다.)
	        String filesJson = null;
	        try {
	            filesJson = new ObjectMapper().writeValueAsString(fileNames);
	            log.info("filesJson" + filesJson);
	            board.setImg(filesJson);
	            log.info(board.getImg());

	        } catch (JsonProcessingException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	    }

	    // 게시물 데이터를 업데이트하는 서비스 메서드를 호출합니다.
	    boardService.modifyPost(board);

	    // 수정이 완료되면, 수정된 게시물의 상세 페이지로 리다이렉트합니다.
	    redirectAttributes.addFlashAttribute("message", "게시물이 수정되었습니다.");
	    return "redirect:/board/view/" + board.getBno();
	}

	
	// 게시물 삭제 요청을 처리하는 메서드
    @PostMapping("/delete")
    public String deleteBoard(@RequestParam("bno") int bno, RedirectAttributes redirectAttributes) {
        // 게시물 삭제 서비스 메서드 호출
        int isDeleted = boardService.delPost(bno);

        // 삭제 성공 여부에 따른 메시지 설정
        if (isDeleted == 1) {
            redirectAttributes.addFlashAttribute("message", "게시물이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "게시물 삭제에 실패했습니다.");
        }

        // 게시물 목록 페이지로 리다이렉트
        return "redirect:/board/list";
    }
    
    @PostMapping("/like")
    public String likeProcess(@RequestParam("like") String like, @RequestParam("bno") int bno, HttpSession session) {
        // 세션에서 사용자 닉네임 가져오기
        //String nickname = (String) session.getAttribute("nickname");
    	String nickname = "d";
        // "like" 값에 따라 분기 처리
        if (like.equals("like")) {
            // 좋아요 처리
        	log.info("좋아요");
            boardService.addLike(bno, nickname);
        } else if (like.equals("unlike")) {
            // 좋아요 취소 처리
        	log.info("좋아요 취소");
            boardService.removeLike(bno, nickname);
        }
        boardService.updateLikes(bno);
        // 게시물 상세 페이지로 리다이렉트
        return "redirect:/board/view/" + bno;
    }
   
    @PostMapping("/cmtUpdate")
    @ResponseBody
    public ResponseEntity<String> cmtUpdate(@RequestBody CommentVO comment) {
        try {
            boardService.modifyComment(comment);
            return new ResponseEntity<>("{\"result\":\"success\"}", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("{\"result\":\"fail\"}", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/cmtDelete")
    public String cmtDelete(CommentVO comment) {
    	int bno = comment.getBno();
    	boardService.delComment(comment.getCno());
    	boardService.cntcmt(comment.getBno());
        return "redirect:/board/view/"+ bno;
    }
    
    
   
    @ResponseBody
    @PostMapping("/likeComment")
    public Map<String, Object> likeComment(@RequestBody Map<String, Object> params) {
        Integer cno = (Integer) params.get("cno");
        String nickname = (String) params.get("nickname");
        Map<String, Object> result = new HashMap<>();
        log.info(cno+nickname);

        try {
            int likes = boardService.toggleLikeComment(cno, nickname);
            log.info(likes);
            result.put("success", true);
            result.put("likes", likes);
        } catch (Exception e) {
            result.put("success", false);
        }

        return result;
    }
    
    @PostMapping("/report")
    public String report(@ModelAttribute ReportVO reportVO) {
    	boardService.report(reportVO);
        return "redirect:/board/list";
    }
    


}	
