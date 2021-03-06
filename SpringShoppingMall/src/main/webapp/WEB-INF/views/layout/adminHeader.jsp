<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">

<link rel="shortcut icon" href="/kr/ko/favicon.ico">

<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/ui.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/board.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/layout.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/layer.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/member.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/cs.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/mypage.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/search.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/product.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/cart.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/brand.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/event.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/beautylife.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/policy.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/modify-my-info.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/coupon.css">

<script type="text/javascript" src="<%=cp%>/resources//js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resources//js/jquery-ui.js"></script>

<link href="<%=cp %>/project/member/css/layout.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=cp %>/project/member/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=cp %>/project/member/js/jquery.leanModal.min.js"></script>


<style type="text/css">
.
#fonts-loaded body { /* 웹 폰트 다운로드 전에는 화면을 보여주지 않음 */
	display: none;
}

.wf-notosanskrregular-n4-active body {
	/* 웹 폰트 사용이 가능하면 화면을 보여주고 웹 폰트 속성 적용 */
	display: block;
	font-family: 'Noto Sans Korean', 'NotoSansKR-Regular', sans-serif;
}
.searchHeader {
	text-rendering: auto;
    color: initial;
    letter-spacing: normal;
    word-spacing: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
    display: inline-block;
    text-align: start;
    margin: 0em;
    font: 400 13.3333px Arial;
    font-family: 'Noto Sans Regular','Spoqa Han Sans JP','맑은 고딕',Dotum,'Apple SD Gothic Neo',Sans-serif;
    font-size: 14px;
    letter-spacing: 1px;
    padding-bottom: 10px;
    padding-top: 10px;
    padding-left: 35px;
    width: 480px;
    background: url(//s1.codibook.net/images/header/search.png) no-repeat 5px 50%;
    background-size: 24px 24px;
    border: 0;
    border: 1.5px solid #8080FF;
    outline: 0;
    transition: width 150ms cubic-bezier(.165,.84,.44,1),opacity 150ms cubic-bezier(.165,.84,.44,1);
}
</style>

</head>
<body>
	<div class="ap_wrapper">
	
		<div id="header" class="ap_header" style="height: 180px;">

		<div class="inner_wrap">
			<ul class="header_menu">
				<li>
					<c:choose>
						<c:when test="${empty sessionScope.customInfo.userId }">
						<a href="<%=cp %>/mem/login.action"  class="log">로그인</a>
						</c:when>
						<c:otherwise>
						<a href="<%=cp %>/mem/logout.action"  class="log">로그아웃</a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
			<h1 class="logo">
				<a href="<%=cp %>/admin/memberList.action">
					<img style="padding-top:12px;  width: 230px;" alt="" src="<%=cp %>/resources/image/logo3.png"/>
				</a>
			</h1>
		</div>
		
		<div style="border-bottom: 1px solid #ebebeb;" ></div>