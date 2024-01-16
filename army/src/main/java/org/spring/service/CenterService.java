package org.spring.service;

import java.util.List;

import org.spring.domain.FAQVO;
import org.spring.domain.MenuVO;
import org.spring.domain.NoticeVO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.SaleVO;

public interface CenterService {
	public List<NoticeVO> noticeListAll();
	public NoticeVO selectNotice(int nno);
	public List<NoticeVO> searchNotice(String search,String category);
	public int addNotice(NoticeVO vo);
	public int modifyNotice(NoticeVO vo);
	public int delNotice(int nno);
	public List<MenuVO> showMenu();
	public List<SaleVO> benefitListAll();
	public List<SaleVO> searchBenefit(String search, String category);
	public List<FAQVO> FaqList(String category);
	public List<QuestionsVO> FqnaListAll();
	public List<QuestionsVO> searchFqna(String search);
	public QuestionsVO selectFqna(int qno);
	public int addFqna(QuestionsVO vo);
	public int modifyFqna(QuestionsVO vo);
	public int delFqna(int qno);
	
}
