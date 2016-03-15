package org.interdata.email;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.interdata.member.MemberVO;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/email/")
public class EmailController {
	
	private int rnum;
	
	@Autowired
	private EmailService emailService;

	@RequestMapping(value="send", method=RequestMethod.POST)
	@ResponseBody
	public EmailVO sendMail(EmailVO vo, HttpSession session, Model model)
			throws Exception {
		rnum = 123123;
		EmailVO email = new EmailVO();
		String subject = "회원가입 인증메일";
		
		//서버 아이피로
		Random rd = new Random();
		rnum = rd.nextInt(8999)+1000;
		String content = rnum+"";
		
//		email.setReceiver(vo.getReceiver());
		email.setReceiver1(vo.getReceiver1());
		email.setReceiver2(vo.getReceiver2());
		email.setSubject(subject);
		email.setContent(content);
		//boolean result = emailService.sendMail(email);
		model.addAttribute("result",emailService.sendMail(email));
		return email;
		//return "emailAuth/emailOkForm";
	}
	
	@RequestMapping(value="pwSearch", method=RequestMethod.POST)
	@ResponseBody
	public JSONObject pwSearch(Model model, MemberVO vo) throws Exception{
		JSONObject personObj = new JSONObject();
//		boolean isCheck = emailService.getPw(vo);
		MemberVO info = emailService.getMemberInfo(vo);
		boolean isCheck = false;
		if(info != null){
			isCheck = true;
		}
		personObj.put("isCheck", isCheck);
		System.out.println("isCheck : " + isCheck);
		
		if(isCheck){
			EmailVO email = new EmailVO();
			String subject = "패스워드 메일";
			email.setReceiver1(vo.getAddress());
			email.setReceiver2(vo.getAddress_etc());
			email.setSubject(subject);
			email.setContent(info.getPw());
			personObj.put("mailResult", emailService.sendMail(email));
		}
		return personObj;
	}
	
	@RequestMapping(value="cert", method=RequestMethod.POST)
	@ResponseBody
	public String certCheck(int certNumber, Model model){
		boolean isCheck = false;
		if(rnum >= 1000 && rnum < 10000){
			if(rnum == certNumber){
				isCheck = true;
			}
		}
		
		return "{ \"isCheck\" : "+isCheck+"}";
	}
}
