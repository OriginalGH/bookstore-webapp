package com.mypack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mypack.model.ItemModel;

import tool.C3P0Inner;

// 商品业务逻辑类
public class ItemsDAO {

	// 获取所有的商品业信息
	public ArrayList<ItemModel> getAllItems() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<ItemModel> list = new ArrayList<ItemModel>();

		try {
			con = C3P0Inner.getConnection();
			String sql = "select * from items;";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				ItemModel item = new ItemModel();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setCount(rs.getInt("count"));
				item.setPrice(rs.getFloat("price"));
				item.setPicture(rs.getString("picture"));
				list.add(item);

			}
			return list;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			C3P0Inner.realeaseResource(rs, ps, con);
		}

	}

	// 获取某个商品的详细信息
	public ItemModel getItemsById(int id) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = C3P0Inner.getConnection();
			String sql = "select * from items where id=?;";
			ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				ItemModel item = new ItemModel();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setCity(rs.getString("city"));
				item.setCount(rs.getInt("count"));
				item.setPrice(rs.getInt("price"));
				item.setPicture(rs.getString("picture"));
				return item;

			} else
				return null;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			C3P0Inner.realeaseResource(rs, ps, con);
		}

	}

	// 获取某个商品的ID
	public int getItemsByName(String name) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = C3P0Inner.getConnection();
			String sql = "select id from items where name=" + "'" + name + "'";
			ps = con.prepareStatement(sql);
			// st.setString(1,name); // 设置字符串中第n个“？”字符的替换
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt("id");
			} else {
				return -1;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			C3P0Inner.realeaseResource(rs, ps, con);
		}

	}

	// 获取最近浏览的商品信息
	public ArrayList<ItemModel> getViewList(String list) {
		ArrayList<ItemModel> itemlist = new ArrayList<ItemModel>();
		int icount = 5; // 设置要获取浏览记录的条数
		
		if (list != null && list.length() > 0) {
			String[] arr = list.split(",");
			ArrayList<String> arrayList = new ArrayList<String>();
			// 将arr保存的内容反序输出并去重
			for (int n = arr.length - 1; n >= 0; n--) {
				String item = arr[n];
				if (!arrayList.contains(item)) {
					arrayList.add(item);
				}
			}
			// 判断记录数是否大于icount
			if (arrayList.size() >= icount) {
				for (int i = 0; i < icount; i++) {
					itemlist.add(getItemsById(Integer.parseInt(arrayList.get(i))));
				}
			} else {
				for (int i = 0; i < arrayList.size(); i++) {
					itemlist.add(getItemsById(Integer.parseInt(arrayList.get(i))));
				}
			}
			return itemlist;
		} else {
			return null;
		}
	}

}
