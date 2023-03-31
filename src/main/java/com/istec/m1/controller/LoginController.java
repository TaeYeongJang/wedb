package com.istec.m1.controller;

import java.security.Principal;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

//import com.fasterxml.jackson.databind.ObjectMapper;
import com.istec.m1.auth.CustomUserDetails;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, Model model) {

		String ctxPath = request.getContextPath();
		if (ctxPath.equals("/"))
			ctxPath = "";
		model.addAttribute("contextPath", ctxPath);

		return "/login";
	}
	
	@RequestMapping(value = "/ssoLogin", method = RequestMethod.GET)
	public String ssoLogin(HttpServletRequest request, Model model) {

		String ctxPath = request.getContextPath();
		if (ctxPath.equals("/"))
			ctxPath = "";
		model.addAttribute("contextPath", ctxPath);

		return "/ssologin";
	}

	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	public boolean loginProcess(HttpServletRequest request, Model model) {

		Enumeration<String> paramEnu = request.getParameterNames();
		logger.info("==========================================================");
		logger.info("===============    /loginProcess  st  ===================");
		while (paramEnu.hasMoreElements()) {
			String paramName = paramEnu.nextElement();
			logger.info("paramName : " + paramName + " , paramValue : " + request.getParameter(paramName));
		}
		logger.info("===============    /loginProcess  ed  ===================");
		logger.info("==========================================================");

		return true;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession(false);
		CustomUserDetails userDetails = (CustomUserDetails) session.getAttribute("userLoginInfo");

		if (userDetails != null)
			logger.info("Welcome logout! {}, {}", session.getId(), userDetails.getUsername());
		else
			logger.info("Welcome logout! {}", session.getId());

		session.setAttribute("userLoginInfo", null);
		session.removeAttribute("userLoginInfo");

		RequestCache requestCache = new HttpSessionRequestCache();
		requestCache.removeRequest(request, response);

		session.invalidate();

		return "redirect:/login";
	}

	@RequestMapping(value = "/auth/fail", method = RequestMethod.GET)
	public String login_failure(HttpServletRequest request, HttpSession session) {

		logger.info("Fail login! {}", session.getId());

		String accept = request.getHeader("accept");

		if (accept.indexOf("html") > -1) {
			return "redirect:/login?error";
		} else {
			return "redirect:/auth/fail_json";
		}

	}

	@RequestMapping(value = "/auth/denied", method = RequestMethod.GET)
	public String login_denied(HttpServletRequest request, HttpSession session, Principal user) {

		logger.info("Access denied! {}", session.getId());

		String accept = request.getHeader("accept");

		if (accept.indexOf("html") > -1) {
			return "redirect:/login?error";
		} else {
			return "redirect:/auth/fail_json";
		}

	}

	@RequestMapping(value = "/auth/fail_json", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> login_fail_json(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");

		// ResponseResult responseError = new ResponseResult();
		Map<String, Object> message = new HashMap<String, Object>();

		String accept = request.getHeader("accept");

		// if (StringUtils.indexOf(accept, "json") > -1) {
		if (accept.indexOf("json") > -1) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			/*
			 * responseError.setMessage("Unauthorized");
			 * responseError.setStatus_code("401");
			 */
			message.put("message", "Unauthorized");
			message.put("status_code", "401");
		} else {
			response.setStatus(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
			// responseError.setMessage("415 Unsupported Media Type");
			message.put("message", "415 Unsupported Media Type");
			message.put("status_code", "415");
		}

		return message;
	}

	/*
	 * @RequestMapping(value = "/auth/success", method = RequestMethod.GET) public
	 * String login_success(HttpSession session) { CustomUserDetails userDetails =
	 * (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().
	 * getDetails(); session.setAttribute("userLoginInfo", userDetails);
	 * 
	 * logger.info("Welcome login_success! {}, {}", session.getId(),
	 * userDetails.getUsername() + "/" + userDetails.getPassword());
	 * 
	 * return "redirect:/contents/main.do"; }
	 */

	@RequestMapping(value = "auth/duplicate", method = RequestMethod.GET)
	public void login_duplicate() {
		logger.info("Welcome login_duplicate!");
	}

	/*
	 * @RequestMapping(value = "/RawrisSSO", method = RequestMethod.GET) public
	 * String RawrisSSO(HttpServletRequest request, HttpServletResponse response)
	 * throws UnsupportedEncodingException {
	 * 
	 * 
	 * String ssoId = (String) request.getSession().getAttribute("_enpass_id_");
	 * logger.
	 * info("************************          _enpass_id_          ************************     "
	 * + ssoId);
	 * 
	 * 
	 * EnpassClient client = new EnpassClient(request, response);
	 * 
	 * if (!client.doLogin()) { return; }
	 * 
	 * String _enpass_id_ = (String) session.getAttribute("_enpass_id_");
	 * System.out.println("session : " + session.toString());
	 * 
	 * 
	 * String _enpass_id_ = request.getParameter("_enpass_id_");
	 * logger.info("LoginController _enpass_id_ : " + _enpass_id_);
	 * 
	 * if (_enpass_id_ != null) {
	 * 
	 * 
	 * request.getSession().setAttribute("ssoId", _enpass_id_);
	 * request.getSession().setAttribute("loginType", "S");
	 * request.getSession().setAttribute("id", _enpass_id_);
	 * request.getSession().setAttribute("pw",
	 * org.apache.commons.codec.digest.DigestUtils.sha512Hex(_enpass_id_));
	 * request.getSession().setAttribute("org_pw", _enpass_id_);
	 * 
	 * request.setCharacterEncoding("UTF-8"); request.setAttribute("ssoId",
	 * _enpass_id_); request.setAttribute("loginType", "S");
	 * request.setAttribute("id", _enpass_id_); request.setAttribute("pw",
	 * org.apache.commons.codec.digest.DigestUtils.sha512Hex(_enpass_id_));
	 * request.setAttribute("org_pw", _enpass_id_);
	 * 
	 * 
	 * return "redirect:/loginProcess"; }
	 * 
	 * return "redirect:/login"; }
	 */

}
