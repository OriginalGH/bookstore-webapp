package com.mypack.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import tool.C3P0Inner;

import com.mypack.model.UserModel;

// �û�ҵ���߼���
public class UserDAO {

	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	UserModel model = null;

	public UserDAO(Connection con, UserModel model) {
		this.con = con;
		this.model = model;
	}

	// �û���¼
	public int loginUser() {
		try {
			if ((con == null) || con.isClosed()) {
				this.con = C3P0Inner.getConnection();
			}
			st = con.createStatement();
			String sql = "SELECT phone,username,password FROM users "
					+ "WHERE username='" + model.getUsername() + "' "
					+ "AND PASSWORD='" + model.getPassword() + "' ";
			rs = st.executeQuery(sql);
			if (rs.next()) {
				return 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			C3P0Inner.releaseResource(rs, st, con);
		}
		return 0;
	}

	// �û�ע��
	public int insertUser() {
		try {
			if ((con == null) || con.isClosed()) {
				this.con = C3P0Inner.getConnection();
			}
			if (model.getUsername() == "" || model.getPassword() == "") {
				C3P0Inner.releaseResource(rs, st, con);
				return 0;
			}
			st = con.createStatement();
			String sql = "INSERT INTO users (phone,username,password)"
					+ "VALUES('" + model.getPhone() + "','"
					+ model.getUsername() + "','" + model.getPassword() + "')";
			int n = st.executeUpdate(sql);
			return n;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			C3P0Inner.releaseResource(rs, st, con);
		}
		return 0;
	}

	// ��ȡ�û���Ϣ
	public UserModel getUser() {
		try {
			if ((con == null) || con.isClosed()) {
				this.con = C3P0Inner.getConnection();
			}
			st = con.createStatement();
			String sql = "SELECT id,username,phone FROM users "
					+ "WHERE username='" + model.getUsername() + "' ";
			rs = st.executeQuery(sql);
			if (rs.next()) {
				UserModel user = new UserModel();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPhone(rs.getString("phone"));
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			C3P0Inner.releaseResource(rs, st, con);
		}
		return null;
	}

}
