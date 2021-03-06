<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
		<link href="${appPath}main/main_data/manage.css" rel="stylesheet">
		<script src="${appPath}js/jquery.js" language="javascript"></script>
		<script src="${appPath}js/sel_style.js" language="javascript"></script>
		<script src="${appPath}js/common.js" language="javascript"></script>
		<script type="text/javascript" src="${appPath}chart/swfobject.js"></script>
		<script language="javascript">
		var msg = '${msg}';
		if(msg != ''){
			alert(msg);
		}
		var maxYear = '${maxYear}';
		var now = new Date();
		var currYear = now.getYear()<1970?now.getYear() + 1900:now.getYear();
		maxYear = maxYear==''?currYear:parseInt(maxYear);
		var year = '${year}';
		var time = '${month}';
		$(function(){
			var str = '';
			for(var i=1;i<=12;i++){
				str += '<option value="'+i+'">第'+i+'月</option>';
			}
			$('#time').html(str);
			
			for(var i=2011;i<=maxYear;i++){
				$("#year").append('<option value="'+ i +'">'+ i +'</option>');
			}
			
			if(year != ''){
				setTimeout(function(){ 
				  $('#year').val(year);
				},1);
			}
			if(time != ''){
				setTimeout(function(){ 
				  $('#time').val(time);
				},1);
			}
		});
		function query(){
			var f = document.forms[0];
			f.action = "${appPath}report_projectShStat.action";
			f.submit();
		}
		$(function(){
			var so = new SWFObject("${appPath}chart/${item.swf}", "ampie", "750", "${item.height}", "8", "#FFFFFF");
			so.addVariable("path", "${appPath}chart/");
			so.addVariable("chart_settings", encodeURIComponent("${item.setXml}"));
			so.addVariable("chart_data", encodeURIComponent('${item.dataXml}'));
			so.write("rate_chart");
		});	
		</script>
		<style>
.tables_search {
	margin: 0px 0px 2px 0px;
	height: 40px;
	background-color: #418FD0;
}
</style>
	</head>
	<body>
		<form method="get" action="${appPath}family_familyList.action" name="searchForm">
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_search">
				<tbody>
					<tr>
						<td>
							您当前所处页面：白云区工商联企业帮扶钟落潭镇项目进度表
						</td>
						<td align="right">
							&nbsp;
						</td>
						<td width="5px"></td>
					</tr>
					
				</tbody>
			</table>
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_table">
				<tbody>
					<tr align="center">
						<td width="" class="tables_headercell" colspan="1">
							年度：
							<select name="year" id="year">
								<option value=""></option>
							</select>
						</td>
						<td width="" class="tables_headercell">
							时间：
							<select name="month" id="time">
								<option value=""></option>
							</select>
						</td>
						<td width="" class="tables_headercell">
							<input type="button" value="按条件查询" class="button" name="查询" onclick="query();">
							&nbsp;
							<input type="button" value="Excel导出" class="button" name="Excel导出" onclick="exportExcel('data_table');">
						</td>
					</tr>
				</tbody>
			</table>
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_table" id="data_table">
				<tbody>
					<tr align="center">
						<td width="" class="tables_headercell" rowspan="2">
							捐赠企业名称
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							企业负责人
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							职务
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							区工商联职务
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							项目落实人
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							捐赠金额（万元）
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							捐赠项目名称
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							受捐赠单位负责人
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							职务
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							项目内容
						</td>
						<td width="" class="tables_headercell" colspan="3">
							项目用地性质
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							项目进度
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							存在问题
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							预计完成时间
						</td>
						<td width="" class="tables_headercell" rowspan="2">
							总体进度
						</td>
					</tr>
					<tr align="center">
						<td width="" class="tables_headercell" rowspan="1">
							现状
						</td>
						<td width="" class="tables_headercell" rowspan="1">
							用地现状
						</td>
						<td width="" class="tables_headercell" rowspan="1">
							规划性质
						</td>
					</tr>
					<c:forEach items="${pageBean.resultList}" var="f">
						<tr>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.org.orgName }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.fuzeren }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.zhiwu }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.gongshangZhiwu }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.luoshi }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.money }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.name}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.shouFuzeren }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.shouZhiwu }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.content }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.yongdi1 }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.yongdi2 }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.project.yongdi3 }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.complete }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.problem }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.money }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; <c:if test="${not empty f.rate }">${f.rate }%</c:if>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${pageBean.isLastPage }">
						<tr>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 合计
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${pageBean.total[0] }
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp;
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp;
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
							</td>
						</tr>
					</c:if>
					<tr>
						<td height="25" align="right" class="tables_contentcell" colspan="17">
							<jsp:include page="../../pager.jsp"></jsp:include>
						</td>
					</tr>
					<c:if test="${not empty item }">
					<tr>
						<td colspan="17" align="center" class="tables_contentcell">
							<h2 style="margin-top: 50px;">项目完成进度表</h2>
							<div id="rate_chart">您需要升级您浏览器的Flash播放器!</div>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</form>
	</body>
</html>