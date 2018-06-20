<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <style type="text/css">
  body {
  background:url("images/bg001.jpg");
  background-size:cover;
  
  }
  </style>
    <base href="<%=basePath%>">
    
    <title>用户中心</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body background="images/bg001.jpg">
  <center><h1>用户中心</h1></center>
  <hr>
  <h2><a href="index.jsp">主页</a><br></h2>
  <div style="width:300px;margin:0 auto;">
  <h3>ID：${userid }</h3>
  <h3>姓名：${user }</h3>
  <h3>电话：${phone }</h3>
  <form method="post" action="Controller"><button name="action" value="changeuser">切换用户</button></form>
  <form method="post" action="Controller"><button name="action" value="quit">退出登录</button></form>
  </div>
  </body>
</html>
