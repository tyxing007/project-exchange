<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	response.setHeader("Cache-Control","no-cache, must-revalidate");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Last-Modified",new java.util.Date().toString());
	response.setDateHeader("Expires",   0);  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Free CSS Vertical Menu Designs at exploding-boy.com</title>
		<script src="js/jquery.js"></script>
        <style type="text/css">    
        <!--
        
	        html {
	            height: 100%;
	            overflow: hidden;
	        }
	        
	        body {
	            font-family: Verdana, Arial, Helvetica, sans-serif;
	            margin: 0;
	            margin-right: 6px;
	            font-size: 80%;
	            font-weight: bold;
	            background: url(images/lbg.jpg) repeat-y right #F4F7FB;
	        }
	        
	        h2 {
	            font: bold 14px Verdana, Arial, Helvetica, sans-serif;
	            color: #000;
	            margin: 15px 0px;
	            padding: 0;
				text-align:center;
	        }
	        
	        ul {
	            list-style: none;
	            margin: 0;
	            padding: 0;
	        }
	        
	        img {
	            border: none;
	        }
	        
	        /*- Menu 3--------------------------- */ #menu3 {
	            width: 154px;
	            margin: 3px;
	            border-style: solid solid none solid;
	            border-color: #BCD2E6;
	            border-size: 1px;
	            border-width: 1px;
	        } 
			
			#menu3 li a {
	            height: 32px;
	            voice-family: "\"}\"";
	            voice-family: inherit;
	            height: 24px;
	            text-decoration: none;
	        } 
			
			#menu3 li a:link, #menu3 li a:visited {
	            color: #8BADCF;
	            display: block;
	            background: url(images/menu3.gif);
	            padding: 8px 0 0 10px;
	        } 
			
			#menu3 li a:hover, #menu3 li #current { 
	        	color:#627EB7;
	        	background:url(images/menu3.gif) 0 -32px;
	        	padding:8px 0 0 10px;
	        }
            -->
        </style>
		<script>
   			$(function(){
   				var onCss = {color:'#627EB7',background:'url(images/menu3.gif) 0 -32px'};
				var leaveCss = {color:'#8BADCF',background:'url(images/menu3.gif)'};
				$("li a").click(function(){
					var tmp = this;
					$("li a").each(function(i){
						if (this == tmp) {
							$(this).css(onCss);	
							$(this).hover(function(){	
								$(this).css(onCss);	
							},function(){
								$(this).css(onCss);	
							});
							top.document.getElementById('pos2').innerHTML = this.innerHTML;
						}else{
							//alert(i);
							$(this).css(leaveCss);	
							$(this).hover(function(){	
								$(this).css(onCss);	
							},function(){
								$(this).css(leaveCss);	
							});
						}
					});
				});
				$("li a:first").css(onCss);
				//parent.frames[1].location.href = 'left.html';
				
				//alert(window.top['currMenu']);
				var menuList = window.top['menuList'];
				var currMenu = window.top['currMenu'];				
				
				if(currMenu!=null){
					for(var i=0;i<menuList.length;i++){
						if(menuList[i]['title'] == currMenu){
							currMenu = i;
						}
					}
					$('#defaultTitle').html(menuList[currMenu]['title']);
					/*$('#defaultMenu li a').each(function(i){
						//alert(this.innerHTML);						
					});*/
					$('#defaultMenu li').empty();
					$('#defaultMenu li').each(function(i){
						var menu = null;
						for(var j=0;j<menuList[currMenu]['menu'].length;j++){
							menu = menuList[currMenu]['menu'][j];
							$(this).append('<a id="current" target="rightFrame" href="'+menu['url']+'">'+menu['title']+'</a>');
						}						
					});
					
				}
				
				$("a").each(function(){
					$(this).click(function(){
						$(this).css({"color":"red"});
						var tmp = this;
						$("a").each(function(){
							if(tmp != this){
								$(this).css({"color":""});
							}
						});
					});
				});
				
   			});
        </script>
    </head>
    <%-- 
    <body>
    	<c:if test="${empty sess_pages}">
    		<jsp:forward page="left.html"></jsp:forward>
    	</c:if>
        <h2>${sess_curr_module.name}</h2>
        <div id="menu3">
            <ul>
            	<c:forEach var="p" items="${sess_pages}">
				<li><a href="${app_path }${p.url }" target="rightFrame">${p.name }</a></li>
				</c:forEach>
            </ul>
        </div>
    </body>--%>
    <body>
        <h2 id="defaultTitle">欢迎页面</h2>
        <div id="menu3">
            <ul id="defaultMenu">
                <!-- CSS Tabs -->
				<li>
                    <a id="current" href="welcome/welcome.jsp" target="rightFrame">系统信息概况</a>
                    <a id="current" href="welcome/pwd.jsp" target="rightFrame">修改密码</a>
                </li>
            </ul>
        </div>
    </body>
</html>


