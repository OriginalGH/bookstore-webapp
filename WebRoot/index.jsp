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
  <style>
  .log {
  margin-left:75%;
  margin-top:20px;
  }
  .log a {
  font-weight: bold;
  }
  .logo {
  position:absolute;
  width:820px;
  top:60px;
  left:300px;
  }
  .fenlei {
  width:1080px;
  }
  button{
  border: none;
  font-size: 18px;
  }
  </style>
    <base href="<%=basePath%>">
    
    <title>主页</title>
    
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
  <input type="hidden" name="action" value="search"
  /><input style="width:80px;height:40px;margin-top:0;border:0;margin-right:0" type="button" value="书籍名称"
  /><input id="input_text" style="width:700px;height:40px;line-height:40px;font-weight: 600;" name="bookname" type="text" 
  /><input id="button1" style="width:40px" onclick="ononsearch()" type="button" value="  " />
  </form>
  </center>
  </div>
  
  <div class="log">
  &nbsp;&nbsp;<%if(session.getAttribute("user")==null){ %><a href="login.jsp"><b>&nbsp;&nbsp;登录</b></a>&nbsp;&nbsp;&nbsp;<a href="register.jsp"><b>快速注册</b></a><%}else{ %><a href="Service?action=cart">我的购物车</a>&nbsp;&nbsp;<a href="userCenter.jsp">个人中心</a><%} %>
  </div>
  <center>
    <h1>图书推荐</h1>
  </center>
  <br>
  <center>
  <div class="fenlei">
  <button id="class1" style="color:black;"><b>每日推荐</b></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <button id="class2" style="color:blue;"><b>热销图书</b></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <button id="class3" style="color:blue;"><b>新品推荐</b></button>
  </div>
  </center>
  <br>
  <hr>
  <center>
    <table id="table1" width="1080" height="60" cellpadding="0" cellspacing="0" border="0">
      <tr>
     		<td width="70%" valign="top">
     		<%
    			ItemsDAO itemsDao = new ItemsDAO();
    			ArrayList<ItemModel> list = itemsDao.getAllItems();
    			DecimalFormat priceDF = new DecimalFormat();
    			priceDF.applyPattern(".00");
    			if(list!=null&&list.size()>0){
    				for(int i=0;i<list.size();i++)
    				{
    					ItemModel item = list.get(i);
     		%>
     		<div class="book">
	     			<a href="details.jsp?id=<%=item.getId()%>">
	     			<img src="images/<%=item.getPicture() %>" width="210" height="180" border="0">
	     			</a>
	     			<h4><a href="details.jsp?id=<%=item.getId()%>">&nbsp;&nbsp;&nbsp;&nbsp;<%=item.getName() %></a></h4>
	     			<P style="color:red;">&nbsp;&nbsp;&nbsp;&nbsp;¥:&nbsp;<%=priceDF.format(item.getPrice()) %></P>
	     			<p>&nbsp;&nbsp;&nbsp;&nbsp;出版社：<%=item.getCity() %></p>
	     			<br>
     		</div>
     		<%
     				}
     			}
     		%>
     		</td>
      </tr>
    </table>
    
    <table id="table2" class="dis_none" width="1080" height="60" cellpadding="0" cellspacing="0" border="0">
      <tr>
     		<td width="70%" valign="top">
     		<%
    			if(list!=null&&list.size()>0){
    				for(int i=1;i<list.size();i++)
    				{
    					ItemModel item = list.get(i);
     		%>
     		<div class="book">
	     			<a href="details.jsp?id=<%=item.getId()%>">
	     			<img src="images/<%=item.getPicture() %>" width="210" height="180" border="0">
	     			</a>
	     			<h4><a href="details.jsp?id=<%=item.getId()%>">&nbsp;&nbsp;&nbsp;&nbsp;<%=item.getName() %></a></h4>
	     			<P style="color:red;">&nbsp;&nbsp;&nbsp;&nbsp;¥:&nbsp;<%=priceDF.format(item.getPrice()) %></P>
	     			<p>&nbsp;&nbsp;&nbsp;&nbsp;出版社：<%=item.getCity() %></p>
	     			<br>
     		</div>
     		<%
     				}
     			}
     		%>
     		</td>
      </tr>
    </table>
    
    <table id="table3" class="dis_none" width="1080" height="60" cellpadding="0" cellspacing="0" border="0">
      <tr>
     		<td width="70%" valign="top">
     		<%
    			if(list!=null&&list.size()>0){
    				for(int i=2;i<list.size();i++)
    				{
    					ItemModel item = list.get(i);
     		%>
     		<div class="book">
	     			<a href="details.jsp?id=<%=item.getId()%>">
	     			<img src="images/<%=item.getPicture() %>" width="210" height="180" border="0">
	     			</a>
	     			<h4><a href="details.jsp?id=<%=item.getId()%>">&nbsp;&nbsp;&nbsp;&nbsp;<%=item.getName() %></a></h4>
	     			<P style="color:red;">&nbsp;&nbsp;&nbsp;&nbsp;¥:&nbsp;<%=priceDF.format(item.getPrice()) %></P>
	     			<p>&nbsp;&nbsp;&nbsp;&nbsp;出版社：<%=item.getCity() %></p>
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
  <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
  <script type="text/javascript">
	  document.getElementById("class1").onclick = function(){
	  	console.log("1");
	  	$("#class2, #class3").attr("style","color:blue;");
	  	$("#class1").attr("style","color:black;");
	  	$("#table2, #table3").fadeOut(300);
	  	$("#table1").fadeIn(500);
	  };
	  document.getElementById("class2").onclick = function(){
	  	console.log("2");
	  	$("#class1, #class3").attr("style","color:blue;");
	  	$("#class2").attr("style","color:black;");
	  	$("#table1, #table3").fadeOut(300);
	  	$("#table2").fadeIn(500);
	  };
	  document.getElementById("class3").onclick = function(){
	  	console.log("3");
	  	$("#class1,#class2").attr("style","color:blue;");
	  	$("#class3").attr("style","color:black;");
	  	$("#table1,#table2").fadeOut(300);
	  	$("#table3").fadeIn(500);
	  };
  
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
                		alert("没有找到此书!");
                	}
                	//var parsedJson = jQuery.parseJSON(data); 
                	//console.log(parsedJson.id); 
                }  
            });  
    }
  </script>
  </body>
</html>
