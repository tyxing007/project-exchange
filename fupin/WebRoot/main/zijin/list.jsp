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
		$(function(){
			$.getJSON("${appPath}ajax/getAllShi?time="+new Date().getTime(), {}, function(json){
				if(json && json['list'] && json['list'].length){
					$('#shiId').html('');
					for(var i=0;i<json['list'].length;i++)
						$('#shiId').append('<option value="'+json['list'][i]['id']+'">'+json['list'][i]['name']+'</option>');
					selectShi($('#shiId').val());
				}
			});
		});
		var paramAreaId = '${param.areaId}';
		function selectShi(val){
			if(val){
				$.getJSON("${appPath}ajax/getAllArea?time="+new Date().getTime(), {'parentId':val}, function(json){
					if(json && json['list'] && json['list'].length){
						$('#areaId').html('<option value=""></option>');
						for(var i=0;i<json['list'].length;i++)
							$('#areaId').append('<option value="'+json['list'][i]['id']+'">'+json['list'][i]['name']+'</option>');
						if(paramAreaId!=''){
							setTimeout(function(){
								$('#areaId').val(paramAreaId);
								selectArea(paramAreaId);
							},1);
						}
					}
				});
			}
		}
		var paramZhenId = '${param.zhenId}';
		function selectArea(val){
			if(val){
				$.getJSON("${appPath}ajax/getAllZhen?time="+new Date().getTime(), {'parentId':val}, function(json){
					if(json && json['list'] && json['list'].length){
						$('#zhenId').html('<option value=""></option>');
						for(var i=0;i<json['list'].length;i++)
							$('#zhenId').append('<option value="'+json['list'][i]['id']+'">'+json['list'][i]['name']+'</option>');
						if(paramZhenId!=''){
							setTimeout(function(){
								$('#zhenId').val(paramZhenId);
								selectZhen(paramZhenId);
							},1);
						}
					}
				});
			}
		}
		var paramCunId = '${param.cunId}';
		function selectZhen(val){
			if(val){
				$.getJSON("${appPath}ajax/getAllCun?time="+new Date().getTime(), {'parentId':val}, function(json){
					if(json && json['list'] && json['list'].length){
						$('#cunId2').html('<option value=""></option>');
						for(var i=0;i<json['list'].length;i++)
							$('#cunId2').append('<option value="'+json['list'][i]['id']+'">'+json['list'][i]['name']+'</option>');
						if(paramCunId!=''){
							setTimeout(function(){
								$('#cunId2').val(paramCunId);
							},1);
						}
					}
				});
			}
		}
		
		
		
		function query(){
			var f = document.forms[0];
			f.action = "${appPath}zijin_list.action";
			f.submit();
		}
		
		
		var year = '${year}';
		var month = '${month}';
		var now = new Date();
		var currYear = now.getYear()<1970?now.getYear() + 1900:now.getYear();
		$(function(){
			for(var i=2012;i<=currYear+1;i++){
				$("#year").append('<option value="'+ i +'">'+ i +'</option>');
			}
			if(year != ''){
				setTimeout(function(){ 
				    $('#year').val(year);
				},1);
			}
			var ms = 12;
			var str = '<option value=""></option>';
			for(var i=1;i<=ms;i++){
				str += '<option value="'+i+'">第'+i+'月</option>';
			}
			$('#month').html(str);
			if(month != ''){
				setTimeout(function(){ 
				  $('#month').val(month);
				},1);
			}	
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
		<form method="get" action="${appPath}question_list1.action" name="searchForm">
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_search">
				<tbody>
					<tr>
						<td>
							您当前所处页面：调查表资料维护 >> ${param.year}调查表（一）
						</td>
						<td align="right">
							<span class="STYLE1">市：</span>
			                   <select id="shiId" name="shiId" onchange="selectShi(this.value);">
								<option value="">-----------</option>
							 </select>
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区/县：</span>
						<select id="areaId" name="areaId" onchange="selectArea(this.value);">
									<option value="">----------</option>
								  </select>
			 			<span class="STYLE1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;镇：</span>
			 			<select id="zhenId" name="zhenId" onchange="selectZhen(this.value);">
									<option value="">----------</option>
								 </select>
						<span class="STYLE1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;村：</span>
						<select id="cunId2" name="cunId">
									<option value="">-----------</option>
									</select>
							<input type="hidden" name="type" value="${type}"/>
							<select name="year" id="year" style="width: 60px;">
								<option value=""></option>
							</select>年&nbsp;
							<select name="month" id="month">
								<option value=""></option>
							</select>月&nbsp;
							<input type="button" class="button" value="查询" onclick="query();"> 
						</td>
					</tr>
				</tbody>
			</table>
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_table">
				<tbody>
					<tr align="center">
						<td height="28" width="" class="tables_headercell">
							<input type="checkbox" onclick="checkAll(this);">
						</td>
						<td width="" class="tables_headercell">
							村名
						</td>
						<td width="" class="tables_headercell">
							帮扶单位
						</td>
						<td width="" class="tables_headercell">
							报表类型
						</td>
						<td width="" class="tables_headercell">
							状态
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
								&nbsp;${f.cun.zhen.area.name}${f.cun.zhen.name}${f.cun.name}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 								
								${f.cun.org.orgName}
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp; 
								<c:if test="${f.type==1 }">双到资金</c:if>
								<c:if test="${f.type==2 }">镇建设资金</c:if>
							</td>
							<td height="25" align="center" class="tables_contentcell">
								&nbsp;
								<c:if test="${empty f.status || f.status==0 }">草稿</c:if>
								<c:if test="${f.status==1 }">已提交</c:if>
								<c:if test="${f.status==2 }">请求解锁中</c:if>
							</td>
							<td height="25" align="center" class="tables_contentcell">
								<a href="javascript:void(0);" onclick="winOpen('${appPath}zijin_edit.action?type=${type}&z.id=${f.id}',800,600);">查看</a>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td height="25" align="right" class="tables_contentcell" colspan="3">
							<span style="color:red;font-weight: bold;">${pageBean.total }</span>
						</td>
						<td height="25" align="right" class="tables_contentcell" colspan="4">
							<jsp:include page="../../pager.jsp"></jsp:include>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</body>
</html>