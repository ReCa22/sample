package org.interdata.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.interdata.board.BoardService;
import org.interdata.board.BoardVO;
import org.interdata.interceptor.RequestProcessingTimeInterceptor;
import org.interdata.member.MemberService;
import org.interdata.member.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService adminsvc;
	@Autowired
	private BoardService boardsvc;
	@Autowired
	private MemberService membersvc;

	private String userId = null;
	
	@RequestMapping("admin")
	public String adminMain(Model model, HttpServletRequest request){
		String sPage = request.getParameter("page");
		String searchTitle = request.getParameter("searchTitle");
		String searchBar = request.getParameter("searchBar");
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
		return "admin/adminMain";
	}
	@RequestMapping("userInfo")
	public String userInfo(Model model, HttpServletRequest request){
		String sPage = request.getParameter("page");
		String searchTitle = request.getParameter("searchTitle");
		String searchBar = request.getParameter("searchBar");
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		
		int page = 1;
		if (sPage != null) {
			page = Integer.parseInt(sPage);
		}
		
		if(searchBar != null && !searchBar.equals("")){
			model.addAttribute("nvo", adminsvc.listNavVO(page, 0, searchTitle, searchBar));
			model.addAttribute("list", adminsvc.getSearchList(page, searchTitle, searchBar));
			model.addAttribute("search", searchBar);
			model.addAttribute("searchTitle", searchTitle);
			model.addAttribute("page", page);
		}else{
			model.addAttribute("nvo", adminsvc.listNavVO(page, 0));
			model.addAttribute("list", adminsvc.getMemberList(page));
			model.addAttribute("page", page);
		}
		model.addAttribute("userId", userId);
		return "admin/userInfo";
	}
	@RequestMapping("changeMemberInfo")
	public String changeMemberInfo(Model model, HttpServletRequest request, @RequestParam String id){
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		MemberVO vo = membersvc.getUserInfo(id);
		
		model.addAttribute("userId", userId);
		model.addAttribute("vo", vo);
		return "admin/changeMemberInfoForm";
	}
}
