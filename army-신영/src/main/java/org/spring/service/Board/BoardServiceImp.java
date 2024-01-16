package org.spring.service.Board;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;

import org.spring.domain.BoardVO;
import org.spring.domain.CommentVO;
import org.spring.domain.Criteria;
import org.spring.domain.LikestatusVO;
import org.spring.domain.ReportVO;
import org.spring.mapper.BoardMapper;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class BoardServiceImp implements BoardService {

	 // 파일을 저장할 디렉터리의 경로입니다. 실제 환경에 맞게 수정해야 합니다.
    private final Path rootLocation = Paths.get("C:/Users/keduit/Desktop/STSWS/army/src/main/webapp/resources/boardImage/");
	private final BoardMapper boardmapper;

	// 페이징하고 게시물 불러오기
	@Override
	public List<BoardVO> getPostList(Criteria cri) {
		log.info("service in getList");
		return boardmapper.getListWithPasing(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		System.out.println("겟토탈");
		return boardmapper.getTotalCount(cri);
	}

	@Override
	public BoardVO getPost(int bno) {
		return boardmapper.selectList(bno);
	}

	@Override
	public int addPost(BoardVO vo) {
		return boardmapper.createBoard(vo);
	}

	@Override
	public List<BoardVO> searchPost(String search) {
		return boardmapper.findList(search);
	}

	@Override
	public int modifyPost(BoardVO vo) {
		return boardmapper.modifyBoard(vo);
	}

	@Override
	public int delPost(int bno) {
		return boardmapper.removeBoard(bno);
	}

	@Override
	public int addComment(CommentVO vo) {
		return boardmapper.createCmt(vo);
	}

	@Override
	public int modifyComment(CommentVO vo) {
		return boardmapper.modifyCmt(vo);
	}

	@Override
	public int delComment(int cno) {
		return boardmapper.removeCmt(cno);
	}

	@Override
	public void plusView(int bno) {
		boardmapper.cntViews(bno);
	}

	@Override
	public int report(ReportVO vo) {
		return boardmapper.reportBoard(vo);
	}

	@Override
	public int ban(String nickname, Date date) {
		return boardmapper.ban(nickname, date);
	}

	public List<CommentVO> getCommentList(int bno) {
		// TODO Auto-generated method stub
		return boardmapper.showCmt(bno);
	}

	@Override
	public void cntcmt(int bno) {
		int cnt = 0;
		cnt = boardmapper.cntCmt(bno);
		log.info("cnt:" + cnt);
		if (cnt > 0)
			boardmapper.updateCmt(bno, cnt);

	}

	@Override
	public int isLiked(int bno, String nickname) {

		return boardmapper.chkLiked(bno, nickname);
	}

	@Override
	public void addLike(int bno, String nickname) {
		int cno = 0;
		boardmapper.addlike(bno, nickname, cno);
	}

	@Override
	public void removeLike(int bno, String nickname) {
		int cno = 0;
		boardmapper.dellike(bno, nickname, cno);
	}

	@Override
	public void updateLikes(int bno) {
		int cnt = boardmapper.cntLike(bno);
		boardmapper.updateLike(bno, cnt);

	}
	
	@Override
	@Transactional
	public int toggleLikeComment(Integer cno, String nickname) {
		// 댓글의 현재 좋아요 상태를 가져옵니다.
		LikestatusVO likeStatus = boardmapper.findByCnoAndNickname(cno, nickname);

		if (likeStatus == null) {
			// 좋아요 상태가 존재하지 않으면, 좋아요 상태를 추가하고 댓글의 좋아요 수를 증가시킵니다.
			boardmapper.insertLikeStatus(cno, nickname);
			boardmapper.increase(cno);
		} else {
			// 좋아요 상태가 존재하면, 좋아요 상태를 삭제하고 댓글의 좋아요 수를 감소시킵니다.
			boardmapper.deleteLikeStatus(cno, nickname);
			boardmapper.decrease(cno);
		}

		// 변경된 댓글의 좋아요 수를 반환합니다.
		return boardmapper.getLikes(cno);
	}

	public String saveFile(MultipartFile file) {
        // 파일명을 생성합니다. 여기서는 파일의 원래 이름을 사용합니다.
        // 실제 환경에서는 보안을 위해 파일명을 변경할 수 있습니다.
        String filename = file.getOriginalFilename();
        
        try {
            // 파일이 비어있지 않은지 확인합니다.
            if (file.isEmpty()) {
                throw new IOException("Failed to store empty file " + filename);
            }
            
            
			// 파일을 저장할 경로를 생성합니다.
            Path destinationFile = rootLocation.resolve(Paths.get(filename))
                    .normalize().toAbsolutePath();
                    
            // 안전한 파일 저장을 위해 경로가 루트 위치 밖을 가리키지 않는지 확인합니다.
            if (!destinationFile.getParent().equals(rootLocation.toAbsolutePath())) {
                // 이 경우 악의적인 경로 접근으로 간주할 수 있습니다.
                throw new IOException("Cannot store file outside current directory.");
            }
            
            // 파일을 지정된 경로에 저장합니다.
            Files.copy(file.getInputStream(), destinationFile, StandardCopyOption.REPLACE_EXISTING);
            
            // 파일의 경로를 반환합니다. 실제 환경에서는 URL 등을 반환할 수 있습니다.
            return destinationFile.toString();
            
        } catch (IOException e) {
            // 예외 발생 시 처리할 로직입니다.
            throw new RuntimeException("Failed to store file " + filename, e);
        }
    }
	
}
