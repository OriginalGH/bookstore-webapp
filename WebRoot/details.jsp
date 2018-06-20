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
  <link href="index.css" rel="stylesheet" type="text/css">
  <style type="text/css">
  .log{
  margin-left:80%;
  margin-top:20px;
  }
  #book{
	float:left;
	margin:20
	}
  .logo {
  position:absolute;
  width:820px;
  top:60px;
  left:300px
  }
  .log a {
  font-weight: bold;
  }
  body{
  	background-image: url("images/bg001.jpg");
  	background-size:100%;
  }
  </style>
    <base href="<%=basePath%>">
    
    <title>图书详情</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


  </head>
  
  <body>
  <img src="images/booklogo.jpg" width="180" height="120" border="5" style="border-color:#D3D3D3 gray gray #D3D3D3">
  <div class="logo">
  <center><form action="Controller" method="post"><input type="hidden" name="action" value="search"/><input 
  style="width:80px;height:40px;margin-top:0;border:0;margin-right:0" type="submit" value="查找书籍"><input 
  style="width:700px;height:40px;line-height:40px;font-weight: 600;" name="bookname" type="text"
  <%if(request.getAttribute("nosearch")==null){ %>value="输入书籍名称"
  <%}else if(request.getAttribute("nosearch").equals("true")){ %>value="搜索不到此书籍，请重新输入"<%} %> onfocus="this.value=''"
  ><input id="button1" type="submit" value="  ">
  </form></center>
  </div>
  
  <div class="log">
  <%if(session.getAttribute("user")==null){ %>
  <a href="login.jsp">登录</a>&nbsp;&nbsp;<a href="register.jsp">快速注册</a>
  <%}else{ %>
  <a href="cart.jsp">我的购物车</a>&nbsp;&nbsp;<a href="userCenter.jsp">个人中心</a>
  <%} %>
  </div>
  <center>
  	<h1>图书详情</h1>
  </center>
  <hr>
  <h2><a href="index.jsp">主页</a><br></h2>
  &nbsp;
  <center>
    <table style="background-color:white;border-color:#D3D3D3 gray gray #D3D3D3" width="1080" height="80" cellpadding="0" cellspacing="0" border="10">
      <tr>
     		<%
    			ItemsDAO itemsDao = new ItemsDAO();
    			ItemModel item = itemsDao.getItemsById(Integer.parseInt(request.getParameter("id")));
    			if(item!=null){
     		%>
        <td width="75%" valign="top">
     	<table>
     		<tr>
     			<td width="400px" height="400px">
     			&nbsp;<br>
     			&nbsp;<br>
     			<img src="images/<%=item.getPicture() %>" width="400"></td>
     		
     			<td width="350px" height="400px">
     		
     	    	<h2><%=item.getName() %></h2>
     			&nbsp;<br>
            	<b style="color:red;">价格 ¥:<%=item.getPrice() %></b><br>
            	&nbsp;<br>
     			<b>库存：<%=item.getCount() %></b><br>
     			&nbsp;<br>
     			<b>出版社：<%=item.getCity() %></b><br>
     			&nbsp;<br>
     			<a <%if(session.getAttribute("user")!=null){ %>onclick="alert('加入购物车成功！');"<%}else if(session.getAttribute("user")==null){ %>onclick="alert('请先登录账户！');"<%} %>><input name="" type="button" value="加入购物车"></a></td>
     		</tr>
     		
     		
     		<tr>
     			<td colspan="2">
     			&nbsp;<br>
     			<h2>&nbsp;&nbsp;推荐图书：</h2>
     		<%
    			ItemsDAO itemsDao2 = new ItemsDAO();
    			ArrayList<ItemModel> list2 = itemsDao2.getAllItems();
    			if(list2!=null&&list2.size()>0){
    				for(int i=0;i<list2.size();i++)
    				{
    					ItemModel item2 = list2.get(i);
     		%>
     		
     		<div id="book">
	     			<a href="details.jsp?id=<%=item2.getId()%>">
	     			<img src="images/<%=item2.getPicture() %>" width="86" height="70" border="0">
	     			</a>
	     			<p>&nbsp;<%=item2.getName() %></p>
	     			<P style="color:red;">&nbsp;¥:&nbsp;<%=item2.getPrice() %></P>
	     			<br>
     		</div>
     		<%
     				}
     			}
     		%>
     			</td>
     		</tr>
     		</table>
     		
     		</td>
     		<%
     				}
     		%>
     		
     		<%
     			String list="";
     			
     			Cookie[] cookies = request.getCookies();//获得cookie集合
     			
     			if(cookies!=null&&cookies.length>0)
     			{
	     			for(Cookie c:cookies)
	     			{
		     			if(c.getName().equals("ListViewCookie"))
		     			{
		     				list = c.getValue();
		     					
		     			}
		     		}
	     		}
	     		
     			list += request.getParameter("id") + ",";
     			
     			String []arr = list.split(",");
     			if(arr!=null&&arr.length>0){
     			
     				if(arr.length>=1000){	//超过1000条清零
     					list="";
     				}
     			}
     			Cookie cookie = new Cookie("ListViewCookie",list);
     			response.addCookie(cookie);
     		
     		 %>
     		 
     		 <td width="25%" align="center">
     		 &nbsp;<br>
     		 	<h3>最近浏览的商品</h3>
     		 	<p></p>
     		 	<%
     		 		ArrayList<ItemModel> itemlist = itemsDao.getViewList(list);
     		 		if(itemlist!=null&&itemlist.size()>0){
     		 			for(ItemModel i:itemlist){
     		 	%>
     		 	<div>
     		 		<a href="details.jsp?id=<%=i.getId()%>"><img src="images/<%=i.getPicture() %>" width="120" height="80" border="0"></a>
	     			<h3><%=i.getName() %></h3>
	     			<p>出版社:<%=i.getCity() %>&nbsp;&nbsp;¥:<%=i.getPrice() %></p>
	     			<br>
     		 	</div>
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
     <!-- 
     <script src="js/jquery-1.10.2.js" type="text/javascript"></script>
     <script type="text/javascript">
     </script>
      -->
  </body>
</html>