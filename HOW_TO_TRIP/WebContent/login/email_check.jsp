<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="email.*"%>
<%

	request.setCharacterEncoding("utf-8");
	String email = request.getParameter("email");
	EmailCheck em=new EmailCheck();
	String authNum=em.RandomNum();
	em.sendEmail(email, authNum);
	pageContext.setAttribute("authNum", authNum);
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="http:////code.jquery.com/jquery-1.8.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript">
	function check() {
		var form = document.authenform;
		var authNum = ${authNum};
		if(!form.authnum.value){
			alert("인증번호를 입력하세요");
			opener.document.userInfo.mailCheck.value="";
			return false;
		}
		if(form.authnum.value!=<%=authNum%>){
			alert("틀린 인증번호입니다. 인증번호를 다시 입력해주세요");
			form.authnum.value="";
			opener.document.userInfo.mailCheck.value="";
			return false;
		}
		if(form.authnum.value==<%=authNum%>){
			alert("인증완료");
			opener.document.userInfo.mailCheck.value="인증완료";
			self.close();
		}
	}
</script>
</head>
<body>
	<br><br><br>
	<center>
	<h2><font>인증번호</font></h2>
	<br>
	<form method="post"  name="authenform" onsubmit="return check();">
		<input class="form-control" type="text" id="email" name="authnum" value="" style="width: 200px;">
		<br>
		<input class="btn btn-primary"  type="submit" value="인증">
	</form>
	</center>
</body>
</html>
