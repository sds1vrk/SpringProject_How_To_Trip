<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="dao.*"%>
<%
 UserDAO dao=UserDAO.newInstance();
 String profileimg=dao.getProfile((String)session.getAttribute("id"));
 String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>여행어때?</title>

<link rel="stylesheet" href="../css/hover.css">
<link rel="stylesheet" href="../css/jquery.bxslider.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/hanna.css);
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);
font{font-family:맑은고딕; font-size: 20pt; color: white;}
.navbar .navbar-nav {
  			display: inline-block;
  			float: none;
		}

.navbar .navbar-collapse {
		 text-align: center;
}

</style>
</head>
<body>

<nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: #FFD8D8;
		border:none;">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#" style="color:white;">
          	<span class="glyphicon glyphicon-plane">여행어때?</span>
          </a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="../mainpage/main.jsp"><span class="glyphicon glyphicon-home" style="color:white;">HOME</span></a></li>
            <li><a href="../intro/information.jsp"><span class="glyphicon glyphicon-globe" style="color:white;">여행정보</span></a></li>
            <li><a href="../board/view/story.jsp"><span class="glyphicon glyphicon-camera" style="color:white;">스토리</span></a></li>
            <li><a href="../newchat/client.jsp"><span class="glyphicon glyphicon-send" style="color:white;">채팅</span></a></li>
           <li><a href="#"><span class="glyphicon glyphicon-user" style="color:white;">MyPAGE</span></a></li>
            <li><a href="../login/logout_ok.jsp"><span style="font-size: 5px; color:black;">Logout</span></a></li>
            <li><a href="../login/deleteForm.jsp"><span style="font-size: 5px; color:black;">resign</span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <img src="../images/home-bg1.jpg" width="110%" height="400px " style="opacity: 0.8">
<div class="container-fluid" style="width:100%; height: auto; border: 0px;">
		<center>
			<font style="font-size: 60pt;color: black;">MYPAGE</font>
		</center>			
		<hr style="border: 0;height: 3px;background: #ccc;">
	<table class="table" border="0px;">
		<tr>
			<td>
				<table class="table" style="width:auto; height: auto; background-color: #FFD8D8;">
					<tr align="center">	
						<td>
							<font style="font-size: 40pt;">MENU</font>
						</td>	
					</tr>				
					<tr align="center">
						<td><img style="width:200px;height: 200px;border-radius: 100px;margin-left: -5px;" src="<%=profileimg%>"></td>
					</tr>
					<tr align="center">
						<td><a href="../board/view/myStory.jsp?id=<%=id%>" target="page"><font>내 게시물 보기</font></a></td>
						
					</tr>
					
					<tr align="center">
						<td><a href="imageUpload.jsp" target="page"><font>프로필사진 변경</font></a></td>
						
					</tr>
				
					<tr align="center">
						<td><a href="../diary/calendar.jsp" target="page"><font>내 캘린더 보기</font></a></td>
					</tr align="center">
					
					<tr align="center">
						<td><a href="../login/ModifyForm.jsp" target="page"><font>회원 정보 변경</font></a></td>
					</tr>
				</table>
			</td>
			<td style="padding-left: 200px;">
				<div class="cotainer">
					<iframe src="initView.html" width="1000" height="800" name="page" frameborder="0"></iframe>
				</div>
			</td>
		</tr>
	</table>
	<center>
	<div style="background-color: #585858; opacity:0.8;position:relative; top:100px; color: white; width:100%; height:200px; " >            
						 	<strong style="position:relative; top:160px; text-shadow: -0.6px 0 black, 0 0.6px black, 0.6px 0 black, 0 -0.6px black;">COPYRIGHT 2017 ⓒ How_To_Trip ALL RIGHTS RESERVED</strong>         
	</div>
	</center>	
</div>
</body>
</html>