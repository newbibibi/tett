package org.spring.mapper;

import java.util.List;

import org.spring.domain.FAQVO;
import org.spring.domain.MenuVO;
import org.spring.domain.NoticeVO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.SaleVO;

public interface CenterMapper {
	public int createNotice(NoticeVO vo);
	public int modifyNotice(NoticeVO vo);
	public int removeNotice(int nno);
	public NoticeVO showNotice(int nno);
	public List<NoticeVO> noticeList(String search, String category);
	public List<NoticeVO> noticeListAll();
	public List<FAQVO> listFAQ(String category);
	public int createQuestion(QuestionsVO vo);
	public int modifyQuestion(QuestionsVO vo);
	public int removeQuestion(int qno);
	public List<MenuVO> listMenu();
	public List<SaleVO> saleListAll();
	public List<SaleVO> saleList(String search, String category);
	public List<QuestionsVO> questionListAll();
	public List<QuestionsVO> questionList(String search);
	public QuestionsVO showQuestion(int qno);
}
