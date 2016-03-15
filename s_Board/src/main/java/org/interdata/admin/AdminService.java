package org.interdata.admin;

import java.util.List;

import org.interdata.board.NavigationVO;
import org.interdata.member.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminsvc")

public class AdminService {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private int rowsPerPage = 5, numsPerPage = 2;
	private boolean leftMore, rightMore;
	
	public NavigationVO listNavVO(int pg, int totalnum, String searchTitle, String searchBar) {
		AdminDAO dao = sqlSessionTemplate.getMapper(AdminDAO.class);
		NavigationVO nav = new NavigationVO();
		nav.setCurrPage(pg);
		nav.setLinks(getSearchNavLinks(pg, rowsPerPage, numsPerPage, totalnum, searchTitle, searchBar));
		nav.setLeftMore(leftMore);
		nav.setRigetMore(rightMore);
		nav.setInfoPage(((dao.getSearchPagenum(searchTitle, searchBar) - 1) / rowsPerPage + 1));
		return nav;
	}
	public int[] getSearchNavLinks(int page, int rowsPerPage, int numsPerPage,
			int totalRows, String searchTitle, String searchBar) {
		AdminDAO dao = sqlSessionTemplate.getMapper(AdminDAO.class);
		if (totalRows == 0) {
			totalRows = dao.getSearchPagenum(searchTitle, searchBar);
		}
		int totalPages = (totalRows - 1) / rowsPerPage + 1;
		
		int tmp = (page - 1) / numsPerPage + 1; // 몇번째 링크그룹에 속하는가?
		int end = tmp * numsPerPage;
		int start = (tmp - 1) * numsPerPage + 1;
		
		if (start == 1)
			leftMore = false; // << 왼쪽 이동 출력여부
		else
			leftMore = true;
		if (end >= totalPages) { // >> 오른쪽 이동 출력여부
			end = totalPages;
			rightMore = false;
		} else
			rightMore = true;
		
		int[] links = new int[end - start + 1];
		for (int num = start, i = 0; num <= end; num++, i++) {
			links[i] = num;
		}
		return links;
	}
	public List<MemberVO> getSearchList(int page, String searchTitle, String searchBar){
		AdminDAO dao = sqlSessionTemplate.getMapper(AdminDAO.class);
		System.out.println("getSearchList start");
		System.out.println(searchTitle);
		System.out.println(searchBar);
		System.out.println(page);
		return dao.getSearchList(page, searchTitle, searchBar);
	}
	public NavigationVO listNavVO(int pg, int totalnum) {
		AdminDAO dao = sqlSessionTemplate.getMapper(AdminDAO.class);
		NavigationVO nav = new NavigationVO();
		nav.setCurrPage(pg);
		nav.setLinks(getNavLinks(pg, rowsPerPage, numsPerPage, totalnum));
		nav.setLeftMore(leftMore);
		nav.setRigetMore(rightMore);
		nav.setInfoPage(((dao.getPagenum() - 1) / rowsPerPage + 1));
		return nav;
	}
	public int[] getNavLinks(int page, int rowsPerPage, int numsPerPage,
			int totalRows) {
		AdminDAO dao = sqlSessionTemplate.getMapper(AdminDAO.class);
		if (totalRows == 0) {
			totalRows = dao.getPagenum();
		}
		int totalPages = (totalRows - 1) / rowsPerPage + 1;

		int tmp = (page - 1) / numsPerPage + 1; // 몇번째 링크그룹에 속하는가?
		int end = tmp * numsPerPage;
		int start = (tmp - 1) * numsPerPage + 1;

		if (start == 1)
			leftMore = false; // << 왼쪽 이동 출력여부
		else
			leftMore = true;
		if (end >= totalPages) { // >> 오른쪽 이동 출력여부
			end = totalPages;
			rightMore = false;
		} else
			rightMore = true;

		int[] links = new int[end - start + 1];
		for (int num = start, i = 0; num <= end; num++, i++) {
			links[i] = num;
		}
		return links;
	}

	public List<MemberVO> getMemberList(int page){
		AdminDAO dao = sqlSessionTemplate.getMapper(AdminDAO.class);
		return dao.getMemberList(page);
	}
}
