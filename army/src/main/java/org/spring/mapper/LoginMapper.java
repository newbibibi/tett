package org.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.spring.domain.UserVO;

public interface LoginMapper {
	public int create(UserVO vo);
	public String findID(String email);
	public int modify(UserVO vo);
	public int confirmLogin(UserVO vo);
	public int snsCheck(String snsID);
	public int nickCheck(String nick);
	public int idCheck(String id);
	public int emailCheck(String email);
	public int userRegister(UserVO vo);
	public List<UserVO> getAllUser();
	public UserVO getUser(@Param("type") String type, @Param("value") String value);
}
