package org.interdata.board;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.interdata.interceptor.RequestProcessingTimeInterceptor;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardsvc;
	
	private String userId = null;
	
	@RequestMapping("list")
	public String getList(Model model, HttpServletRequest request){
		String sPage = request.getParameter("page");
		String searchTitle = request.getParameter("searchTitle");
		String searchBar = request.getParameter("searchBar");
		
//		System.out.println("sPage : " + sPage);
//		System.out.println("searchTitle : " + searchTitle);
//		System.out.println("searchBar : " + searchBar);
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		
		int page = 1;
		if (sPage != null) {
			page = Integer.parseInt(sPage);
		}
		
		if(searchBar != null && !searchBar.equals("")){
			model.addAttribute("nvo", boardsvc.listNavVO(page, 0, searchTitle, searchBar));
			model.addAttribute("list", boardsvc.getSearchList(page, searchTitle, searchBar));
			model.addAttribute("search", searchBar);
			model.addAttribute("searchTitle", searchTitle);
			model.addAttribute("page", page);
		}else{
			model.addAttribute("nvo", boardsvc.listNavVO(page, 0));
			model.addAttribute("list", boardsvc.getNoticeList(page));
			model.addAttribute("page", page);
		}
		
		model.addAttribute("userId", userId);
		return "common/board/list";
	}
	
	@RequestMapping("write")
	public String write(Model model, HttpServletRequest request, BoardVO vo){
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
//		boardsvc.insertNotice(vo);
		
		model.addAttribute("userId", userId);
		return "common/board/write";
	}
	@RequestMapping("writeInput")
	public String insertWrite(HttpServletRequest request) throws UnsupportedEncodingException{
		boardsvc.insertNotice(request);
		return "redirect:/list";
	}
	@RequestMapping("view")
	public String view(Model model, int num, HttpServletRequest request){
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		boardsvc.updateHit(num);
		model.addAttribute("vo", boardsvc.getInfo(num));
		model.addAttribute("userId", userId);
		return "common/board/view";
	}
	@RequestMapping("edit")
	public String edit(Model model, int num, HttpServletRequest request){
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		model.addAttribute("vo", boardsvc.getInfo(num));
		model.addAttribute("userId", userId);
		return "common/board/edit";
	}
	@RequestMapping("fileDell")
	@ResponseBody
	public JSONObject fileDell(int num){
		JSONObject personObj = new JSONObject();
		boardsvc.dellFile(num);
		personObj.put("isCheck", true);
		return personObj;
	}
	@RequestMapping("boardUpdate")
	public String boardUpdate(HttpServletRequest request, Model model) throws UnsupportedEncodingException{
		int num = boardsvc.boardUpdate(request);
		model.addAttribute("num", num);
		return "common/board/update";
	}
	@RequestMapping("boardDell")
	@ResponseBody
	public JSONObject boardDell(int num){
		JSONObject personObj = new JSONObject();
		boardsvc.getReplyList(num);
		boardsvc.delBoard(num);
		personObj.put("isCheck", true);
		return personObj;
	}
	@RequestMapping("download")
	@ResponseBody
	public void download(HttpServletResponse response, 
							@RequestParam String changeName, @RequestParam String originName) throws IOException{
	     
	    byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\test\\"+changeName));
	     
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originName,"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
//		response.setContentType("image/jpeg");
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}
	
	@RequestMapping("reply")
	public String reply(Model model, HttpServletRequest request, int num){
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		BoardVO vo = boardsvc.getInfo(num);
		model.addAttribute("vo", vo);
		model.addAttribute("userId", userId);
		return "common/board/reply";
	}
	@RequestMapping("writeReply")
	@ResponseBody
	public JSONObject insertReply(BoardVO vo){
		System.out.println("write Controller");
		boardsvc.insertReply(vo);
		JSONObject personObj = new JSONObject();
		personObj.put("isCheck", true);
		
		return personObj;
	}
}
