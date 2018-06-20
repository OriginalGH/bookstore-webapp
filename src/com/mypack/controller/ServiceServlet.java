package com.mypack.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 异步通信服务
public class ServiceServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");  // 设置对客户端请求进行重新编码所使用的编码.
		response.setCharacterEncoding("utf-8");  // 指定对服务器响应进行重新编码所使用的编码。

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String action=request.getParameter("action");
		if(action.equals("test")){
			System.out.println("OK!测试Ajax成功！");
			out.println("OK!测试Ajax成功！");
		}
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
		doGet(request,response);
	}

	public void init() throws ServletException {
		//System.out.print("ServiceServlet init() Being called.");
	}

}
