package org.spring.service;

import org.spring.domain.UserVO;

public interface LoginService {
	public int userRegister(UserVO vo);
	public int userLogin(String id, String pwd);
	public int snsLogin(String sns);
	public String searchID(String email);
}
