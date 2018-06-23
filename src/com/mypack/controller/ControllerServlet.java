package com.mypack.controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tool.C3P0Inner;

import com.mypack.dao.ItemsDAO;
import com.mypack.dao.UserDAO;
import com.mypack.model.UserModel;

public class ControllerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	Connection con = null;

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // ���öԿͻ�������������±�����ʹ�õı���.
		response.setCharacterEncoding("utf-8"); // ָ���Է�������Ӧ�������±�����ʹ�õı��롣
		// ������Ӧͷ��ContentType
		response.setContentType("text/html;charset=utf-8");

//		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");
		UserModel userModel = new UserModel();
		ItemsDAO itemsDao = new ItemsDAO();
		
		// ��¼����
		if (action.equals("login")) {
			userModel.setUsername(request.getParameter("username"));
			userModel.setPassword(request.getParameter("password"));
			UserDAO userDAO = new UserDAO(con, userModel);
			int i = 0;
			i = userDAO.loginUser();

			if (i > 0) {
				HttpSession session = request.getSession();
				UserModel us = new UserModel();
				us = userDAO.getUser();

				String username = request.getParameter("username");
				request.setAttribute("username", username);
				session.setAttribute("user", username);
				session.setAttribute("userid", us.getId());
				session.setAttribute("phone", us.getPhone());
				request.getRequestDispatcher("/welcome.jsp").forward(request,
						response);

			} else {
				request.setAttribute("loginfalse", "true");
				request.getRequestDispatcher("/login.jsp").include(request,
						response);
			}
		// ��¼�ɹ�,ת����ҳ
		} else if (action.equals("welcome")) {
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);
		// ע��ɹ���ת����¼
		} else if (action.equals("successful")) {
			request.getRequestDispatcher("/login.jsp").forward(request,
					response);
		// ����ע��ҳ��
		} else if (action.equals("register")) {
			request.getRequestDispatcher("/register.jsp").forward(request,
					response);
		// �˳���¼
		} else if (action.equals("quit")) {
			HttpSession session = request.getSession();
			session.removeAttribute("user");
			session.removeAttribute("userid");
			session.removeAttribute("phone");
			request.getRequestDispatcher("/welcome.jsp").forward(request,
					response);
		// �л��û�
		} else if (action.equals("changeuser")) {
			request.getRequestDispatcher("/login.jsp").forward(request,
					response);
		// ����
		} else if (action.equals("search")) {
			int a = itemsDao.getItemsByName(request.getParameter("bookname"));
			System.out.println((request.getParameter("bookname")));
			if (a != -1) {
				request.getRequestDispatcher("/details.jsp?id=" + a).forward(
						request, response);
			}else{
				request.setAttribute("nosearch", "true");
				request.getRequestDispatcher("/index.jsp").include(request,
						response);
			}
		// ע���û�
		} else if (action.equals("registerUser")) {
			userModel.setPhone(request.getParameter("phone"));
			userModel.setUsername(request.getParameter("username"));
			userModel.setPassword(request.getParameter("password"));

			UserDAO userDAO = new UserDAO(con, userModel);
			int n = 0;
			n = userDAO.insertUser();

			if (n > 0) {
				// out.write("Registration Successful!!!");
				request.getRequestDispatcher("/successful.jsp").include(
						request, response);
			} else {
				// out.println("Registration false!!! UserName is null.");
				request.setAttribute("registerfalse", "true");
				request.getRequestDispatcher("/register.jsp").include(request,
						response);
			}
		}

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		response.setContentType("text/html;charset=utf-8");
		doGet(request, response);

	}

	public void init() throws ServletException {

		// ��web.xml��ȡcontext-parameter������Ϣ

		/*
		ServletContext context = getServletConfig().getServletContext();
		String driver = context.getInitParameter("driver"); 
		String url = context.getInitParameter("url"); 
		String username = context.getInitParameter("username"); 
		String password = context.getInitParameter("password");
		*/ 

		try {
			/*
			Class.forName(driver);
			con = DriverManager.getConnection(url,username,password);
			*/
			con = C3P0Inner.getConnection();
			System.out.println("ControllerServlet init be called.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
