package org.spring.service;

import java.util.List;

import org.spring.domain.SnsAuthResponse;
import org.spring.domain.SnsTokenResponse;
import org.spring.domain.UserVO;
import org.spring.mapper.LoginMapper;
import org.spring.util.RestApiUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImp implements LoginService{
	@Autowired
	LoginMapper mapper;
	
	@Override
	public int userRegister(UserVO vo) {
		return mapper.userRegister(vo);
	}

	@Override
	public String getAuthLink(String portal) {
		return RestApiUtil.AuthLinkMaker(portal);
	}

	@Override
	public SnsTokenResponse getToken(String portal, SnsAuthResponse response) {
		// TODO Auto-generated method stub
		return RestApiUtil.getToken(portal,response);
	}

	@Override
	public String getUserData(String portal, SnsTokenResponse response) {
		return RestApiUtil.getUserData(portal, response);
	}

	@Override
	public int snsLogin(String snsID) {
		return mapper.snsCheck(snsID);
	}

	@Override
	public List<UserVO> getAllUser() {
		// TODO Auto-generated method stub
		return mapper.getAllUser();
	}

	@Override
	public UserVO getUser(String type, String value) {
		// TODO Auto-generated method stub
		return mapper.getUser(type,value);
	}

	@Override
	public String checkEmail(String email) {
		return RestApiUtil.gmailSender(email);
	}

}
