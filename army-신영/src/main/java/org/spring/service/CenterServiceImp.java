package org.spring.service;

import java.util.List;

import org.spring.domain.FAQVO;
import org.spring.domain.MenuVO;
import org.spring.domain.NoticeVO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.SaleVO;

public class CenterServiceImp implements CenterService{

	@Override
	public List<NoticeVO> noticeListAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeVO selectNotice(int nno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<NoticeVO> searchNotice(String search, String category) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addNotice(NoticeVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int modifyNotice(NoticeVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delNotice(int nno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MenuVO> showMenu() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SaleVO> benefitListAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SaleVO> searchBenefit(String search, String category) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<FAQVO> FaqList(String category) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<QuestionsVO> FqnaListAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<QuestionsVO> searchFqna(String search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public QuestionsVO selectFqna(int qno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addFqna(QuestionsVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int modifyFqna(QuestionsVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delFqna(int qno) {
		// TODO Auto-generated method stub
		return 0;
	}

}
