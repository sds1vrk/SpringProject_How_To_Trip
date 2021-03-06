<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*,story.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("EUC-KR");
	
	String strStoryno=request.getParameter("storyno");
	if(strStoryno==null)
		strStoryno="0";
	
	int storyno=Integer.parseInt(strStoryno);
	System.out.println(storyno);
	StoryDAO dao=StoryDAO.newInstance();
	List<StoryVO> list=dao.storyPageData(1);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title> 
	
	<link rel="stylesheet" href="../css/hover.css">
	<link rel="stylesheet" href="../css/jquery.bxslider.css">
	<link rel="stylesheet" href="../css/board.css" /> 
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
  	
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  	<script src="../js/jquery.bxslider.min.js"></script>
  	
  	
	<style type="text/css">
  		#mask {  
		  position:absolute;  
		  left:0;
		  top:0;
		  background-color: #000;   
		  display: none;  
		  z-index: 1;
		}
		.slider {
			display: none;
		}
		
		@import url(//fonts.googleapis.com/earlyaccess/hanna.css);
		font{font-family: "hanna"; font-size: 20pt;}
		a{text-decoration:none; color: black;}
		td{padding-left: 50px;}
		
		.navbar .navbar-nav {
  			display: inline-block;
  			float: none;
		}
		
		.navbar .navbar-collapse {
 			 text-align: center;
		}
		
	</style>
</head>

<script>
	var page=1;
	var storyno=1;
	var row1=1;
	var row2=2;
	var mySlider;
	$(window).scroll(function () { var scrollValue = $(document).scrollTop(); });
	function wrapWindowByMask(){
	    //화면의 높이와 너비를 구한다.
	    var maskHeight = $(document).height();  
	    var maskWidth = $(window).width();  
	
	    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	    $('#mask').css({'width':maskWidth*2,'height':maskHeight*2});  
		
	    //애니메이션 효과
	    $('#mask').fadeIn(0);      
	    $('#mask').fadeTo("slow",0.6); 
	    $('.slider').show();
	    $('.bx-viewport').show();
	    $('.bx-wrapper').show();
	}
	
	$(".hover").mouseleave(
			  function () {
			    $(this).removeClass("hover");
			  }
			);
		
	$(function(){
		//슬라이드 초기호
		$('.window .close').click(function (e) {  
		    //링크 기본동작은 작동하지 않도록 한다.
		    e.preventDefault();  
		    $('#mask, .window').hide();
		});       

		//검은 막을 눌렀을 때
		$('#mask').click(function () {  
		    $(this).hide();  
		    //$('.slider').hide();
		    $('.bx-viewport').hide();
		    $('.bx-wrapper').hide();
		    $('.bx-wrapper').remove();
		});
		//스크롤 이벤트 발생
		$(window).scroll(function() { 
			if($(window).scrollTop() >= $(document).height() - $(window).height()){ page=page+1; getStoryList(); } 
		});
		//이미지 눌렀을 때
		 $(document).on("click",".snip1384",function(){
				var storyno=$(this).children("img").attr("id");
				$.ajax({
					url: "intoStory.jsp",
					type:'post',
					data:{"storyno":storyno},
					dataType: 'html',
					success : function(data) {
						$("<div class='slider'></div>").appendTo($('.sPosition'));
						$('.slider').html(data);
						var mySlider=$('.slider').bxSlider({
							slideWidth:800 , 
							margin:0,
							adaptiveHeight: false,
							infiniteLoop: false,	//무한루프 방지
							hideControlOnEnd: true, //끝에서 버튼 안보임
							moveSlides:1,
							touchEnabled:false
							});
						var top=$(window).scrollTop()-500;
						$('.bx-wrapper').css("top",top);
						wrapWindowByMask();
						}		
					});
		 	});
		});
	$(document).keypress(function(e) {
		if(e.keyCode==13)e.preventDefault();
	});//엔터키 방지
	 //이미지 추가 로드 
	function getStoryList() {
		$.ajax({
			url : "moreStory.jsp", // a.jsp 의 제이슨오브젝트값을 가져옴
			type:'post',
			dataType : "json", // 데이터 타입을 제이슨 꼭해야함, 다른방법도 2가지있음
			cache : false,
			data : {"page":page},
			success : function(data) {
				var key = Object.keys(data["storylist"][0]); //img title storyno
				//if(row1==1) $("<tbody></tbody>").appendTo($('#addTable'));
				$("<tr id='"+row1+"'></tr>").appendTo($('#st_table tbody'));
				$("<tr id='"+row2+"'></tr>").appendTo($('#st_table tbody'));
				$.each(data.storylist, function(index, storylist) {
					if(index<4) {
						$("<td><figure class='snip1384'><img alt='sample83' src='"+storylist.img+"' id='"+storylist.storyno+"' width='300' height='300'/>" 
								+" <figcaption><center><h3 style='vertical-align:middle;'>"+storylist.title+"</h3>"+
								"</center><i class='ion-ios-arrow-right'></i></figcaption>"
								+"</figure></td>").appendTo($("#st_table tbody #"+row1));
					}else {
						$("<td><figure class='snip1384'><img alt='sample83' src='"+storylist.img+"' id='"+storylist.storyno+"' width='300' height='300'/>" 
								+" <figcaption><center><h3 style='vertical-align:middle;'>"+storylist.title+"</h3>"+
								"</center><i class=\"ion-ios-arrow-right\"></i></figcaption>"
								+"</figure></td>").appendTo($("#st_table tbody #"+row2));
					}
			});
				row1=row1+2;
				row2=row2+2;
		}
	});
};
</script>
<!-- Head -->
<body>
	</center>
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
            <li><a href="../../mainpage/main.jsp"><span class="glyphicon glyphicon-home" style="color:white;">HOME</span></a></li>
            <li><a href="../../intro/information.jsp"><span class="glyphicon glyphicon-globe" style="color:white;">여행정보</span></a></li>
            <li><a href="story.jsp"><span class="glyphicon glyphicon-camera" style="color:white;">스토리</span></a></li>
            <li><a href="../../newchat/client.jsp"><span class="glyphicon glyphicon-send" style="color:white;">채팅</span></a></li>
           <li><a href="../../mypage/mypage.jsp"><span class="glyphicon glyphicon-user" style="color:white;">MyPAGE</span></a></li>
            <li><a href="../../login/logout_ok.jsp"><span style="font-size: 5px; color:black;">Logout</span></a></li>
            <li><a href="../../login/deleteForm.jsp"><span style="font-size: 5px; color:black;">resign</span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <br/><br/>
    <center>
    <br/><br/><br/><br/>
	</center>
	
	<img src="../../images/home-bg1.jpg" width="110%" height="400px " style="opacity: 0.8">
	<br><br><br><br><br><br><br>

<!-- Table -->
	<center style="background-color: white;">
	<div id="mask"></div>
	<div class="sPosition"></div>
	<center>
		<table id="st_table">
			<%
			int j=0;
			int k=0;
			for(int i=0; i<Math.ceil((double)list.size()/4); i++) {
				%>
				<tr>
					<%
						if(i==0) {
							j=0;
							k=j+4;
						} else {
							k=j+4;
						}
					%>
					<%
					for(;j<k&&j<list.size(); j++) {
						%>
						<td>
							<figure class="snip1384">
										<img alt="sample83" src="<%=list.get(j).getPath()%>" 
										width="300" height="300" id="<%=list.get(j).getStoryno()%>">
								<figcaption>
									<center>
									<h3 style="vertical-align:middle;"><%=list.get(j).getStoryname() %></h3>
									</center>
									<i class="ion-ios-arrow-right"></i>
								</figcaption>
									
							</figure>
						</td>
						
						<%
					}
					%>
				</tr>
				<%
			}
			%>
		</table>
<!-- /table -->
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<!-- footer -->
<div style="background-color: #585858; opacity:0.8; position:relative; top:100px; color: white; width:100%; height:200px; " >            
	<strong style="position:relative; top:160px; text-shadow: -0.6px 0 black, 0 0.6px black, 0.6px 0 black, 0 -0.6px black;">COPYRIGHT 2017 ⓒ How_To_Trip ALL RIGHTS RESERVED</strong>         
</div>
</body>
</html>