package org.spring.mapper;

import java.util.List;

import org.spring.domain.QuestionsVO;
import org.spring.domain.ReportVO;
import org.spring.domain.UserVO;

public interface AdminMapper {
	public UserVO showProfile();
	public List<UserVO> listUser();
	public List<ReportVO> listReport();
	public int ban(UserVO vo);
	public List<QuestionsVO> listQ();
	public int answerQ(QuestionsVO vo);
}
