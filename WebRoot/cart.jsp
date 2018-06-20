<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mypack.model.ItemModel" %>
<%@ page import="com.mypack.dao.ItemsDAO" %>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link href="index.css" rel="stylesheet" type="text/css">
    <base href="<%=basePath%>">
    
    <title>我的购物车</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body background="images/bg001.jpg">
  <center>
  	<h1>我的购物车</h1>
  </center>
  <hr>
  <h2><a href="index.jsp">主页</a><br></h2>
  &nbsp;
  <center>
  <table style="background-color:white" width="1080" height="60" cellpadding="0" cellspacing="0" border="0">
     	<tr>
     		<td width="70%" valign="top">
     		<%
     			ItemsDAO itemsDao = new ItemsDAO();
     		    			ArrayList<ItemModel> list = itemsDao.getAllItems();
     		    			if(list!=null&&list.size()>0){
     		    				for(int i=0;i<list.size();i++)
     		    				{
     		    					ItemModel item = list.get(i);
     		%>
     		<table width="1080" height="60" border="8px" style="border-color:#D3D3D3 gray gray #D3D3D3">
     		<tr>
     		<td width="120">
     		<a href="details.jsp?id=<%=item.getId()%>">
	     	<img src="images/<%=item.getPicture() %>" width="120" height="140" border="0"></a>
     		</td>
     		<td width="360">
     		<center>
     		<h4><%=item.getName() %></h4>
     		<b>出版社：<%=item.getCity() %></b>
     		</center>
     		</td>
     		<td width="240">
     		<center>
     		<h4>数量：1</h4>
     		<P style="color:red;">¥:&nbsp;<%=item.getPrice() %></P>
     		</center>
     		</td>
     		</tr>
     		</table>
     		<%
     				}
     			}
     		%>
     		</td>
     	</tr>
     </table>
     </center>
  <hr>
     <center>了解我们&nbsp;&nbsp;&nbsp;&nbsp;合作信息&nbsp;&nbsp;&nbsp;&nbsp;支付方式&nbsp;&nbsp;&nbsp;&nbsp;帮助中心</center>
     &nbsp;&nbsp;&nbsp;&nbsp;
     <center>版权所有 © 2017-，书虫图书旗下公司</center>
     &nbsp;&nbsp;&nbsp;&nbsp;
  </body>
</html>
