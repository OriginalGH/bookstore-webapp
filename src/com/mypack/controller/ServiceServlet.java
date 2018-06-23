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

		response.setContentType("text/json;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		String action=request.getParameter("action");
		ItemsDAO itemsDao = new ItemsDAO();
		
		if(action.equals("test")){
			System.out.println("OK! Ajax����ɹ�!");
			out.println("OK! Ajax����ɹ�!");
			
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
