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
		var year = '${r.year}';
		var type = '${r.type}';
		var time = '${r.time}';
		var lock = '${r.lock}';
		var maxYear = '${maxYear}';
		var maxMonth = '${maxMonth}';
		var maxSeason = '${maxSeason}';
		var now = new Date();
		var currYear = now.getYear()<1970?now.getYear() + 1900:now.getYear();
		maxYear = maxYear==''?currYear:parseInt(maxYear);
		maxMonth = maxMonth==''?12:parseInt(maxMonth);
		maxSeason = maxSeason==''?4:parseInt(maxSeason);
		$(function(){
			for(var i=2011;i<=maxYear;i++){
				$("#year").append('<option value="'+ i +'">'+ i +'</option>');
			}
			if(year != ''){
				setTimeout(function(){ 
				    $('#year').val(year);
				},1);
			}
			if(type != ''){
				setTimeout(function(){ 
				   $('#reportType').val(type);
				},1);
				chooseType(type);
			}		
			//加锁，禁止修改
			if(lock == '1' || lock == '2' || type=='year' || type=='season'){
				$('input[type="text"]').attr("readonly",true);
			}
			//处理万元
			var str = '<select>';
			str += '<option value=""></option>';
			str += '<option value="yuan">元</option>';
			str += '<option value="wan">万元</option>';
			str += '</select>';
			for(var i=1;i<=9;i++){
				$('#item'+i).after('&nbsp;' + str);
				var itemVal = $('#item'+i).val();
				if(itemVal != null && itemVal != ''){
					$('#item'+i).next('select').val('yuan');
				}
			}
		});
		function chooseType(type){
			if(!type){
				type = $('#reportType').val();
			}
			if('year' == type){
				$('#time').attr('disabled',true);
			}else if('season' == type){
				$('#time').attr('disabled',false);
				var ms = maxSeason;
				if(currYear > $('#year').val())
					ms = 4;
				for(var i=1;i<=ms;i++){
					if(($('#year').val()==2011 || year == '2011') && i==1){
						continue;
					}else{
						str += '<option value="'+i+'">第'+i+'季度</option>';
					}
				}
				$('#time').html(str);
				if(time != ''){
					setTimeout(function(){ 
					  $('#time').val(time);
					},1);
				}
			}else if('month' == type){
				$('#time').attr('disabled',false);
				var str = '';
				var ms = maxMonth;
				if(currYear > $('#year').val())
					ms = 12;
				for(var i=1;i<=ms;i++){
					if($('#year').val()==2011 || year == '2011'){
						if(i<=4)
							continue;
						if(i==5){
							str += '<option value="'+i+'">第3-5月</option>';
						}else{
							str += '<option value="'+i+'">第'+i+'月</option>';
						}
					}else{
						str += '<option value="'+i+'">第'+i+'月</option>';
					}
				}
				$('#time').html(str);
				if(time != ''){
					setTimeout(function(){ 
					  $('#time').val(time);
					},1);
				}
			}
		}
		function query(){
			var f = document.forms[0];
			f.action = '${appPath}report_viewReport2.action';
			f.submit();
		}
		//处理元和万元
		function opWan(){
			for(var i=1;i<=9;i++){
				var item = $('#item'+i).val();
				var selWan = $('#item'+i).next('select').val();
				if(item != null && item != ''){
					if(selWan == null || selWan == ''){
						alert('请先选择收入金额单位，元或万元');
						return false;
					}else if(selWan == 'wan'){
						item = parseFloat(item) * 10000;
						$('#item'+i).val(item);
						$('#item'+i).next('select').val('yuan');
					}
				}
			}
			return true;
		}
		function tmpSaveReport(){
			if(!opWan())
				return false;
			var f = document.forms[0];
			f.action = '${appPath}report_tmpSaveReport2.action';
			f.submit();
		}
		function saveReport(){
			if(!opWan())
				return false;
			//数字正则检查
			var pass = true;
			$('input[type="text"]').each(function(){
				if($(this).val()!='' && $(this).val()!=null && !/^\d+(\.\d+)?$/.test($(this).val())){
					pass = false;
					//alert($(this).attr('name'));
				}
			});
			if(!pass){
				alert('所有项目都必须是数字');
				return false;
			}
			//规则检查
			if($('#item2').val() != parseInt($('#item3').val())+parseInt($('#item4').val())){
				alert('注意：已投入帮扶资金= 用于帮扶到户资金 + 用于帮扶到村资金');
				return false;
			}
			if($('#item2').val() != parseInt($('#item5').val())+parseInt($('#item6').val())+parseInt($('#item7').val())+parseInt($('#item8').val())+parseInt($('#item9').val())){
				alert('注意：已投入帮扶资金= 财政专项 + 信贷资金 + 单位自筹 + 社会募捐 + 社会引资');
				return false;
			}
			//两年规划投入资金≥5万
			var item1Val = $('#item1').val();
			if(item1Val != null && item1Val != ''){
				var money = parseFloat(item1Val);
				if(money < 50000){
					alert('两年规划投入资金须>=5万元');
					return false;
				}
			}
			if(confirm('报表提交后不允许修改，是否提交')){
				var f = document.forms[0];
				f.action = '${appPath}report_saveReport2.action';
				f.submit();
			}
		}
		function unlockReport(){
			if(confirm('确定需要解锁吗？')){
				var f = document.forms[0];
				f.action = '${appPath}report_requstUnlock2.action';
				f.submit();
			}
		}
		function excel(){
			var f = document.forms[0];
				f.action = '${appPath}report_excelReport2.action';
				f.submit();
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
#data_table td{
	text-align: center;
}
</style>
	</head>
	<body>
		<form method="get" action="${appPath}report_saveReport2.action" name="searchForm">
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_search">
				<tbody>
					<tr>
						<td>
							您当前所处页面：报表维护&gt;&gt;表三
						</td>
						<td align="right">&nbsp;
						</td>
						<td width="5px">&nbsp;</td>
					</tr>
				</tbody>
			</table>
			<c:if test="${not empty msg }">
			<div style="width:70%; padding: 10px 5px; margin: 5px auto; border: 1px solid red; font-size: 14px; font-weight: 600; text-align: center; background-color: yellow;">
			${msg }
			</div>
			</c:if>
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_table">
				<tbody>
					<tr align="center">
						<td width="" class="tables_headercell">
							年度：
							<select name="r.year" id="year" onchange="chooseType();" style="width: 60px;">
								<option value=""></option>
							</select>
						</td>
						<td width="" class="tables_headercell">
							类型：
							<select name="r.type" id="reportType" onchange="chooseType(this.value);">
								<option value=""></option>
								<option value="year">年度报表</option>
								<option value="season">季度报表</option>
								<option value="month">月度报表</option>
							</select>
						</td>
						<td width="" class="tables_headercell">
							时间：
							<select name="r.time" id="time">
								<option value=""></option>
							</select>
						</td>
						<td width="" class="tables_headercell">
							<input type="button" value="按条件查询" class="button" name="查询" onclick="query();">
							<c:if test="${empty r.type || r.type=='month'}">
								<c:if test="${empty r.lock || r.lock==0 || r.lock==3}">
								</c:if>
								<c:if test="${not empty r.lock && r.lock==1}">
								</c:if>
							</c:if>
							<input type="button" value="Excel导出" class="button" name="Excel导出" onclick="excel();">
						</td>
					</tr>
					<tr>
						<td class="tables_contentcell" colspan="4" align="center">
							<table id="data_table" cellspacing="0" cellpadding="0" border="0" class="tables_table" style="margin: 5px 10px;width:85%;" align="center">
								<tr>
									<td align="center" class="tables_headercell" colspan="4">帮扶资金</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="3">
									帮扶单位
									</td>
									<td class="tables_contentcell" width="50%">
									${userObj.orgName }
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="3">
									贫困村
									</td>
									<td class="tables_contentcell">
									${userObj.cun.name }
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="9">
									4
									</td>
									<td class="tables_contentcell" colspan="1">
									规划
									</td>
									<td class="tables_contentcell" colspan="1">
									两年规划投入资金（元）
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item1" id="item1" value="${r.item1}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="2">
									本月（季）投入帮扶资金（元）
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item2" id="item2" value="${r.item2}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="2">
									本月（季）投入帮扶资金（元）
									</td>
									<td class="tables_contentcell">
									用于帮扶到户资金(元)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item3" id="item3" value="${r.item3}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									用于帮扶到村资金(元)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item4" id="item4" value="${r.item4}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="5">
									本月（季）投入帮扶资金构成
									</td>
									<td class="tables_contentcell">
									财政专项(元)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item5" id="item5" value="${r.item5}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									信贷资金(元)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item6" id="item6" value="${r.item6}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									单位自筹(元)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item7" id="item7" value="${r.item7}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									社会募捐（元）
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item8" id="item8" value="${r.item8}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									社会引资（元）
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item9" id="item9" value="${r.item9}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="4" style="color:gray;text-align: left;padding-left:30px;">
									注意：
									<br/>
									你有项目未填写，如无内容可填写0
									<!--  1.规划投入资金指已列入帮扶规划中的全部资金。
									<br/>
									2.已投入帮扶资金指已使用的帮扶资金。
									<br/>
									3.已投入帮扶资金= 用于帮扶到户资金 + 用于帮扶到村资金
									<br/>
									4.已投入帮扶资金= 财政专项 + 信贷资金 + 单位自筹 + 社会募捐 + 社会引资
									<br/>
									5.社会引资包括内引和外引。内引指国内引资；外引指国外及港澳台引资。引进外资按人民币汇率折算。
									<br/>
									6.慰问、捐赠等形式的物资可折价成资金计入。-->
									</td>
								</tr>								
							</table>							
						</td>
					</tr>
					<c:if test="${empty r.id || r.lock==0}">
					</c:if>	
				</tbody>
			</table>
		</form>
	</body>
</html>