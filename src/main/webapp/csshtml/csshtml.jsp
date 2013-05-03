<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getContextPath();
	String res = basePath +"resources";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="res/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="res/js/lanrenzhijia.js"></script>
<title>jquery+css3实现在线编辑涂鸦画板功能</title>
<style type="text/css">
.btn{
-webkit-transform-style: preserve-3d;
-moz-transform-style: preserve-3d;
-ms-transform-style: preserve-3d;
-o-transform-style: preserve-3d;
transform-style: preserve-3d;
-webkit-transition: -webkit-transform .2s;
-moz-transition: -moz-transform .2s;
-ms-transition: -ms-transform .2s;
-o-transition: -o-transform .2s;
transition: transform .2s;
width:60px;
height: 30px;
border: 0px;
display: block;
float: left;
margin-left: 6px;
}
.btn:hover{
-webkit-transform:scale(1.05);
transform:scale(1.05);
}
.btn:ACTIVE{
-webkit-transform:scale(0.9);
transform:scale(0.9);
}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/lanrenzhijia.js"></script>
</head>
<body>
<canvas id="canvas" width="600" height="500" style="border:1px solid #999;position:absolute;top:50px;left:50px;"></canvas>
	<canvas id="canvas2" width="600" height="500" style="border:1px solid #999;position:absolute;top:50px;left:50px;"></canvas>
	<span class="btn" onClick="$('#forbiden_back').fadeIn(300)" style="background-image: url(res/img/open_url.png)"></span>
	<span class="btn" onClick="change_attr(0,-1,-1)" style="background-image: url(res/img/pencil.png)"></span>
	<span class="btn" onClick="change_attr(1,-1,-1)" style="background-image: url(res/img/straight.png)"></span>
	<span class="btn" onClick="change_attr(2,-1,-1)" style="background-image: url(res/img/star_straight.png)"></span>
	<span class="btn" onClick="change_attr(3,-1,-1)" style="background-image: url(res/img/circle.png)"></span>
	<span class="btn" onClick="change_attr(4,-1,-1)" style="background-image: url(res/img/rect.png)"></span>
	<span class="btn" onClick="gaussian()" style="background-image: url(res/img/blur.png)"></span>
	<span class="btn" onClick="change_attr(5,-1,-1)" style="background-image: url(res/img/eraser.png)"></span>
	<span class="btn" onClick="fill_canvas('#ffffff',0,0,canvas_size.x,canvas_size.y)" style="background-image: url(res/img/clear.png)"></span>
	<span id="size_span" style="border: 1px solid #999;width:15px;height: 15px;margin-top:7px;margin-left: 50px;display: block;float: left;margin-left: 20px">1</span>
	<div id="size_bar" style="width: 100px;height: 5px;background-color:#999; float: left;margin: 12px;position: relative;">
		<span id="size_thumb" class="btn" onClick="" style="background-color:#666;;width: 15px; border-top-left-radius:8px; border-top-right-radius:8px; border-bottom-left-radius:8px;
		border-bottom-right-radius:8px;height: 15px;margin:0px; margin-top:-5px;position: absolute;left: 0px;"></span>
	</div>
	<span id="color_span" style="border: 1px solid #999;background-color:#00aeef;width:15px;height: 15px;margin-top:7px;display: block;float: left;margin-left: 10px"></span>
	<canvas id="canvas_color" width="198" height="15" style="border:1px solid #999;margin-top:7px;margin-left:10px;float:left;"></canvas>
	
	<div style="width: 300px;height: 300px;position: absolute;left:650px;top:50px;">
		<span id="r_channel_span" style="border: 1px solid #999;width:15px;height: 15px;margin-top:7px;margin-left: 50px;display: block;float: left;margin-left: 20px">r</span>
		<div id="r_channel_bar" style="width: 100px;height: 5px;background-color:#999; float: left;margin: 12px;position: relative;">
			<span id="r_channel_thumb" class="btn" onClick="" style="background-color:#666;;width: 15px; border-top-left-radius:8px; border-top-right-radius:8px; border-bottom-left-radius:8px;
			border-bottom-right-radius:8px;height: 15px;margin:0px; margin-top:-5px;position: absolute;left: 45%;"></span>
		</div>
		<div style="clear: both;"></div>
		<span id="g_channel_span" style="border: 1px solid #999;width:15px;height: 15px;margin-top:7px;margin-left: 50px;display: block;float: left;margin-left: 20px">g</span>
		<div id="g_channel_bar" style="width: 100px;height: 5px;background-color:#999; float: left;margin: 12px;position: relative;">
			<span id="g_channel_thumb" class="btn" onClick="" style="background-color:#666;;width: 15px; border-top-left-radius:8px; border-top-right-radius:8px; border-bottom-left-radius:8px;
			border-bottom-right-radius:8px;height: 15px;margin:0px; margin-top:-5px;position: absolute;left: 45%;"></span>
		</div>
		<div style="clear: both;"></div>
		<span id="b_channel_span" style="border: 1px solid #999;width:15px;height: 15px;margin-top:7px;margin-left: 50px;display: block;float: left;margin-left: 20px">b</span>
		<div id="b_channel_bar" style="width: 100px;height: 5px;background-color:#999; float: left;margin: 12px;position: relative;">
			<span id="b_channel_thumb" class="btn" onClick="" style="background-color:#666;;width: 15px; border-top-left-radius:8px; border-top-right-radius:8px; border-bottom-left-radius:8px;
			border-bottom-right-radius:8px;height: 15px;margin:0px; margin-top:-5px;position: absolute;left: 45%;"></span>
		</div>
	</div>
	<div id="forbiden_back" style="width: 100%;height: 100%;background-image: url(res/img/pattern.png);position: absolute;top: 0px;left: 0px;display: none;">
		<div style="width: 382px;height: 170px;background-image: url(res/img/open_window.png);margin: 0 auto;margin-top: 200px;position: relative;">
			<input id="pic_url" type="text" style="width:250px; margin: 53px;margin-left: 83px;"/>
			<div id="close_window" style="width: 20px;height: 15px;border: 0px solid green;position: absolute;right:20px;top: 10px"></div>
			<div id="open_pic" style="width: 80px;height: 30px;border: 0px solid green;position: absolute;left:155px;top: 102px" onClick="open_img(pic_url)"></div>
		</div>
	</div>
</body>
</html>