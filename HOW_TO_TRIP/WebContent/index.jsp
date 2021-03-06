<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://malsup.github.com/jquery.cycle2.js"></script>

<script>
	history.pushState(null, null, location.href);
	window.onpopstate = function(event) {
		history.go(1);
	};

</script>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<title>여행어때?</title>
<style type="text/css">
body { 
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.cycle-slideshow{
	position: absolute;
	top: 100px;
}
.img-responsive{
	width:100%;
	height: auto;
}
#center {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 300px;
	height: 400px;
	overflow: hidden;
	margin-left: -140px;
	background-color:white;
	border-radius: 10px;
	opacity: 0.8;
}
.glyphicon glyphicon-plane{
font-size: 100px;
}
.btn-primary{
border: 0;
background-color: #FFD8D8;
}
a{ text-decoration:none; color: black; }

</style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" style="height:100px; background-color: #FFD8D8;border:none; ">
      <div class="container">
        <div class="navbar-header">
          <a class="navbar-brand" href="#" style="color:white;">
          	<span class="glyphicon glyphicon-plane" style="font-size: 65px;">여행어때?</span>
          </a>
        </div>
      </div>
    </nav>
	<center>
	<div class="cycle-slideshow">
			<img class="img-responsive" src="images/main1.jpg"/>
			<img class="img-responsive" src="images/main2.jpg"/>
			<img class="img-responsive" src="images/main3.jpg"/>
			<img class="img-responsive" src="images/main4.jpg"/>
	</div>
		<div id="center" class="container-fluid">
			<div>
			<br>
				여행의 동행자와 사진을 보고 싶다면<br>
				로그인하세요.
			</div>
			<h2>Login</h2>
			<form method="post" action="login/login_ok.jsp" class="form-horizontal">
				<table class="login-wrap" height="300px">
					<tr class="form">
						<td><input class="form-control" type="text" placeholder="ID" name="id" maxlength="15"/></td>
					</tr>
					<tr class="form">
						<td><input class="form-control" type="password" placeholder="Password" name="pwd" maxlength="15"/></td>
					</tr>
					<tr class="form" align="center">
						<td><input class="btn btn-primary" type="submit" value="Login">
							<input class="btn btn-primary" type="button" value="Join" onclick="location.href='login/JoinForm.jsp'">
						</td>
					<tr class="form" align="center">
						<td><a href="login/search_id.jsp">아이디</a>/<a href="login/search_pwd.jsp">비밀번호찾기</a></td>
					</tr>
				</table>
			</form>
		</div>
	</center>
</body>
</html>