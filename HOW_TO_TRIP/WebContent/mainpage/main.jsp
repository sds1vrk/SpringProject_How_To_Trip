<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR" import="java.util.*"%>
<% 
request.setCharacterEncoding("euc-kr");
String referer = request.getHeader("referer");
pageContext.setAttribute("his", referer);
System.out.println(referer);
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>여행어때?</title>
<meta charset="utf-8" />
  
 <link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> 
 <link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" /> 
<script src="http:////code.jquery.com/jquery-1.8.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="../country-select-js-master/build/css/countrySelect.css">
<script src="../country-select-js-master/build/js/countrySelect.min.js"></script>
<script>
 $(document).ready(function() {
	if(referer="http://localhost:8080/HOW_TO_TRIP/index.jsp"){
		 history.pushState(null, null, location.href);
		 window.onpopstate = function(event) {
		 	history.go(1);
		 };
	};
	
    $("#click").click(function() {
       window.open("check.jsp", "목적지검색", "left="+(screen.availWidth-660)/2+",top="+(screen.availHeight-500)/2+", width=660px,height=500px");
    });
    $( "#leDateStart" ).datepicker({
   	 dateFormat: "yy-mm-dd",
   	 changeMonth: true,
   	 onClose: function( selectedDate ) {
   	  $("#leDateEnd").datepicker( "option", "minDate", selectedDate );
   	 }
   	});
   	//끝일. 시작일보다는 길어야 되게끔
   	$( "#leDateEnd" ).datepicker({
   	 dateFormat: "yy-mm-dd",
   	 changeMonth: true,
   	 onClose: function( selectedDate ) {
   	  $("#leDateStart").datepicker( "option", "maxDate", selectedDate );
   	 }
   	});
   	//ajax
    $("#find").click(function() {
			$.ajax({
				url : "findbuddy.jsp", // a.jsp 의 제이슨오브젝트값을 가져옴
				type:'post',
				dataType : "json", // 데이터 타입을 제이슨 꼭해야함, 다른방법도 2가지있음
				cache : false,
				data : $('form').serialize(),
				success : function(data) {
					$("#findTable").empty();
					$("#findTable").css("display","none");
					if(data.memberlist==""){
						alert("동행자가 없습니다.");
					}
					if(data!=null){
						show(data);
						$("#findTable").css("display","block");
					}
				}
			});
		});
   	function show(data) { 
		$("#findTable").css({
			width : "500px",
			height : "600px"
		});
		var key = Object.keys(data["memberlist"][0]); // id , img의 키값을 가져옴
		$.each(data.memberlist, function(index, memberlist) { // 이치를 써서 모든 데이터들을 배열에 넣음
			if(memberlist.img==null){
				var img="../jsp_img/profile.png"
			}
			else{
				var img="../profile/"+memberlist.img
			}
			var items = [];
			items.push("<td rowspan="+"\"2\""+">"+"<a href=../board/view/fStory.jsp?id="+memberlist.id+">"+"<img id='buddyImg'" +"src="+ img +">"+"</a>"+"</td>");
			items.push("<tr></tr>");
			items.push("<td>"+"<center>"+"<font>" + memberlist.id +"</font>"+"</center>" +"</td>"); // 여기에 id pw addr tel의 값을 배열에 넣은뒤
			$("<td/>", {
				html : items // 티알에 붙임,
			}).appendTo($("#findTable")); // 그리고 그 tr을 테이블에 붙임
		});//each끝
	}
   	$("#country_selector").countrySelect({
	});
   	
 });
</script>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/hanna.css);
#buddyImg
{
	width: 200px;
	height: 200px;
	border-radius: 100px;
	padding: 10px;
}
font{
	font-family: "hanna";
	font-size: 20px;
}
.navbar .navbar-nav {
  			display: inline-block;
  			float: none;
		}
		
		.navbar .navbar-collapse {
 			 text-align: center;
		}
		.img-responsive{
		width: 100%;
		height: 400px;
		}
		.line{
		 max-width: 100%;
		 border: 2px solid black;
		 
		}
.img-responsive{
	width:100%;
	height: auto;
}
.btn-primary{
border: 0;
background-color: #FFD8D8;
}
</style>
</head>
<body>
	<center>
	<nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: #FFD8D8;
		border:none;">
      <div class="container">
        <div class="navbar-header">
          <div class="navbar-brand" style="color:white;">
          	<span class="glyphicon glyphicon-plane">여행어때?</span>
          </div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="../mainpage/main.jsp"><span class="glyphicon glyphicon-home" style="color:white;">HOME</span></a></li>
            <li><a href="../intro/information.jsp"><span class="glyphicon glyphicon-globe" style="color:white;">여행정보</span></a></li>
            <li><a href="../board/view/story.jsp"><span class="glyphicon glyphicon-camera" style="color:white;">스토리</span></a></li>
            <li><a href="../newchat/client.jsp"><span class="glyphicon glyphicon-send" style="color:white;">채팅</span></a></li>
           <li><a href="../mypage/mypage.jsp"><span class="glyphicon glyphicon-user" style="color:white;">MyPAGE</span></a></li>
            <li><a href="../login/logout_ok.jsp"><span style="font-size: 5px; color:black;">Logout</span></a></li>
            <li><a href="../login/deleteForm.jsp"><span style="font-size: 5px; color:black;">resign</span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
	<img class="img-responsive" src="../images/home-bg1.jpg" width="100%" height="400px " style="opacity: 0.8">
		<center>
		<div >
			<h2><font>여행친구찾기</font></h2>
			<br></br>
			<h1><font>지역을 검색해주세요</font></h1>
			<br></br>
			<hr style="border: 0;height: 3px;background: #ccc;">
			<br></br>
		</div>
			<form class="container" style="height: 300px;">
						<div style="margin-bottom: 15px; width: 300px;">
							<div class="form-item">
								<input class="form-control"  id="country_selector" type="text">
							</div>
							<div class="form-item" style="display:none;">
								<input class="form-control" type="text" id="country_selector_code" name="country_selector_code" data-countrycodeinput="1" readonly="readonly" placeholder="Selected country code will appear here" />
							</div>
						</div>		
							<input class="form-control" type="text" id="leDateStart"
								placeholder="여행출발" value="" name="sday" style="width: 228px; margin-bottom: 15px;" />
								 
							<input class="form-control" type="text" id="leDateEnd"
								placeholder="여행마지막날" value="" name="eday" style="width: 228px; margin-bottom: 15px;" />
	
						<center>
							<input class="btn btn-primary" type="button" id="find"
								value="동행자찾기" >
						</center>
			</form>
			<center>
				<table id="findTable"></table>
			</center>
			<!-- 아래쪽 이미지 시작 -->
			<hr class="line">
			<br><br>
			<div style="float: left;">
				<table border=0; cellpadding=0; cellspacing=0 ; margin=0
					; style="padding: 0px;">
					<tr style="width: 100%; height: 400px;">
						<th><a href="../intro/rome.jsp"><img
								src="../images/4.png" class="img-responsive" height="auto;"></a>
						</th>
						<th><a href="../intro/osaka.jsp"><img
								src="../images/5.png" class="img-responsive" height="auto;"></a>
						</th>
						<th><a href="../intro/bangkok.jsp"><img
								src="../images/6.png" class="img-responsive" height="auto;"></a>
						</th>
					</tr>
				</table>
				<div style="background-color: #585858; opacity:0.8; position:relative; top:100px; color: white; width:100%; height:200px; " >            
						 	<strong style="position:relative; top:160px; text-shadow: -0.6px 0 black, 0 0.6px black, 0.6px 0 black, 0 -0.6px black;">COPYRIGHT 2017 ⓒ How_To_Trip ALL RIGHTS RESERVED</strong>         
		         </div>
			</div>
		</center>
	</center>
</body>
	
</html>