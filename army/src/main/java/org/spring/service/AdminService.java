package org.spring.service;

import org.spring.domain.QuestionsVO;
import org.spring.domain.UserVO;

public interface AdminService {
	public int updateAnswer(QuestionsVO vo);
	public int userBan(UserVO vo);

}
