package com.mypack.model;

public class UserModel {
	private int id;
	private String phone;
	private String username;
	private String password;
	public UserModel(){
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String name) {
		this.phone = name;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
