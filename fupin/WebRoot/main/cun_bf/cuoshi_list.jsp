<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<link href="${appPath}main/main_data/manage.css" rel="stylesheet">
		<script src="${appPath}js/jquery.js" language="javascript"></script>
		<script src="${appPath}js/sel_style.js" language="javascript"></script>
		<script src="${appPath}js/common.js" language="javascript"></script>
<script language="javascript">
var msg = '${msg}';
		if(msg != ''){
			alert(msg);
		}
		function checkAll(obj){
			if($(obj).attr('checked')){
				$('input[type="checkbox"]').attr('checked',true);
			}else{
				$('input[type="checkbox"]').attr('checked',false);
			}
		}
		function deleteInfo(){
			if(confirm('您确定删除吗？') && $('input:checked').length>0){
				document.forms[0].action = '${appPath}cun_bf_deleteCuoshiCun.action';
				document.forms[0].submit();
			}
		}
</script>
</head><body>

<form method="get" action="${appPath}cun_bf_cuoshiCunList.action" name="searchForm">

<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_search">
	<tbody><tr>
	<td>您当前所处页面：村帮扶维护&gt;&gt;帮扶措施 </td>
	<td><a href="#" onclick="winOpen('${appPath}cun_viewCun.action?cun.id=${userObj.cun.id}',750,650);" style="color:white;">村详细资料</a></td>
	<td align="right">

	<label>措施类型: </label>
	<select   size="1" name="cuoshi.type">
		<option value=""></option>
		<option value="年度措施" <c:if test="${cuoshi.type=='年度措施'}">selected="selected"</c:if>>年度措施</option>
		<option value="季度措施" <c:if test="${cuoshi.type=='季度措施'}">selected="selected"</c:if>>季度措施</option>
	</select>

	<label>措施状态: </label>
	<select name="cuoshi.status" size="1">
		<option value="">--------------</option>
		<option value="未提交">未提交</option>
		<option value="审核中">审核中</option>
		<option value="审核通过">审核通过</option>
		<option value="审核不通过">审核不通过</option>
	</select>

		<input type="submit" class="button" value="查询"> 
		<input type="button" onclick="winOpen('${appPath}cun_bf_editCunCuoshi.action',600,390);" class="button" value="新增">
		<input type="button" onclick="deleteInfo();" class="button" value="删除">
	</td>
	<td width="5px" align="right"></td>
	</tr>
</tbody></table>
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_table">
	
	<tbody><tr align="center">
		<td height="28" width="6%" class="tables_headercell">
		<input type="checkbox" onclick="checkAll(this);">
		<td width="" class="tables_headercell">编号</td>
		<td width="" class="tables_headercell">类型</td>
		<td width="" class="tables_headercell">时间</td>
		<td class="tables_headercell">贫困村名</td>
		<td width="" class="tables_headercell">审核状态</td>
		<td width="" class="tables_headercell">查看</td>
		<td width="" class="tables_headercell">修改</td>
	</tr>
	<c:forEach items="${pageBean.resultList}" var="f">
		<tr>
		<td height="25" align="center" class="tables_contentcell">
		<input type="checkbox" value="${f.id}" name="cuoshiCun_ids" class="cuoshiCun_ids">
		<input type="hidden" value="2" name="sftj3981" id="sftj3981">
		</td>
		<td height="25" align="center" class="tables_contentcell">
			${f.id }
		</td>
		<td height="25" align="center" class="tables_contentcell">
			${f.type }
		</td>
		<td height="25" align="center" class="tables_contentcell">&nbsp;
			${f.year }
		</td>
		<td height="25" align="center" class="tables_contentcell">&nbsp;
			${f.cun.name }
		</td>
		<td height="25" align="center" class="tables_contentcell">&nbsp;
			<c:if test="${f.status=='未提交'}">
			<a href="#" onclick="winOpen('${appPath}cun_bf_confirmCuoshi.action?cuoshi.id=${f.id}',600,390);">确认后提交</a>
			</c:if>
			<c:if test="${f.status!='未提交'}">
			${f.status }
			</c:if>
		</td>
		<td height="25" align="center" class="tables_contentcell">
		<a onclick="winOpen('${appPath}cun_bf_saveOrUpdateCuoshiCun.action?cuoshi.id=${f.id}',600,390);" href="#">查看</a>
		</td><td height="25" align="center" class="tables_contentcell">
		<c:if test="${f.status=='未提交'}">
		<a href="#" onclick="winOpen('${appPath}cun_bf_saveOrUpdateCuoshiCun.action?cuoshi.id=${f.id}',600,390);">修改</a>
		 </c:if>
		 <c:if test="${f.status!='未提交'}">
		不能修改
		</c:if>
		</td>
		</tr>
			</c:forEach>
	<tr>
		<td height="25" align="right" class="tables_contentcell" colspan="8">
		<jsp:include page="../../pager.jsp"></jsp:include>
		</td>
	</tr>
</tbody></table>
</form>
</body></html>