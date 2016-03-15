package org.interdata.board;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("boardsvc")
public class BoardService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private int rowsPerPage = 5, numsPerPage = 2;
	private boolean leftMore, rightMore;
	
	public NavigationVO listNavVO(int pg, int totalnum, String searchTitle, String searchBar) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		NavigationVO nav = new NavigationVO();
		nav.setCurrPage(pg);
		nav.setLinks(getSearchNavLinks(pg, rowsPerPage, numsPerPage, totalnum, searchTitle, searchBar));
		nav.setLeftMore(leftMore);
		nav.setRigetMore(rightMore);
		nav.setInfoPage(((dao.getSearchPagenum(searchTitle, searchBar) - 1) / rowsPerPage + 1));
		return nav;
	}
	public List<BoardVO> getSearchList(int page, String searchTitle, String searchBar){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		return dao.getSearchList(page, searchTitle, searchBar);
	}
	public int[] getSearchNavLinks(int page, int rowsPerPage, int numsPerPage,
			int totalRows, String searchTitle, String searchBar) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
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
	public NavigationVO listNavVO(int pg, int totalnum) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
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
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
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
	public BoardVO insertNotice(HttpServletRequest request) throws UnsupportedEncodingException{
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO vo = new BoardVO();
		request.setCharacterEncoding("utf-8");
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart){
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = null;
			Map<String,Object> map = new HashMap<String,Object>();
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e) {
				System.out.println("에러 1: " + e);
			}
			for (int i = 0; i < items.size(); i++) {
				FileItem item = (FileItem) items.get(i);
				item.getName();
				if (item.isFormField()) { // 파일이 아닌 폼필드에 입력한 내용을 가져옴.
					if (item != null && item.getFieldName().equals("title")) {
						String title = item.getString("utf-8"); // 입력한 데이터를 가져옴
						vo.setTitle(title);
						map.put("title", title);
					} else if (item != null && item.getFieldName().equals("id")) {
						String id = item.getString("utf-8");
						vo.setId(id);
						map.put("id", id);
					} else if (item != null && item.getFieldName().equals("contents")) {
						String contents = item.getString("utf-8");
						vo.setContents(contents);
						map.put("contents", contents);
					}
				} else { // 폼 필드가 아니고 파일인 경우
					try {
						String itemName = item.getName();
						if (itemName == null || itemName.equals(""))
							continue;
						String fileName = FilenameUtils.getName(itemName);// 경로없이
						vo.setOriginname(fileName);
						map.put("originname",fileName);
						String changeFileName = changeName(fileName);
						File savedFile = new File("C:/test/"+ changeFileName);
						
						int fileSize = (int)savedFile.length();
						vo.setFile_size(fileSize);
						map.put("changename", changeFileName);
						vo.setChangename(changeFileName);
						item.write(savedFile);// 지정 경로에 파일을 저장함
						vo.setFile_size(savedFile.length());
					} catch (Exception e) {
						System.out.println("서버에 파일 저장중 에러: " + e);
					}
				} // end of else
			}

			if (vo.getChangename() == null) {
				dao.boardInsert(vo);
			} else {
				dao.boardInsertFile(vo);
				
			}			
		}else{
			System.out.println("else !!!");
		}
		
		return null;
	}
	public String changeName(String fileName) {
//		System.out.println("CHANGENAME 접근!!!" + fileName);
		String changeFileName = null;
		try {
			File savedFile = new File("C:/test/" + fileName);
			
//			같은 이름의 파일이 있을경우
			if (savedFile.exists()) {
				int ext = fileName.lastIndexOf(".");
				changeFileName = fileName + new java.util.Date().getTime() + fileName.substring(ext);
				
				return changeFileName;
			}
		} catch (Exception e) {
			System.out.println(" 에러: " + e);
		}
		return fileName;
	}
	public List<BoardVO> getNoticeList(int page){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		return dao.getNoticeList(page);
	}
	public BoardVO getInfo(int num){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		return dao.getInfo(num);
	}
	public void dellFile(int num){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		dao.dellFile(num);
	}
	public int boardUpdate(HttpServletRequest request) throws UnsupportedEncodingException{
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO vo = new BoardVO();
		request.setCharacterEncoding("utf-8");
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart){
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = null;
			Map<String,Object> map = new HashMap<String,Object>();
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e) {
				System.out.println("에러 1: " + e);
			}
			for (int i = 0; i < items.size(); i++) {
				FileItem item = (FileItem) items.get(i);
				item.getName();
				if (item.isFormField()) { // 파일이 아닌 폼필드에 입력한 내용을 가져옴.
					if (item != null && item.getFieldName().equals("title")) {
						String title = item.getString("utf-8"); // 입력한 데이터를 가져옴
						vo.setTitle(title);
						map.put("title", title);
					} else if (item != null && item.getFieldName().equals("contents")) {
						String contents = item.getString("utf-8");
						vo.setContents(contents);
						map.put("contents", contents);
					} else if (item != null && item.getFieldName().equals("num")) {
						String num = item.getString("utf-8");
						vo.setNum(Integer.parseInt(num));
						map.put("num", num);
					}
				} else { // 폼 필드가 아니고 파일인 경우
					try {
						String itemName = item.getName();
						if (itemName == null || itemName.equals(""))
							continue;
						String fileName = FilenameUtils.getName(itemName);// 경로없이
						vo.setOriginname(fileName);
						map.put("originname",fileName);
						String changeFileName = changeName(fileName);
						File savedFile = new File("C:/test/"+ changeFileName);
						
						int fileSize = (int)savedFile.length();
						vo.setFile_size(fileSize);
						map.put("changename", changeFileName);
						vo.setChangename(changeFileName);
						item.write(savedFile);// 지정 경로에 파일을 저장함
						vo.setFile_size(savedFile.length());
					} catch (Exception e) {
						System.out.println("서버에 파일 저장중 에러: " + e);
					}
				} // end of else
			}

			if (vo.getChangename() == null) {
				dao.boardUpdate(vo);
			} else {
				dao.boardUpdateFile(vo);
			}
		}else{
			System.out.println("else !!!");
		}
		return vo.getNum();
	}
	public void delBoard(int num){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO vo = dao.getInfo(num);
		//첨부파일이 있을 없을때
		if(vo.getChangename() == null){
			dao.delBoard(num);
		}else{
			dao.dellFile(num);
			dao.delBoard(num);
		}
//		dao.delBoard(num);
	}
	public void updateHit(int num){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		dao.updateHit(num);
	}
	public void insertReply(BoardVO vo){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		dao.insertReply(vo);
	}
	public List<BoardVO> getReplyList(int num){
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> replyList = new ArrayList<BoardVO>();
		List<BoardVO> getList = dao.getReplyList(num);
		boolean isList = replyList.size() != 0;
		if(isList){
			
			BoardVO vo = new BoardVO();
			
		}
//		for(int i=0; i<list.size(); i++){
//			dao.getReplyList(list.get(i).getNum());
//		}
		return replyList;
	}
	public List<BoardVO> getReply(int num){
		System.out.println("getReply() : 호출");
		List<BoardVO> list = new ArrayList<>();
		
		return list;
	}
}
