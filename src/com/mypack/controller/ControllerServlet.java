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
		request.setCharacterEncoding("utf-8"); // 设置对客户端请求进行重新编码所使用的编码.
		response.setCharacterEncoding("utf-8"); // 指定对服务器响应进行重新编码所使用的编码。

		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
//
//		System.out.println(this.con); // 输出数据库连接信息

		String action = request.getParameter("action");
		UserModel model = new UserModel();
		ItemsDAO itemsDao = new ItemsDAO();

		if (action.equals("login")) {
			model.setUsername(request.getParameter("username"));
			model.setPassword(request.getParameter("password"));
			UserDAO userDAO = new UserDAO(con, model);
			int i = 0;
			i = userDAO.loginUser();

			if (i > 0) {
				UserModel us = new UserModel();
				us = userDAO.getUser();

				String username = request.getParameter("username");
				request.setAttribute("username", username);
				HttpSession session = request.getSession();
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

		} else if (action.equals("welcome")) {
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} else if (action.equals("successful")) {
			request.getRequestDispatcher("/login.jsp").forward(request,
					response);

		} else if (action.equals("register")) {
			request.getRequestDispatcher("/register.jsp").forward(request,
					response);

		} else if (action.equals("quit")) {
			HttpSession session = request.getSession();
			session.removeAttribute("user");
			session.removeAttribute("userid");
			session.removeAttribute("phone");
			request.getRequestDispatcher("/welcome.jsp").forward(request,
					response);

		} else if (action.equals("changeuser")) {
			request.getRequestDispatcher("/login.jsp").forward(request,
					response);

		} else if (action.equals("search")) {
			int a = itemsDao.getItemsByName(request.getParameter("bookname"));
			if (a != 0) {
				request.getRequestDispatcher("/details.jsp?id=" + a).forward(
						request, response);
			}
			if (a == 0) {
				request.setAttribute("nosearch", "true");
				request.getRequestDispatcher("/index.jsp").include(request,
						response);
			}

		} else if (action.equals("registerUser")) {
			model.setPhone(request.getParameter("phone"));
			model.setUsername(request.getParameter("username"));
			model.setPassword(request.getParameter("password"));

			UserDAO userDAO = new UserDAO(con, model);
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

//		response.setContentType("text/html");
//		PrintWriter out = response.getWriter();
		doGet(request, response);

	}

	public void init() throws ServletException {

		// 从web.xml获取context-parameter配置信息

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
