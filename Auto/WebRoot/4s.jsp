<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
    <title>${appTitle}</title>
    <meta name="description" content="${appDesc}" />
    <meta name="keywords"  content="${appKeywords}" />
    <link href="Themes/basic.css" type="text/css" rel="stylesheet" />
    <link href="Themes/pagestyle.css" type="text/css" rel="stylesheet" />
    <script src="js/jquery.js"></script>
    <script src="js/common.js"></script>
</head>
<body>

    <!-- begin头部附属栏框架 -->
<div class="header-top hide">
  <div class="mauto w980 bg03 h23">
    <div class="fl mar_r20 mar_l20 white"><a href="#" class="white">张家口汽车网</a> >> <a href="#" class="white">张家口销售商频道</a></div>
                <div class="fr mar_r25 mar_l20"><img src="Themes/images/ico-homepage.gif" alt="加入收藏" /><a href="#" class="white mar_l10">返回网站首页</a></div>
    <div class="fr mar_r5 white"><a href="#" class="yellow" title="申请经销商">申请经销商</a></div>
  </div>
                <div class="clear"></div>
</div>
            
    <!-- end头部附属栏框架 -->         

     <!-- begin头部框架 -->
     <div class="header">
       <div class="">
         <div class="w250 fl"><a href="index.htm"><img src="Themes/images/logo.jpg" alt="网站标志" /></a><div class="w240 bg02 g_t_c pad_5">张家口资讯网 旗下分站 www.zjk169.net</div></div>
         
         <div class="fr banner"><p class="mar_t30 mar_l40 fb yahei ft20">${sale.fullName }</p> 
<p class="mar_t10 mar_l40">销售热线：${sale.tel } 地址：${sale.address }</p>  
</div> 
         <div class="clear"></div> 
       </div>
       
       <div class="clear"></div>
     </div>
     <!-- end头部框架 -->
    
    <!---- begin正文框架 ---->
    
<div class="wrapper mauto pad_5">
  <div class="mainNav02">
        <div class="fl mar_l100"><a href="#">首 页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="carList.htm?sale.id=${sale.id}">车型列表</a></div>
        <div class="fr mar_l10 white">
                <form action="LoginAction.htm" method="post">  
                用户名：<input name="username" type="text" class="gray mar_l10 input02" />&nbsp;&nbsp;
                  密码:<input name="password" type="password" class="gray mar_l5 input02" />&nbsp;&nbsp;
                  验证码：<input id="verification_code" onfocus="$('#yanzheng').show();" style="width:25px;" type="text" name="rand" onkeypress="formKeyPress(event);" class="gray mar_l5 input02"/>
                  <img src="${appPath}/rand" alt="验证码" id="yanzheng" height="17" style="display:inline;"/>
         <input class="mar_l5 btn-log" type="submit" value="登 录" />
         <input class="mar_l10 btn-reg" type="submit" value="注册新用户" />
         </form>
         </div>
        <div class="clear"></div>
  </div>
<div class="part01 mar_t6">
           <div class="fl w348 hide">
      <div class="b_3gray">
      <div class="pic-imgnews">
        <img src="${appPath}/image?image=${sale.image}&w=340&230" alt="${sale.fullName }" width="340" height="230" />
      </div>
      </div>
    </div>
      
      
           <div class="fl w350 mar_l20">
               <div class="yahei fb ft16 pad_b10"> <a href="#" target="_blank">公司介绍</a></div>
               <p class="">
               	${sale.description }
               </p>
             </div>
           <div class="fl w240 hide recommend mar_l10">
          <div class="section mar_t6">
            <div class="ptitle02">
              <ul class="tlboxtitle fl">
                <li class="current"> <a href="#" title="推荐任务">本地优惠</a></li>
                <li>本地新闻<a href="#" title="最新任务"></a></li>
              </ul>
              </div>
            <div class=" pad_t5 pad_l10 pad_b10">
            <ul class="dotli01">
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
                 <li><a href="#" target="_blank">[新闻]张家口汽车新闻年</a></li>
               </ul>
              <div class="clear"></div>
            </div>
          </div>
        </div>
        
        <div class="clear"></div>
      </div>
      
      <div class="part02 mar_t6">
        <div class="security_title"><strong>${sale.fullName} 产品列表</strong></div>
        <div class="fl w200 mar_t6 bg04">
              <div class="section_purchase">
                <div class="ptitle">
                  <div class="icon">全部产品列表</div>
                  
                </div>
                <div class="treeNav pad_10">
                <!-- begin 树 -->
                <!-- class="treeNavopen"代表打开状态，class="treeNavclose"代表关闭状态 -->
                <ul style="background: none;">
                    <div class="treeNavopen">
                        <a href="#">第一级</a></div>
                    <ul>
                        <div class="treeNavclose">
                            <a href="#">第二级</a></div>
                        <ul>
                            <div class="treeNavdot1">
                                <a href="#">第三级</a></div>
                        </ul>
                    </ul>
                    <ul>
                        <div class="treeNavopen">
                            <a href="#">第二级</a></div>
                    </ul>
                </ul>
                <ul style="background: none;">
                    <div class="treeNavopen">
                        <a href="#">第一级</a></div>
                    <ul>
                        <div class="treeNavopen">
                            第二级</div>
                    </ul>
                    <ul>
                        <div class="treeNavopen">
                            第二级</div>
                    </ul>
                </ul>
                <!-- end 书 -->
            </div>
              </div>
        </div>
        <div class="fl w750 hide mar_l10 mar_t6">
          <table width="100%" align="center" cellpadding="1" cellspacing="1" class="tblist01">
            <tbody>
              <tr class="title2">
                <td width="8%" class="fb g_t_c">车型（产品）图片</td>
                <td width="16%" class="fb g_t_c">名称型号</td>
                <td width="12%" class="fb g_t_c">经销商报价</td>
                <td width="8%" class="fb g_t_c">报价时间</td>
              </tr>
              <c:forEach items="${carPageBean.resultList}" var="c" varStatus="status">
              <tr class="list" onmouseover="this.className='list3';" onmouseout="this.className='list';">
                <td class="g_t_c"><a href="#" target="_blank">
                	<img src="${appPath}/image?image=${c.image}&w=70&h=52" class="b_gray" /></a>
                </td>
                <td class="g_t_c">${c.fullName}</td>
                <td class="g_t_c yellow_ef">￥${c.price}</td>
                <td class="g_t_c gray">${c.priceDate }</td>
              </tr>
              </c:forEach>
              <tr>
                <td class="g_t_c" colspan="4">
                	<c:choose>
						<c:when test="${!carPageBean.isFirstPage}">
							<a href="javascript:gotoPage(1);" class="nextprev">第一页</a>
							<a href="javascript:gotoPage(${carPageBean.prePageIndex });" class="nextprev">上一页</a>
						</c:when>
						<c:otherwise>
							<span class="nextprev">第一页</span>
							<span class="nextprev">上一页</span> 
						</c:otherwise>
					</c:choose>
					<span class="current">
                  		${carPageBean.pageIndex }/${carPageBean.maxPage }
                  	</span> 
					<c:choose>
						<c:when test="${!carPageBean.isLastPage}">
							<a href="javascript:gotoPage(${carPageBean.nextPageIndex });" class="nextprev">下一页</a>
							<a href="javascript:gotoPage(${carPageBean.maxPage });" class="nextprev">最后一页</a>
						</c:when>
						<c:otherwise>
							<span class="nextprev">下一页</span>
							<span class="nextprev">最后一页</span>
						</c:otherwise>
					</c:choose>
                </td>
              </tr>
            </tbody>            
          </table>
        </div>
            <div class="clear"></div>
  </div>


      <div class="clear"></div>
</div>
<!-- end正文框架 -->
 
<jsp:include page="bottom.jsp"></jsp:include>

</body>
</html>
