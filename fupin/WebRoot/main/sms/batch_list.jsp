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
				document.forms[0].action = '${appPath}mes_deleteMessage.action';
				document.forms[0].submit();
			}
		}
		function passInfo(){
			if(confirm('您确定通过审核吗？') && $('input:checked').length>0){
				document.forms[0].action = '${appPath}zixun_passZixun.action';
				document.forms[0].submit();
			}
		}
		function notpassInfo(){
			if(confirm('您确定不通过审核吗？') && $('input:checked').length>0){
				document.forms[0].action = '${appPath}zixun_notPassZixun.action';
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
<style type="text/css">

.tip{
    position:relative;
    color:#00c;
    text-decoration:none;    
    padding:5px;
    z-index:0;
}
.tip:hover{
    background:none;
    text-decoration:none;
    color:#000;
    z-index:1;
}
.tip span {
    display: none;
    text-decoration:none;
}
.tip:hover span{
    display:block;
    position:absolute;top:20px;left:10px;
    border-bottom:0px solid #eee;
    text-decoration:none;
    border-right:0px solid #eee;
    width:300px;
}
.tip:hover span p {
    
    text-align:left;
    text-decoration:none;
    padding:5px;   
    border:1px solid #ccc;
    background:#cff;
}
</style>
	</head>
	<body>
		<form method="get" action="${appPath}org_leaderList.action" name="searchForm">
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_search">
				<tbody>
					<tr>
						<td>
							您当前所处页面：批量短信发送记录
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
						<td width="" class="tables_headercell">
							序号
						</td>
						<td width="" class="tables_headercell">
							发信人
						</td>
						<td width="" class="tables_headercell">
							发送时间
						</td>
						<td width="" class="tables_headercell">
							内容
						</td>
						<td width="" class="tables_headercell">
							详细
						</td>
					</tr>
					<c:forEach items="${pageBean.resultList}" var="f" varStatus="status">
						<tr>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${status.count}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.sender}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								<fmt:formatDate value="${f.date}" pattern="yyyy-MM-dd hh:mm:ss"/> 
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; ${f.content}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; <a href="#" onclick="winOpen('${appPath}sms_batchSMSDetail.action?id=${f.id}',600,300);">详细</a>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td height="25" align="right" class="tables_contentcell" colspan="8"><jsp:include page="../../pager.jsp"></jsp:include>
						<br></td>
					</tr>
				</tbody>
			</table>
		</form>
	</body>
</html>