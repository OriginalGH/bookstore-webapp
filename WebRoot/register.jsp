<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link href="index.css" rel="stylesheet" type="text/css">
  <style type="text/css">
  
  .login {
  position:relative;
  border-style:solid solid solid solid;
  border-width:0px;
  border-color:gray gray gray gray;
  top:0px;
  width:340px;
  height:540px
    }
    
  h4{
    margin-left:30px;
    }
  a:hover {
    color:#000;
    
  }
  body{
  	background-image: url("images/bg001.jpg");
  	background-size:100%;
  	background-repeat: no-repeat;
  }
  
  </style>
    <base href="<%=basePath%>">
    
    <title>注册账户</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body <%if(request.getAttribute("registerfalse")!=null){ %>onload="alert('错误！用户名和密码不能为空！')"<%} %>>
  <center>
  	<h1>用户注册</h1>
  	<br/>
  </center>
  <hr>
  <h2><a href="index.jsp" style="text-decoration: none"><b>主页</b></a> <a href="login.jsp" style="text-decoration: none"><b>登录</b></a></h2><br>
  <center>
  <div class="login" align="left" >
  <form method="post" action="Controller">
    <center><h1 style="margin-top:20px"><b>注册账户</b></h1></center>
    <h4>手机号码：</h4>
    <center><input style="width:280px;height:40px" name="phone" type="text"></center>
    <h4>用户名：</h4>
    <center><input style="width:280px;height:40px" name="username" type="text"></center>
    <h4>密码：</h4>
    <center><input style="width:280px;height:40px" name="password" type="password"></center>
    <input type="hidden" name="action" value="registerUser"/><br/>
    <center><input style="width:280px;height:40px;margin-top:20px" type="submit" value="注册"></center>
    </form>
    &nbsp;<br>
  </div>
  </center>
    
  <hr style="margin-top:140px;">
  <center>注册即表示您同意网站的使用条件及隐私声明</center>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <center>版权所有 © 2017-，书虫图书旗下公司</center>
  &nbsp;&nbsp;&nbsp;&nbsp;
  </body>
</html>
