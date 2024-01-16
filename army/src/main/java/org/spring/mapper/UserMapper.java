package org.spring.mapper;

import java.util.List;

import org.spring.domain.CalendarVO;
import org.spring.domain.UserVO;

public interface UserMapper {
	public int modifyNick(String id, String nickname);
	public int removeID(UserVO vo);
	public int modifyPwd(String id, String pwd);
	public UserVO showProfile(String id);
	public int createCal(CalendarVO vo);
	public int modifyCal(CalendarVO vo);
	public int removeCal(int calNo);
	public CalendarVO showCal(int calNo);
	public List<CalendarVO> showAllCal(String nickname);
}
