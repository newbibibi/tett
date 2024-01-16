package org.spring.service;

import java.util.List;

import org.spring.domain.CalendarVO;
import org.spring.domain.UserVO;

public interface UserService {
	public int modifyInfo(UserVO vo);
	public List<CalendarVO> calenderListAll(String nickname);
	public int addCal(CalendarVO vo);
	public int modifyCal(CalendarVO vo);
	public int delCal(int Calno);
	public int delUser(String id);
}
