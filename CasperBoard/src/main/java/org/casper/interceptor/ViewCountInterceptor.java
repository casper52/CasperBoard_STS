package org.casper.interceptor;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class ViewCountInterceptor extends HandlerInterceptorAdapter{

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		Cookie cookies[] = request.getCookies();
		

		boolean check = false;
		boolean echeck = false;
		
		Cookie viewCookie = null;
		String bno = request.getParameter("bno");
		String arr[];

		for(Cookie cookie:cookies) {
			
			if(cookie.getName().equals("view")) {
				check = true;
				viewCookie = cookie;
				
				arr = viewCookie.getValue().split("_");
				for(String e:arr) {
					if(e.equals(String.valueOf(bno))) {
						echeck = true;
						break;
					}
				}
				
				break;
			}
		}
		
		log.warn("--------------------------------------------");
	
		
		if(check == false) {
			
			Cookie cookie = new Cookie("view", bno );
			cookie.setMaxAge(60*60*24);
			response.addCookie(cookie);
			
		}else if(echeck == true){
			return;
			
		}
		else {
		
			viewCookie.setValue(viewCookie.getValue() +"_" + bno);
			response.addCookie(viewCookie);
			
		}
		
		
		super.postHandle(request, response, handler, modelAndView);
	}

	
}
