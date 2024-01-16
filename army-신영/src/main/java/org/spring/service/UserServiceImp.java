package org.spring.service;

import java.util.List;

import org.spring.domain.CalendarVO;
import org.spring.domain.UserVO;

public class UserServiceImp implements UserService{

	@Override
	public int modifyInfo(UserVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<CalendarVO> calenderListAll(String nickname) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addCal(CalendarVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int modifyCal(CalendarVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delCal(int Calno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delUser(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}
