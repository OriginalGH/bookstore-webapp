package com.mypack.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// �첽ͨ�ŷ���
public class ServiceServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");  // ���öԿͻ�������������±�����ʹ�õı���.
		response.setCharacterEncoding("utf-8");  // ָ���Է�������Ӧ�������±�����ʹ�õı��롣

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String action=request.getParameter("action");
		if(action.equals("test")){
			System.out.println("OK!����Ajax�ɹ���");
			out.println("OK!����Ajax�ɹ���");
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
