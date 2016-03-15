package org.interdata.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;


public interface BoardDAO {
	
	public void boardInsert(BoardVO vo);
	public void boardInsertFile(BoardVO vo);
	public List<BoardVO> getNoticeList(int page);
	public List<BoardVO> getSearchList(@Param("page") int page, @Param("searchTitle") String searchTitle, @Param("searchBar") String searchBar);
	public int getPagenum();
	public int getSearchPagenum(@Param("searchTitle")String searchTitle, @Param("searchBar")String searchBar);
	public BoardVO getInfo(int num);
	public void dellFile(int num);
	public void boardUpdate(BoardVO vo);
	public void boardUpdateFile(BoardVO vo);
	public void delBoard(int num);
	public void updateHit(int num);
	public void insertReply(BoardVO vo);
	public List<BoardVO> getReplyList(int num);
}
