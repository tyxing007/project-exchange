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

    <jsp:include page="top.jsp" flush="false"></jsp:include>
    
    <!---- begin正文框架 ---->
<div class="wrapper mauto pad_5">
      <div class="search_area">
        <div class="fl ft14 w550 hide">张家口汽车网 <a href="#">首页</a> &gt; <a href="#">购车频道</a> &gt;</div>
<div class="fr w350 pad_l10 bls_gray">
            <div class="fl blue">站内搜索</div>
                        <div class="fl mar_l5">
                          <select name="select" id="select">
                            <option>请输入分类</option>
                          </select>
                        </div>
            <div class="fl mar_l5">
              <input type="text" class="gray input03" value="--请输入关键字--" />
            </div>
                        <div class="fl">
                          <input class="hledat" type="image" src="Themes/images/search-button.gif" name="input" value="Search" alt="Search" />
        </div></div>
      <div class="clear"></div>
      </div>
      
      <div class="mar_t6">
        <div class="fl w724 hide"><div class="pad_20 Main-Article bg04">
          <div class="hd bbd_gray">
            <h1> ${special.title } </h1>
            <div class="titBar mauto">
              <div class="info"> ${special.publishDate } <span class="infoCol"><span class="where"><a target="_blank" href="#">${special.sale.fullName}</a></span></span></div>
            </div>
          </div>
          <div class="mar_t10">
				${special.content}
			</div>
          </div>
          <div class="section_purchase mar_t6">
            <div class="ptitle">
              <div class="icon">相关信息推荐</div>
            </div>
            <div class="pad_20">
              <ul class="dotli01">
                <li><a href="#" target="_blank">新手金牌会员问题总结帖</a><span class="ft10 gray mar_l10">2010-08-08</span></li>
                <li><a href="#" target="_blank">客户选取中标，金牌失效后问题！</a><span class="ft10 gray mar_l10">2010-08-08</span></li>
                <li><a href="#" target="_blank">【子中策划团队】金牌会员故事</a><span class="ft10 gray mar_l10">2010-08-08</span></li>
                <li><a href="#" target="_blank">如何提高充值的安全意识！</a><span class="ft10 gray mar_l10">2010-08-08</span></li>
                <li><a href="#" target="_blank">【金牌会员】这些你了解了多少？</a><span class="ft10 gray mar_l10">2010-08-08</span></li>
              </ul>
            </div>
          </div>
        </div>
        
        <div class="fl w240 hide recommend mar_l6 bg04">
          <div class="section">
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
          <div class="section_purchase mar_t6">
            <div class="ptitle"> <span class="more"><a href="#">更多</a> &gt;&gt;</span>
              <div class="icon">最新动态</div>
            </div>
            <div class="pad_10">
              <ul class="dotli01">
                <li><a href="#" target="_blank">新手金牌会员问题总结帖</a></li>
                <li><a href="#" target="_blank">客户选取中标，金牌失效后问题！</a></li>
                <li><a href="#" target="_blank">【子中策划团队】金牌会员故事</a></li>
              </ul>
            </div>
          </div>
          <div class="section_purchase mar_t6">
            <div class="ptitle"> <span class="more"><a href="#">更多</a> &gt;&gt;</span>
              <div class="icon">网友购车真实感受</div>
            </div>
            <div class="pad_10">
              <ul class="dotli01">
                <li><a href="#" target="_blank">新手金牌会员问题总结帖</a></li>
                <li><a href="#" target="_blank">客户选取中标，金牌失效后问题！</a></li>
                <li><a href="#" target="_blank">【子中策划团队】金牌会员故事</a></li>
              </ul>
            </div>
          </div>
        </div>
        
        <div class="clear"></div>
      </div>
      
      <div class="clear"></div>
</div>
<!-- end正文框架 -->
 
<jsp:include page="bottom.jsp"></jsp:include>

</body>
</html>
