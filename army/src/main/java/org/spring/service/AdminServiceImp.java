package org.spring.service;

import org.spring.domain.QuestionsVO;
import org.spring.domain.UserVO;
import org.spring.mapper.AdminMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class AdminServiceImp implements AdminService{
	private final AdminMapper adminMapper;

	@Override
	public int updateAnswer(QuestionsVO vo) {
		return adminMapper.answerQ(vo);
	}

	@Override
	public int userBan(UserVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

}
