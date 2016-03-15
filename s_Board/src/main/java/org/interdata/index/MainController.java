package org.interdata.index;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.interdata.interceptor.RequestProcessingTimeInterceptor;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	private String userId = null;
	
	@RequestMapping("index")
	public String main(Model model, HttpServletRequest request) throws ParseException{
		Map<String, Object> map = RequestProcessingTimeInterceptor.userMap;
		userId = (String)map.get(request.getSession().getId());
		System.out.println(map.size());
		model.addAttribute("userId", userId);
		return "main";
	}
}
