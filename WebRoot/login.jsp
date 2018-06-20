<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="com.mypack.model.ItemModel" %>
<%@ page import="com.mypack.dao.ItemsDAO" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <style type="text/css">
  
  .login{
  position:relative;
  border-style:solid solid solid solid;
  border-width:2px;
  border-color:gray gray gray gray;
  top:20px;
  width:340px;
  height:440px
    }
    
  h4{
    margin-left:30px;
    }
    
  body{
  	background-image: url("images/bg001.jpg");
  	background-size:100%;
  	background-repeat: no-repeat;
  }
  </style>
    <base href="<%=basePath%>">
    
    <title>登录</title>
    <link href="index.css" rel="stylesheet" type="text/css">
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body <%if(request.getAttribute("loginfalse")!=null){ %>onload="alert('ERROR!!!Username or password is wrong.')"<%} %>>
  <center>
    <h1>用户登录</h1>
    <br/>
  </center>
  <hr>
  <h2><a href="index.jsp"><b>主页</b></a></h2><br/>
  <center>
  <div class="login" align="left">
  <form method="post" action="Controller">
    <center><h1 style="margin-top:20px"><b>登录</b></h1></center>
    <h4>用户名：</h4>
    <center><input style="width:280px;height:40px" name="username" type="text"></center>
    <h4>密码：</h4>
    <center><input style="width:280px;height:40px" name="password" type="password"></center><br/>
    <input type="hidden" name="action" value="login"/>
    <center><input style="width:280px;height:40px;margin-top:20px" type="submit" value="登录"></center>
    </form>
    &nbsp;<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Controller?action=register">注册账户</a>
  </div>
  </center>
  <br/><br/><br/>
  <input type="button" onclick="loadInfo()" value="测试"/>
  <hr style="margin-top:100px;">
  <center>登录即表示您同意网站的使用条件及隐私声明</center>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <center>版权所有 © 2017-，书虫图书旗下公司</center>
  &nbsp;&nbsp;&nbsp;&nbsp;
  
  
  <script type="text/javascript">
    //json对象
    function loadInfo(){
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("get", "Service?action=test");
        xmlHttp.send();
        xmlHttp.onreadystatechange = function(){
            if(xmlHttp.readyState==4){
            	if(xmlHttp.status==200){
            		alert(xmlHttp.responseText);
            	}else{
            		alert("发生错误！"+xmlHttp.status+xmlHttp.readyState);
            	}
            }
        };
    }
  </script>
  
  </body>
</html>
