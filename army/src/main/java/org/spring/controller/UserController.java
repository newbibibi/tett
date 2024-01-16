package org.spring.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.spring.domain.SnsAuthResponse;
import org.spring.domain.UserVO;
import org.spring.service.LoginService;
import org.spring.service.UserService;
import org.spring.service.UserServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user")
@Log4j
public class UserController {
	@Autowired
	private LoginService ls;
	@Autowired
	private UserService us;

	@RequestMapping("/") // user/ 시 로그인 화면으로
	public String start() {
		return "login/login";
	}

	// SNS!!!!!!!!!!!!!!!!!!!
	@RequestMapping(value = "/authReq", method = RequestMethod.GET) // SNS 버튼 눌렀을 시 해당 메서드
	public String snsLogin(@RequestParam("v") String portal) {
		// portal은 google, kakao, naver 구분자 앞 한글자 값을 받음
		String link = ls.getAuthLink(portal); // SNS 인가 사이트 URL로 이동
		log.info(link);
		return "redirect:" + link;
	}

	@RequestMapping(value = "/auth") // 위 인가 과정 완료 후 돌아오는 메서드(GET)
	public String snsAuth(@RequestParam("v") String portal, SnsAuthResponse response, Model model,
			HttpServletRequest request) { // portal은 naver, kakao, google 식별자, AuthResponse로 인가 응답값 받음
		String snsID = ls.getUserData(portal, ls.getToken(portal, response)); // ls.getToken으로 토큰 정보 받아와서
																				// ls.getUserData에 토큰 전달 후 User sns 고유
																				// 식별자 받아옴
		String url = "";
		log.info(snsID);
		if (ls.snsLogin(snsID) == 0) { // USER DB에서 sns 컬럼에 동일한 것이 있는지 확인
			url = "login/snsHide"; // 없다면 snsHide.jsp로 이동 후 바로 회원가입으로 redirect(snsID를 숨기기 위함)
			model.addAttribute("snsID", snsID);
			model.addAttribute("url", "../user/login/join");
		} else {
			url = "redirect:../user/main"; // 있다면 sns로 이미 회원가입한 회원이 있다는 뜻이므로 main page로 이동
			request.getSession().setAttribute("user", ls.getUser("sns", snsID)); // 첫번째 매개변수는 가져올 컬럼 두번째 매개변수는 비교할 값(유저
																					// VO를 세션에 저장)
		}
		return url;
	}

	@GetMapping("/main")
	public String mainGo(HttpServletRequest request) {
		log.info(request.getSession().getAttribute("user")); // user의 세션이 없으면 초기화면으로 이동됨
		if (request.getSession().getAttribute("user") != null) {
			return "/main";
		} else {
			return "/login/login";
		}
	}
	// SNS 종료!!!!!!!!!!

	// 회원가입!!!!!!!!!
	@RequestMapping(value = "/login/join") // 회원 가입 화면 이동 메서드
	public String userJoin(@RequestParam(value = "snsID", required = false) String snsID, Model model) {
		model.addAttribute("snsID", snsID);
		return "login/join";
	}

	@RequestMapping(value = "/login/sign", method = RequestMethod.POST) // 회원 가입에서 가입하기 버튼을 누르면 가입하는 메서드 가입 완료 후 main으로
																		// 이동시킴
	public String userSignup(UserVO vo, Model model, HttpServletRequest request) {
		log.info(vo);
		int result = ls.userRegister(vo);
		log.info(result);
		if (result == 1) {
			model.addAttribute("result", "입대 축하합니다.");
			request.getSession().setAttribute("user", ls.getUser("id", vo.getId()));
			return "/main";
		} else {
			model.addAttribute("result", "회원 등록 실패 관리자에게 문의 바랍니다.");
			return "redirect:user/";
		}
	}
	// 회원가입 종료!!!!!!!!!

	// 아이디/비번 찾기
	@RequestMapping("/login/find") // ID 찾기 버튼 누르면 새창으로 이동 시키기 위함
	public String findID() {
		return "login/find";
	}

	@RequestMapping("/manage") // 로그인 버튼을 누르면 ID 찾기 새창으로 이동 시키기 위히ㅏㅁ
	public String test() {
		log.info(ls.getAllUser());
		return "";
	}

	// ajax로 리턴받는 메소드들 모음(맨 아래)
	@ResponseBody
	@RequestMapping(value = "/checker", method = RequestMethod.POST)
	public UserVO duplicateCheck(@RequestParam(value = "checkValue") String value,
			@RequestParam(value = "checkColumn") String Column) { // 중복 check ajax
		return ls.getUser(Column, value);
	}

	@ResponseBody
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public int modify(@RequestBody Map<String, String> map) { // 유저 정보 다중 변경
		int result = 1;
		for (String key : map.keySet()) {
			if (!key.equals("id")) {
				result = result & us.modifyInfo(key,map.get(key),map.get("id"));
			}
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/findid", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public <T> T finder(@RequestParam(value = "checkValue") String value,
			@RequestParam(value = "checkColumn") String Column) { // 아이디 찾기 나중에 나라사랑 메일 체크 제약도 추가필요
		UserVO vo = ls.getUser(Column, value);
		HashMap<String, Object> result = new HashMap<>();
		if (vo == null) {
			result.put("id", "해당 메일로 가입한 회원이 없습니다.");
			return (T) result;
		} else {
			vo.setId("id는 " + vo.getId() + "입니다.");
			return (T) vo;
		}
	}

	@ResponseBody
	@RequestMapping("/emailauth") // 회원 가입 시 이메일 인증
	public String signUpCheckEmail(@RequestParam("email") String email) {
		String code = "";
		/*
		 * if(email.contains("@narasarang.")){ code=ls.checkEmail(email); }
		 */
		if (email != null) {
			code = ls.checkEmail(email);
		} else {
			code = "나라사랑 이메일을 입력하세요";
		}
		return code;
	}

	@RequestMapping(value = "/login/login", produces = "text/plain;charset=UTF-8") // 로그인 버튼 누르면 로그인 결과 전달
	@ResponseBody
	public String loginCheck(UserVO vo, HttpServletRequest request) {
		String result = "";

		UserVO login = ls.getUser("id", vo.getId());
		if (login != null) {
			if (login.getPw().equals(vo.getPw())) {
				result = "로그인 성공";
				request.getSession().setAttribute("user", login);
			} else {
				result = "비밀번호가 틀립니다. 다시 확인해주세요";
			}
		} else {
			result = "아이디가 존재하지 않습니다.";
		}
		log.info(result);
		return result;
	}
}
