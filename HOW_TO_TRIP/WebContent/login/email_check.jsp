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
			alert("������ȣ�� �Է��ϼ���");
			opener.document.userInfo.mailCheck.value="";
			return false;
		}
		if(form.authnum.value!=<%=authNum%>){
			alert("Ʋ�� ������ȣ�Դϴ�. ������ȣ�� �ٽ� �Է����ּ���");
			form.authnum.value="";
			opener.document.userInfo.mailCheck.value="";
			return false;
		}
		if(form.authnum.value==<%=authNum%>){
			alert("�����Ϸ�");
			opener.document.userInfo.mailCheck.value="�����Ϸ�";
			self.close();
		}
	}
</script>
</head>
<body>
	<br><br><br>
	<center>
	<h2><font>������ȣ</font></h2>
	<br>
	<form method="post"  name="authenform" onsubmit="return check();">
		<input class="form-control" type="text" id="email" name="authnum" value="" style="width: 200px;">
		<br>
		<input class="btn btn-primary"  type="submit" value="����">
	</form>
	</center>
</body>
</html>