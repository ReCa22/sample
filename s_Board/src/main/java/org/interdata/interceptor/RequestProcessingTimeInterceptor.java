package org.interdata.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class RequestProcessingTimeInterceptor extends HandlerInterceptorAdapter {

	public static Map<String, Object> userMap = new HashMap<>();
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		controller 이벤트 호출전
		// TODO Auto-generated method stub
		return super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
//		controller 호출 후 view 페이지 출력전
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
		String sessionId = request.getSession().getId();
		String userId = request.getParameter("id");
		userMap.put(sessionId, userId);
		
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

}
