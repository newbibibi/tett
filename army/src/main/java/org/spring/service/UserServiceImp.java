package org.spring.service;

import java.util.List;

import org.spring.domain.CalendarVO;
import org.spring.domain.UserVO;
import org.spring.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserServiceImp implements UserService{
	@Autowired
	UserMapper mapper;
	
	@Override
	public int modifyInfo(String col,String val, String key) {
		return mapper.modifyUser(col, val, key);
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
