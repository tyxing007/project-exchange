<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset==gbk" />
	<title>推我网 - 会员中心 - 我的推客联盟网站</title>	
	<link href="/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="/css/mian.css" rel="stylesheet" type="text/css" />
	<link href="/css/member.css" rel="stylesheet" type="text/css" />
	<script src="/js/jquery.js" type="text/javascript"></script>
	<script src="/js/member.js" type="text/javascript"></script>
</head>
<body>
	<#include "/WEB-INF/template/include/head.ftl">
	<!-- 顶部区域结束 -->
	<div id="mian">		
		<#include "/WEB-INF/template/include/member_nav.ftl">
		<!-- 内容区域 -->
		<div class="body_content">
			<#include "/WEB-INF/template/include/member_left.ftl">
			<div class="list_body">
			    <div class="list_box">
			       <div class="list_box_title">
				   		<ul><li>我的推客联盟网站</li></ul>
				   </div>
				   <div class="list_box_content">
					   <table class="task_tble" border="0" cellspacing="1">
						   <tr>
						   		<th>编号</th>
						   		<th>网站名称</th>
						   		<th>网站地址</th>
						   		<th>加入时间</th>
						   </tr>
						   <#list pageBean.resultList as a>
						   <tr>
						   		<td>${a.id}</td>
						   		<td>${a.siteName?html}</td>
						   		<td>${a.siteURL?html}</td>
						   		<td>${(a.date?string('yyyy-MM-dd'))?default('')}</td>
						   </tr>
						   </#list>
					   </table>
<div class="pager">
	共<strong>${pageBean.totalRow}</strong>条记录&nbsp;&nbsp;
	每页${pageBean.rowPerPage}条 &nbsp;&nbsp;
	第${pageBean.pageIndex}页/共${pageBean.maxPage}页&nbsp;&nbsp;
	<#if !pageBean.isFirstPage>
		<a href="javascript:gotoPage(1);">[首页]</a>
	<#else>
		[首页]
	</#if>
	<#if !pageBean.isFirstPage>
		<a href="javascript:gotoPage(${pageBean.prePageIndex });">[前一页]</a>
	<#else>
		[前一页]
	</#if>
	<#if !pageBean.isLastPage>
		<a href="javascript:gotoPage(${pageBean.nextPageIndex });">[后一页]</a>
	<#else>
		[后一页]
	</#if>
	<#if !pageBean.isLastPage>
		<a href="javascript:gotoPage(${pageBean.maxPage });">[尾页]</a>
	<#else>
		[尾页]
	</#if>	
</div>
			       </div>
			   </div>
			</div>
		</div>
		<!-- 内容区域结束 -->
		<#include "/WEB-INF/template/include/foot.ftl">
	</div>
</body>
</html>