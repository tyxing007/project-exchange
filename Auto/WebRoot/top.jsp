<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<!-- begin头部附属栏框架 -->
<form action="LoginAction.htm" method="post">
<div class="header-top hide">
  <div class="mauto w980 bg03 h23">
    <div class="fl mar_r25 mar_l20"><img src="Themes/images/ico-bookmark.gif" alt="加入收藏" /><a href="#" class="white mar_l10">加入收藏</a></div>
    <div class="fl mar_r5 white"><a href="#" class="yellow" title="站点首页">张家口汽车网</a>&nbsp;，欢迎你！</div>
    
    
                             <div class="fr white mar_r20">
                    <!-- to Programmer  此层为w未登录才显示 -->
                  <span class="">
                  <div class="fl mar_l10 white">
                  用户名：<input name="username" type="text" class="gray mar_l10 input02" />&nbsp;&nbsp;
                  密码:<input name="password" type="password" class="gray mar_l5 input02" />&nbsp;&nbsp;
                  验证码：<input id="verification_code" onfocus="$('#yanzheng').show();" style="width:25px;" type="text" name="rand" onkeypress="formKeyPress(event);" class="gray mar_l5 input02"/>
                  <img src="${appPath}/rand" alt="验证码" id="yanzheng" height="17" style="display:inline;"/>
                  <input class="mar_l5 btn-log" type="submit" value="登 录" /><input class="mar_l10 btn-reg" type="submit" value="注册新用户" />
                  </div>
                  </span>
                    <!-- to Programmer -->
                    <div class="w300 ml10 none">
                        <!-- to Programmer  此层为登录后才显示 -->
                        <p class="fl">
                            欢迎您，</p>
                        <!-- to Programmer -->
                        <p class="fl mar_r10 w120 h18 hide yellow">年轻人
                            <span></span>
                        </p>
                        <!-- 请控制此处用户名显示字数(最多6个汉字,12个字母数字)，否则超长用户名将会导致页面结构混乱 -->
                        <p class="fl mar_r3">
                            站内信(<a href="#" target="_blank"><span class="fcred"></span></a>)</p>
                        <p class="fl">
                            <a href="#" title="退出" class="gray">[退出]</a></p>
                    </div>
                </div>
                             </div>
                <div class="clear"></div>
</div>
</form>     
    <!-- end头部附属栏框架 -->         

     <!-- begin头部框架 -->
     <div class="header">
       <div class="">
         <div class="w250 fl"><a href="index.htm"><img src="Themes/images/logo.jpg" alt="网站标志" /></a></div>
         <div class="fr w730 g_t_c h76"><img src="Themes/images/banner.jpg" alt="banner" width="728" height="74" class=" b_gray" /></div> 
         <div class="clear"></div> 
       </div>
       
       <div class="clearfix">
         <div class="w240 fl bg02 g_t_c pad_5">张家口资讯网 旗下分站 www.zjk169.net</div>
         <div class="fr w730 mainNav">
         	<a href="index.htm">首 页</a> {购车}
         	<a href="sale4s.htm">张家口4S店</a> 
         	<a href="specialList.htm">本地动态</a> 
         	<a href="jjXinde.htm">购车心得</a> 
         	<a href="other.htm?news.type=4">专业测评</a> 
         	<a href="other.htm?news.type=9">北京降价</a>
         	<a href="other.htm?news.type=5">汽车保险</a> [用车]
         	<a href="other.htm?news.type=6">维修保养</a> 
         	<a href="other.htm?news.type=7">养车成本</a> 
         	<a href="other.htm?news.type=8">汽车装饰</a></div>  
       </div>
         
     
     
       
       <div class="clear"></div>
     </div>
     <!-- end头部框架 -->
