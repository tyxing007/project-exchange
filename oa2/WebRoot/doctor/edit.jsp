<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>新增医生注册</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css" href="${appPath}/css/styles.css">
		<link rel="stylesheet" type="text/css" href="${appPath}/css/jquery.datepick.css" />
		<script type="text/javascript" src="${appPath}/js/jquery.js"></script>
		<script type="text/javascript" src="${appPath}/js/jquery.datepick.js"></script>
		<script type="text/javascript" src="${appPath}/js/jquery.datepick-zh-CN.js"></script>
		<script type="text/javascript">
			var msg = '${requestScope.msg}';
			if(msg != ''){
				alert(msg);
				self.location.href = '${appPath}/doctor.do?method=listDoctor';
			}
			function saveForm(){
				document.forms[0].submit();
			}
			$(function(){
				//初始化列表数据
				$('select').each(function(){		
					if($(this).attr('id')){
						var dropdownType = $(this).attr('id');
						var thisSelect = this;
						$(this).html('<option value=""></option>');
						$.getJSON("${appPath}/ajax", {dropdownType:dropdownType}, function(json){
							if(json && json.length){
								for(var i=0;i<json.length;i++){
									var str = '<option value="'+json[i]['id']+'">'+json[i]['name']+'</option>';
									$(thisSelect).append(str);
								}
							}
						}); 	
					}	
				}); 	
				//初始化日期输入数据
				$('.datetime').datepick({dateFormat: 'yy-mm-dd'}); 
			});
		</script>
	</head>
	<body>
		<form name="messageForm" method="post" action="${appPath}/doctor.do">
			<input type="hidden" name="method" value="addDoctor"/>
			<table width="90%" border="0" cellspacing="1" cellpadding="0" align="center">
			    <tr>
			      <td height="18" align=center>
			        <font class=caption>新增医生注册</font>
			      </td>
			    </tr>
			</table>
			<div style="height: 25px;"></div>
			<table width="90%" border="0" cellspacing="1" cellpadding="0" class=table align="center">
				<tr class="list_td_title">					
					<td align="center" colspan="5">
						&nbsp;
					</td>
				</tr>
				<tr class="list_td_context">
					<td>
						姓&nbsp;&nbsp;&nbsp;&nbsp;名：<input type="text" name="doc.name" value="${doc.name}" id="docName" style="width:200px;"/>
					</td>
					<td>
						性&nbsp;&nbsp;&nbsp;&nbsp;别：
						<select name="doc.gender">
							<option value="">未知</option>
							<option value="true">男</option>
							<option value="false">女</option>
						</select>
					</td>
					<td>
						出生日期：<input type="text" name="doc.birthday" value="${doc.birthday}" id="birthday" style="width:100px;" class="datetime"/>
					</td>
					<td>
						民&nbsp;&nbsp;&nbsp;&nbsp;族：
						<select name="doc.nation.id" id="Nation">
							<option value="">未知</option>
							<option value="1">汉族</option>
							<option value="2">满族</option>
						</select>
					</td>
					<td rowspan="4" style="width: 150px;">
						<!--照&nbsp;&nbsp;&nbsp;&nbsp;片-->
				    	<c:choose>
				    		<c:when test="${empty doc.id || empty doc.image}">
				    		<iframe src="${appPath}/upload.jsp" width="100%" height="100%" frameborder="0"></iframe>
				    		</c:when>
				    		<c:otherwise>
				    		<img src="${appPath}/photo/${doc.image}" style="display: block;margin:0 auto; height: 135px; width: 135px;"/>
				    		</c:otherwise>
				    	</c:choose>
					</td>
				</tr>
				<tr class="list_td_context">
					<td>
						身份证号：<input type="text" name="doc.idNo" value="${doc.idNo}" id="idNo" style="width:200px;"/>
					</td>
					<td colspan="2">
						家庭住址：<input type="text" name="doc.address" value="${doc.address}" id="address" style="width:300px;"/>
					</td>
					<td>
						邮&nbsp;&nbsp;&nbsp;&nbsp;编：<input type="text" name="doc.post" value="${doc.post}" id="post" style="width:200px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td>
						学&nbsp;&nbsp;&nbsp;&nbsp;历：
						<select name="doc.xueli.id" id="XueLi">
							<option value="">未知</option>
							<option value="1">本科</option>
							<option value="2">小学</option>
						</select>
					</td>
					<td colspan="2">
						所在院系：<input type="text" name="doc.xueyuan" value="${doc.xueyuan}" id="xueyuan" style="width:300px;"/>
					</td>
					<td>
						专&nbsp;&nbsp;&nbsp;&nbsp;业：<input type="text" name="doc.major" value="${doc.major}" id="major" style="width:200px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td>
						任职资格：
						<select name="doc.zige.id" id="Zige">
							<option value="">未知</option>
							<option value="1">高级</option>
							<option value="2">中级</option>
						</select>
					</td>
					<td colspan="2">
						注册编号：<input type="text" name="doc.zigeNo" value="${doc.name}" id="zigeNo" style="width:300px;"/>
					</td>
					<td>
						级&nbsp;&nbsp;&nbsp;&nbsp;别：
						<select name="doc.grade.id" id="Grade">
							<option value="">未知</option>
							<option value="1">高级</option>
							<option value="2">中级</option>
						</select>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="3">
						机构名称：<input type="text" name="doc.org" value="${doc.org}" id="org" style="width:400px;"/>
					</td>
					<td colspan="2">
						机构编号：<input type="text" name="doc.orgNo" value="${doc.orgNo}" id="orgNo" style="width:200px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="3">
						机构地址：<input type="text" name="doc.orgAddress" value="${doc.orgAddress}" id="orgAddress" style="width:400px;"/>
					</td>
					<td colspan="2">
						邮政编码：<input type="text" name="doc.orgPost" value="${doc.orgPost}" id="orgPost" style="width:200px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="1">
						行政区划：
						<select name="doc.areaZhen.id" id="Zhen">
							<option value="">未知</option>
							<option value="1">幸福</option>
						</select>镇&nbsp;
						<select name="doc.areaCun.id" id="Cun">
							<option value="">未知</option>
							<option value="1">幸福</option>
						</select>村
					</td>
					<td colspan="2">
						职业助师资格时间：<input type="text" name="doc.zhushiDate" value="${doc.zhushiDate}" id="zhushiDate" style="width:200px;" class="datetime"/>
					</td>
					<td colspan="2">
						职业医师资格时间：<input type="text" name="doc.yishiDate" value="${doc.yishiDate}" id="yishiDate" style="width:200px;" class="datetime"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="2">
						职业类别：
						<input type="text" name="doc.zhiyeGrade" value="${doc.zhiyeGrade}" id="zhiyeGrade" style="width:200px;"/>
					</td>
					<td colspan="3">
						职业科目：<input type="text" name="doc.zhiyeKemu" value="${doc.zhiyeKemu}" id="zhiyeKemu" style="width:400px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="5">
						处罚处分：
						<input type="text" name="doc.chufa" value="${doc.chufa}" id="chufa" style="width:600px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="5">
						业务考核：
						<input type="text" name="doc.yewuKaohe" value="${doc.yewuKaohe}" id="yewuKaohe" style="width:600px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="5">
						其它问题：
						<input type="text" name="doc.other" value="${doc.other}" id="other" style="width:600px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="5">
						工作经历：
						<input type="text" name="doc.workExpr" value="${doc.workExpr}" id="workExpr" style="width:600px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="5">
						审批意见：
						<input type="text" name="doc.shenpiComment" value="${doc.shenpiComment}" id="shenpiComment" style="width:600px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="1">
						身体状况：
						<select name="doc.bodyGrade.id"  id="BodyGrade">
							<option value="">未知</option>
							<option value="1">好</option>
						</select>
					</td>
					<td colspan="1">
						申请时间：
						<input type="text" name="doc.applyDate" value="${doc.applyDate}" id="applyDate" style="width:100px;" class="datetime"/>
					</td>
					<td colspan="1">
						批准时间：
						<input type="text" name="doc.okDate" value="${doc.okDate}" id="okDate" style="width:100px;" class="datetime"/>
					</td>
					<td colspan="2">
						批准机构：
						<input type="text" name="doc.shenpiOrg" value="${doc.shenpiOrg}" id="shenpiOrg" style="width:300px;"/>
					</td>
				</tr>
				<tr class="list_td_context">
					<td colspan="5" style="vertical-align: top;">
						备&nbsp;&nbsp;&nbsp;&nbsp;注：
						<textarea style="width: 600px;height: 50px;" name="doc.comments" id="comments">${doc.comments}</textarea>
					</td>
				</tr>
			</table>
			<p>
			<table width="90%" border="0" cellspacing="1" cellpadding="0" class=table align="center">
				<tr>
					<td align="center">
						<input type="button" name="" value="保 存" onclick="saveForm();">
						<input type="button" name="" value="放 弃" onclick="">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
