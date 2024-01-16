package org.spring.mapper;

import org.spring.domain.UserVO;

public interface LoginMapper {
	public int create(UserVO vo);
	public String findID(String email);
	public int modify(UserVO vo);
	public int confirmLogin(UserVO vo);
}
