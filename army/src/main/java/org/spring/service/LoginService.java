package org.spring.service;

import java.util.List;

import org.spring.domain.SnsAuthResponse;
import org.spring.domain.SnsTokenResponse;
import org.spring.domain.UserVO;
import org.springframework.stereotype.Service;

@Service
public interface LoginService {
	// 회원 가입하기
	public int userRegister(UserVO vo);

	// 모든 유저 정보 가져오기
	public List<UserVO> getAllUser();
	
	// 일부 유저 정보 가져오기
	public UserVO getUser(String type, String value);
	
	// SNS의 DATA 가져오는 것
	public String getAuthLink(String portal);
	public SnsTokenResponse getToken(String portal, SnsAuthResponse response);
	public int snsLogin(String sns);
	public String getUserData(String portal, SnsTokenResponse response);
	// SNS 끝
	
	//이메일 랜덤 코드 발송
	public String checkEmail(String email);
	

}
