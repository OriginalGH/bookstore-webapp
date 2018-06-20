package tool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// C3P0连接测试类
public class C3P0InnerMain {

	public PreparedStatement setStatement(Connection conn, String sql) {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ps;
	}

	public PreparedStatement setParameter(PreparedStatement ps,
			Object... values) {
		try {
			if (null != values) {
				for (int i = 1; i <= values.length; i++) {
					ps.setObject(i, values[i - 1]);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ps;
	}

	public static void main(String[] args) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			conn = C3P0Inner.getConnection();
			
			C3P0InnerMain c3P0InnerMain = new C3P0InnerMain();

			String sql = "SELECT * FROM items";

			ps = c3P0InnerMain.setStatement(conn, sql);
			// ps = c3P0InnerMain.setParameter(ps, new Object[]{20,"tom"});	

			rs = ps.executeQuery();

			while (rs.next()) {
				Object id = rs.getObject(1);
				Object name = rs.getObject(2);
				System.out.println("ID: " + id + ", NAME:" + name);
			}
			C3P0Inner.getStatement();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 释放资源
			C3P0Inner.realeaseResource(rs, ps, conn);
		}
	}
}