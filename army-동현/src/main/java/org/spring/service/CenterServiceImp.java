package org.spring.service;

import java.util.List;

import org.spring.domain.Criteria;
import org.spring.domain.FAQVO;
import org.spring.domain.FileVO;
import org.spring.domain.MenuVO;
import org.spring.domain.NoticeVO;
import org.spring.domain.QuestionsVO;
import org.spring.domain.SaleVO;
import org.spring.mapper.CenterMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class CenterServiceImp implements CenterService{
	private final CenterMapper centerMapper;

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
		log.info("혜택가져오기실행");
		return centerMapper.saleListAll();
	}

	@Override
	public List<SaleVO> searchBenefit(Criteria cri) {
		log.info("혜택검색실행");
		return centerMapper.saleList(cri);
	}

	@Override
	public List<FAQVO> FaqList(String category) {
		log.info("자주묻는질문실행");
		return centerMapper.listFAQ(category);
	}

	@Override
	public List<QuestionsVO> FqnaListAll(Criteria cri) {
		return centerMapper.questionListAll(cri);
	}

	@Override
	public List<QuestionsVO> searchFqna(String nickname, String search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public QuestionsVO selectFqna(int qno) {
		return centerMapper.showQuestion(qno);
	}

	@Override
	public int addFqna(QuestionsVO vo) {

		return centerMapper.createQuestion(vo);
	}

	@Override
	public int modifyFqna(QuestionsVO vo) {
		return centerMapper.modifyQuestion(vo);
	}

	@Override
	public int delFqna(int qno) {
		return centerMapper.removeQuestion(qno);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("페이지수확인");
		return centerMapper.getTotalCount(cri);
	}

	@Override
	public int getfqnaTotal(Criteria cri) {
		return centerMapper.getFqnaTotalCount(cri);
	}

	@Override
	public List<QuestionsVO> myFqnaList(Criteria cri) {
		System.out.println("start"+cri.getStart());
		return centerMapper.myQuestionList(cri);
	}

	@Override
	public int maxqno() {
		return centerMapper.maxQno();
	}

	@Override
	public int upload(FileVO vo) {
		return centerMapper.uploadData(vo);
	}

	@Override
	public List<FileVO> fileList(int qno) {
		System.out.println("확인용");
		return centerMapper.getFileList(qno);
	}


}
