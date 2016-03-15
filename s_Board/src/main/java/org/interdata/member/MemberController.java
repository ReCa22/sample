package org.interdata.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.interdata.email.EmailVO;
import org.interdata.interceptor.RequestProcessingTimeInterceptor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService membersvc;
	
	private String userId = null;
	
	@RequestMapping(value = "cert", method = RequestMethod.POST)
	public String getCert(EmailVO vo, Model model){
		
		model.addAttribute("receiver1", vo.getReceiver1());
		model.addAttribute("receiver2", vo.getReceiver2());
		model.addAttribute("content", vo.getContent());
		
		return "common/member/certForm";
	}

	@RequestMapping(value = "joinForm", method = RequestMethod.POST)
	public String joinForm(EmailVO vo, Model model){
		model.addAttribute("receiver1", vo.getReceiver1());
		model.addAttribute("receiver2", vo.getReceiver2());
		model.addAttribute("content", vo.getContent());
		return "common/member/joinForm";
	}
	
	@RequestMapping("joinIdCheck")
	@ResponseBody
	public JSONObject joinIdCheck(String id){
		JSONObject personObj = new JSONObject();
		Boolean idCheck = membersvc.idCheck(id);
		System.out.println("idCheck : " + idCheck);
		personObj.put("check", idCheck);
		return personObj;
	}
	
	@RequestMapping(value = "joinSuccess", method = RequestMethod.POST)
	public String joinSuccess(MemberVO vo){
		membersvc.insertMember(vo);
		membersvc.insertZipCode(vo);
		return "redirect:/index";
	}
	
//	Login
	@RequestMapping(value = "login", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject login(Model model, String id, String pw){
		JSONObject personObj = new JSONObject();
		boolean check = membersvc.getLoginInfo(id, pw);
		personObj.put("check", check);
		return personObj;
	}
	
	@RequestMapping(value = "loginOk", method = RequestMethod.POST)
	@ResponseBody
	public void loginOk(Model model, String id){
		model.addAttribute("userId", id);
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request){
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		map.remove(request.getSession().getId());
		userId = (String)map.get(request.getSession().getId());
//		Map<String, List<Object>> map = RequestProcessingTimeInterceptor.infoMap;
//		map.remove("userId");
		return "redirect:index";
	}
	@RequestMapping("changeInfo")
	public String changeInfo(Model model, HttpServletRequest request){
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		MemberVO vo = membersvc.getUserInfo(userId);
		
		model.addAttribute("vo", vo);
		model.addAttribute("userId", userId);
		return "common/member/changeInfoForm";
	}
	@RequestMapping(value = "updateInfo", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateInfo(MemberVO vo){
		JSONObject personObj = new JSONObject();
		boolean memberCheck = membersvc.updateMember(vo);
		boolean zipCheck = membersvc.updateZipCode(vo);
		personObj.put("memberCheck", memberCheck);
		personObj.put("zipCheck", zipCheck);
		
		return personObj;
	}
}
