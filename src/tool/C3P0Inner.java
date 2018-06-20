package tool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0Inner {

	private static ComboPooledDataSource ds;

	// ��̬��ʼ������г�ʼ��
	static {
		try {
			ds = new ComboPooledDataSource();// �������ӳ�ʵ��

			ds.setDriverClass("com.mysql.jdbc.Driver");// �������ӳ��������ݿ����������

			ds.setJdbcUrl("jdbc:mysql://localhost:3306/shopping");// �����������ݿ��URL

			ds.setUser("root"); // �����������ݿ���û���

			ds.setPassword("123456"); // �����������ݿ������

			ds.setMaxPoolSize(30); // �������ӳص����������

			ds.setMinPoolSize(2); // �������ӳص���С������

			ds.setInitialPoolSize(3); // �������ӳصĳ�ʼ������

			// ds.setMaxStatements(100); // �������ӳصĻ���Statement�������

			ds.setMaxIdleTime(1800); // �����೤ʱ��������Զ����٣�Ĭ��Ϊ0�������Զ����٣�����������8Сʱ֮�ڣ�

			// ds.setPreferredTestQuery("select 1");
			// <!--�����������Ӳ��Զ�ִ�еĲ�����䡣��ʹ�����Ӳ��Ե���������һ������߲����ٶȡ�
			// ע�⣺���Եı�����ڳ�ʼ����Դ��ʱ��ʹ��ڡ�Default: null-->

			// ds.setIdleConnectionTestPeriod(1800);
			// �����������������ӳ��еĿ������ӣ�Ĭ��Ϊ0��ʾ�����

			// ds.setTestConnectionOnCheckout(true); 
			// <!--���������Ĵ���ֻ����Ҫ��ʱ��ʹ�����������Ϊtrue��ô��ÿ��connection�ύ��ʱ�򶼽�У������Ч�ԡ�
			// ����ʹ��idleConnectionTestPeriod��automaticTestTable�ȷ������������Ӳ��Ե����ܡ�
			// Default:false -->

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ��ȡ��ָ�����ݿ������
	public static ComboPooledDataSource getInstance() {
		return ds;
	}

	// �����ӳط���һ������
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

	// ��ȡ���ӳ�״̬��Ϣ
	public static void getStatement() {
		try {
			int a = ds.getNumBusyConnections();
			int b = ds.getNumIdleConnections();
			int c = ds.getNumConnections();
			System.out.println("C3P0 ����ʹ�õ���������"+ a +" ���е���������"+ b +" ����������"+ c);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// �ͷ���Դ
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

	// �ͷ���Դ
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