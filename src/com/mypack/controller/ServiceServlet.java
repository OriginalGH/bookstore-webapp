package com.mypack.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mypack.dao.ItemsDAO;

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

		response.setContentType("text/json;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		String action=request.getParameter("action");
		ItemsDAO itemsDao = new ItemsDAO();
		
		if(action.equals("test")){
			System.out.println("OK! Ajax请求成功!");
			out.println("OK! Ajax请求成功!");
			
		}else if(action.equals("search")){
			int result = itemsDao.getItemsByName(request.getParameter("bookname"));
			if (result != -1) {
				String json = "{\"id\":\"" + result + "\"}";
				out.write(json);
			}else{
				String json = "{}";
				out.write(json);
			}
			out.close();
			
		}else if(action.equals("addgoods")){
			if(session.getAttribute("user")!=null){
				String username = (String)session.getAttribute("user");
				int id = Integer.parseInt(request.getParameter("id"));
				if(session.getAttribute(username+"_cart")==null){
					ArrayList<Integer> list = new ArrayList<Integer>();
					list.add(id);
					session.setAttribute(username+"_cart", list);
					System.out.println(list.toString());
				}else{
					ArrayList<Integer> list = (ArrayList<Integer>)session.getAttribute(username+"_cart");
					list.add(id);
					System.out.println(list.toString());
				}
				String json = "{\"ok\":\"ok\"}";
				out.write(json);				
			}else{
				String json = "{}"; 
				out.write(json); 
			}
			out.close();
		}else if(action.equals("cart")){
			request.getRequestDispatcher("/cart.jsp").forward(request, response);
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
