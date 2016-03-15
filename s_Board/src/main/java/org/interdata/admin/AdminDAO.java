package org.interdata.admin;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.interdata.member.MemberVO;

public interface AdminDAO {
	public int getSearchPagenum(@Param("searchTitle")String searchTitle, @Param("searchBar")String searchBar);
	public List<MemberVO> getSearchList(@Param("page") int page, @Param("searchTitle") String searchTitle, @Param("searchBar") String searchBar);
	public int getPagenum();
	public List<MemberVO> getMemberList(int page);
}
