<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ page import="com.mypack.model.ItemModel" %>
<%@ page import="com.mypack.dao.ItemsDAO" %>
<%@ page import="java.text.DecimalFormat" %>
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
  <div id="bodydiv">
  <img src="images/booklogo.jpg" width="180" height="120" border="5" style="border-color:#D3D3D3 gray gray #D3D3D3">
  <div class="logo">
  <center>
  <form id="formId" action="Service" method="post" onkeydown="if(event.keyCode==13)return false;">
  <input style="width:80px;height:40px;margin-top:0;border:0;margin-right:0" type="button" value="书籍名称" 
  /><input id="input_text" style="width:700px;height:40px;line-height:40px;font-weight: 600;" name="bookname" type="text" 
  /><input type="hidden" name="action" value="search" 
  /><input id="button1" type="button" onclick="ononsearch()" value="  " />
  </form>
  </center>
  </div>
  
  <div class="log">
  <%if(session.getAttribute("user")==null){ %>
  <a href="login.jsp">登录</a>&nbsp;&nbsp;<a href="register.jsp">快速注册</a>
  <%}else{ %>
  <a href="Service?action=cart">我的购物车</a>&nbsp;&nbsp;<a href="userCenter.jsp">个人中心</a>
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
    			DecimalFormat priceDF = new DecimalFormat();
    			priceDF.applyPattern(".00");
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
            	<b>价格：<%=priceDF.format(item.getPrice()) %></b><br>
            	&nbsp;<br>
     			<b>库存：<%=item.getCount() %> 本</b><br>
     			&nbsp;<br>
     			<b>出版社：<%=item.getCity() %></b><br>
     			&nbsp;<br>
     			<form id="formAddGoods" action="Service" method="post" >
     				<input type="hidden" name="id" value="<%=item.getId() %>" />
     				<input type="hidden" name="action" value="addgoods" />
     				<input type="button" name="" value="加入购物车" onclick="addgoods()" />
     			</form>
     			</td>
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
	     			<P style="color:red;">&nbsp;¥:&nbsp;<%=priceDF.format(item2.getPrice()) %></P>
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
	     			<p><%=i.getCity() %>&nbsp;&nbsp;&nbsp;¥:<%=priceDF.format(i.getPrice()) %></p>
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
      
  </div>
  
  <script src="js/jquery-1.10.2.js" type="text/javascript"></script>
  <script type="text/javascript">
    function addgoods(){
    	$.ajax({  
                cache: true,  
                type:"POST",  
                url:"Service",  
                data:$('#formAddGoods').serialize(),  
                dataType:"json",  
                async: false,  
                error: function(request) {  
                    alert("Connection error:"+request.error);  
                },  
                success: function(data) { 
                	if(data.ok!=null){ 
                		alert("加入购物车成功!"); 
                	}else{
                		alert("请先登录账户！"); 
                	}
                }  
            });  
    }
    $('#input_text').keydown(function(event){
    	if(event.keyCode == 13){
    		ononsearch();
    	}
    });
    function ononsearch(){
        $.ajax({  
                cache: true,  
                type:"POST",  
                url:"Service",  
                data:$('#formId').serialize(),  
                dataType:"json",  
                async: false,  
                error: function(request) {  
                    alert("Connection error:"+request.error);  
                },  
                success: function(data) {
                	if(data.id!=null){
                		window.location.replace("details.jsp?id=" + data.id);
                	}else{
                		alert("sorry,没有找到此书!");
                	}
                	//var parsedJson = jQuery.parseJSON(data); 
                	//console.log(parsedJson.id); 
                }  
            });  
    }
  </script>
  </body>
</html>
