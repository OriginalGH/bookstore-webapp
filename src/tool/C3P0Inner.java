package tool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0Inner {

	private static ComboPooledDataSource ds;

	// 静态初始化块进行初始化
	static {
		try {
			ds = new ComboPooledDataSource();// 创建连接池实例

			ds.setDriverClass("com.mysql.jdbc.Driver");// 设置连接池连接数据库所需的驱动

			ds.setJdbcUrl("jdbc:mysql://localhost:3306/shopping");// 设置连接数据库的URL

			ds.setUser("root"); // 设置连接数据库的用户名

			ds.setPassword("123456"); // 设置连接数据库的密码

			ds.setMaxPoolSize(30); // 设置连接池的最大连接数

			ds.setMinPoolSize(2); // 设置连接池的最小连接数

			ds.setInitialPoolSize(3); // 设置连接池的初始连接数

			// ds.setMaxStatements(100); // 设置连接池的缓存Statement的最大数

			ds.setMaxIdleTime(1800); // 超过多长时间后，连接自动销毁，默认为0，即不自动销毁（建议设置在8小时之内）

			// ds.setPreferredTestQuery("select 1");
			// <!--定义所有连接测试都执行的测试语句。在使用连接测试的情况下这个一显著提高测试速度。
			// 注意：测试的表必须在初始数据源的时候就存在。Default: null-->

			// ds.setIdleConnectionTestPeriod(1800);
			// 隔多少秒检查所有连接池中的空闲连接，默认为0表示不检查

			// ds.setTestConnectionOnCheckout(true); 
			// <!--因性能消耗大请只在需要的时候使用它。如果设为true那么在每个connection提交的时候都将校验其有效性。
			// 建议使用idleConnectionTestPeriod或automaticTestTable等方法来提升连接测试的性能。
			// Default:false -->

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 获取与指定数据库的连接
	public static ComboPooledDataSource getInstance() {
		return ds;
	}

	// 从连接池返回一个连接
	public static Connection getConnection() {
		// C3P0Inner.getStatement();
		Connection conn = null;
		try {
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	// 获取连接池状态信息
	public static void getStatement() {
		try {
			int a = ds.getNumBusyConnections();
			int b = ds.getNumIdleConnections();
			int c = ds.getNumConnections();
			System.out.println("C3P0 正常使用的连接数："+ a +" 空闲的连接数："+ b +" 总连接数："+ c);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 释放资源
	public static void realeaseResource(ResultSet rs, PreparedStatement ps,
			Connection conn) {
		if (null != rs) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (null != ps) {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 释放资源
	public static void releaseResource(ResultSet rs, Statement st,
			Connection conn) {
		if (null != rs) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (null != st) {
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}