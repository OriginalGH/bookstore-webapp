<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>welcome!</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
  <center>
  &nbsp;<br/>
  <%if(session.getAttribute("user")!=null){ %>
  <h2>恭喜<%=request.getAttribute("username") %>,登陆成功！<br/></h2>
  <%}else if(session.getAttribute("user")==null){ %>
  <h2>退出登陆成功！<br/></h2>
  <%} %>
  <form>
  <input type="hidden" name="action" value="welcome">
  <input style="width:280px;height:40px;margin-top:20px" type="submit" value="返回主页">
  </form>
  </center>
  </body>
</html>
