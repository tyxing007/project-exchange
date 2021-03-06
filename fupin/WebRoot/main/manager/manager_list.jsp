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
				document.forms[0].action = '${appPath}manager_deleteManager.action';
				document.forms[0].submit();
			}
		}
		function batchStop(){
			if(confirm('您确定停用吗？') && $('input:checked').length>0){
				document.forms[0].action = '${appPath}manager_batchStop.action';
				document.forms[0].submit();
			}
		}
		function batchResume(){
			if(confirm('您确定恢复吗？') && $('input:checked').length>0){
				document.forms[0].action = '${appPath}manager_batchResume.action';
				document.forms[0].submit();
			}
		}
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
		<form method="get" action="${appPath}manager_managerList.action" name="searchForm">
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_search">
				<tbody>
					<tr>
						<td>
							您当前所处页面：帮扶单位管理 >> 单位管理员帐号管理
						</td>
						<td align="right">
							<label>管理登录名/单位名称（模糊查询）: </label>
							<input name="queryKey" value="${param.queryKey}" type="text"/>
							<input type="submit" class="button" value="查询"> 
							<c:if test="${userObj.roleType=='超级管理员' || userObj.roleType=='市级管理员'}">
							<input type="button" onclick="winOpen('${appPath}main/manager/manager_edit.jsp',450,220);" class="button" value="新增">
							<input type="button" onclick="deleteInfo();" class="button" value="删除">
							<input type="button" onclick="batchStop();" class="button" value="批量停用帐号">
							<input type="button" onclick="batchResume();" class="button" value="批量恢复帐号">
							</c:if>
						</td>
						<td width="5px"></td>
					</tr>
				</tbody>
			</table>
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_table">
				<tbody>
					<tr align="center">
						<td height="28" width="6%" class="tables_headercell">
							<input type="checkbox" onclick="checkAll(this);">
						<td width="" class="tables_headercell">
							帐号名
						</td>
						<td width="" class="tables_headercell">
							单位名称
						</td>
						<c:if test="${userObj.isDiv!='Y'}">
						<td width="" class="tables_headercell">
							直属区（县）
						</td>
						</c:if>
						<td width="" class="tables_headercell">
							说明
						</td>
						<td width="" class="tables_headercell">
							帐号状态
						</td>
						<td width="" class="tables_headercell">
							操作
						</td>
					</tr>
					<c:forEach items="${pageBean.resultList}" var="f">
						<tr>
							<td height="25" align="center" class="tables_contentcell">
								<input type="checkbox" value="${f.id}" name="ids">
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.loginName}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.orgName}
							</td>
							<c:if test="${userObj.isDiv!='Y'}">
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.area.name}
							</td>
							</c:if>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.remark}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
								<c:if test="${f.segment5=='1'}">已停用</c:if>
								<c:if test="${f.segment5!='1'}">正常</c:if>
							</td>
							<td height="25" align="center" class="tables_contentcell">
								<c:if test="${userObj.roleType=='超级管理员' || userObj.roleType=='市级管理员'}">
								<a href="#" onclick="winOpen('${appPath}manager_viewManager.action?org.id=${f.id}',450,220);">修改</a>
								</c:if>
								<a href="${appPath}login.action?username=${f.loginName}&password=${f.password}&needRand=N" target="_top">登录</a>
								<!-- a href="${appPath}manager_stopResume.action?org.id=${f.id}">停用/恢复</a> -->
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td height="25" align="right" class="tables_contentcell" colspan="7">
							<jsp:include page="../../pager.jsp"></jsp:include>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</body>
</html>