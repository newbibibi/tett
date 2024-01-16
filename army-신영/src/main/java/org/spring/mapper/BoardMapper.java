package org.spring.mapper;


import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.spring.domain.BoardVO;
import org.spring.domain.CommentVO;
import org.spring.domain.Criteria;
import org.spring.domain.LikestatusVO;
import org.spring.domain.ReportVO;
import org.springframework.web.bind.annotation.RequestParam;

public interface BoardMapper {
	
	//게시판
	public int removeBoard(int bno);

	public BoardVO selectList(int bno);

	public List<BoardVO> findList(String search);

	public int modifyBoard(BoardVO boardVo);

	public int reportBoard(ReportVO reportVo);
	
	public int createBoard(BoardVO vo);

	//댓글
	public void updateCmt(@Param("bno") int bno, @Param("cnt") int cnt);
	
	public int cntCmt(int bno);
	
	public List<CommentVO> showCmt(int bno);

	public int createCmt(CommentVO commentVo);

	public int removeCmt(int cno);

	public int modifyCmt(CommentVO commentVo);

	
	//조회수
	public int cntViews(int bno);

	//신고하기
	public int reportCmt(ReportVO reportVo);

	public int ban(String nickname, Date date);
	
	//페이징
	public List<BoardVO> getListWithPasing(Criteria cri);

	public int getTotalCount(Criteria cri);
	
	//좋아요
	public int cntLike(@Param("bno")int bno);
	
	public int chkLiked(@Param("bno") int bno, @Param("nickname") String nickname);
	
	public void addlike(@Param("bno") int bno, @Param("nickname") String nickname,@Param("cno") int cno);

	public void dellike(@Param("bno") int bno, @Param("nickname") String nickname,@Param("cno") int cno);

	public void updateLike(@Param("bno") int bno, @Param("cnt") int cnt);



	public LikestatusVO findByCnoAndNickname(@Param("cno") Integer cno, @Param("nickname") String nickname);

	public void insertLikeStatus(@Param("cno") Integer cno, @Param("nickname") String nickname);

	public void increase (@Param("cno") Integer cno);

	public void deleteLikeStatus(@Param("cno") Integer cno, @Param("nickname") String nickname);

	public int decrease(@Param("cno") Integer cno);

	public int getLikes(@Param("cno") Integer cno);

	
	
}
