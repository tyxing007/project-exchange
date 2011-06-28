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
		$(function(){
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
			if(lock == '1' || lock == '2'){
				$('input[type="text"]').attr("readonly",true);
			}	
			//自动地区数据灰化
			$('.auto_readonly').css('background','#EBEBE4');
		});
		function chooseType(type){
			if('year' == type){
				$('#time').attr('disabled',true);
			}else if('season' == type){
				$('#time').attr('disabled',false);
				var str = '';
				for(var i=1;i<=4;i++){
					str += '<option value="'+i+'">第'+i+'季度</option>';
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
				for(var i=1;i<=12;i++){
					str += '<option value="'+i+'">第'+i+'月</option>';
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
			f.action = '${appPath}report_viewReport1.action';
			f.submit();
		}
		function tmpSaveReport(){
			var f = document.forms[0];
			f.action = '${appPath}report_tmpSaveReport1.action';
			f.submit();
		}
		function saveReport(){
			if(confirm('报表提交后不允许修改，是否提交')){
				var f = document.forms[0];
				f.action = '${appPath}report_saveReport1.action';
				f.submit();
			}
		}
		function unlockReport(){
			if(confirm('确定需要解锁吗？')){
				var f = document.forms[0];
				f.action = '${appPath}report_requstUnlock1.action';
				f.submit();
			}
		}
		function excel(){
			var f = document.forms[0];
				f.action = '${appPath}report_excelReport1.action';
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
		<form method="get" action="${appPath}report_saveReport1.action" name="searchForm">
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_search">
				<tbody>
					<tr>
						<td>
							您当前所处页面：报表维护&gt;&gt;工作统计表
						</td>
						<td align="right">&nbsp;
						</td>
						<td width="5px">&nbsp;</td>
					</tr>
				</tbody>
			</table>
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="tables_table">
				<tbody>
					<tr align="center">
						<td width="" class="tables_headercell">
							年度：
							<select name="r.year" id="year">
								<option value=""></option>
								<option value="2011">2011</option>
								<option value="2012">2012</option>
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
							<c:if test="${empty r.lock || r.lock==0 || r.lock==3}">
							<input type="button" value="保存" class="button" name="保存" onclick="saveReport();">
							<input type="button" value="暂存" class="button" name="暂存" onclick="tmpSaveReport();">
							</c:if>
							<c:if test="${not empty r.lock && r.lock==1}">
							<input type="button" value="请求解锁" class="button" name="请求解锁" onclick="unlockReport();">
							</c:if>
							<input type="button" value="Excel导出" class="button" name="Excel导出" onclick="excel();">
						</td>
					</tr>
					<tr>
						<td class="tables_contentcell" colspan="4" align="center">
							<table id="data_table" cellspacing="0" cellpadding="0" border="0" class="tables_table" style="margin: 5px 10px;width:85%;" align="center">
								<tr>
									<td align="center" class="tables_headercell" colspan="4">帮扶到户</td>
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
									<td class="tables_contentcell" rowspan="12">
									1.贫困户基本情况
									</td>
									<td class="tables_contentcell" colspan="2">
									贫困户户数(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item1" value="${r.item1}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="2">
									贫困户人数(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item2" value="${r.item2}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="4">
									有劳动能力
									</td>
									<td class="tables_contentcell">
									低保对象(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item3" value="${r.item3}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									低保对象(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item4" value="${r.item4}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									低收入困难家庭(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item5" value="${r.item5}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									低收入困难家庭(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item6" value="${r.item6}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="4">
									无劳动能力
									</td>
									<td class="tables_contentcell">
									低保对象(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item7" value="${r.item7}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									低保对象(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item8" value="${r.item8}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									低收入困难家庭(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item9" value="${r.item9}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									低收入困难家庭(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item10" value="${r.item10}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="2">
									危房户(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item11" value="${r.item11}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="2">
									贫困户去世、失踪等情况(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item12" value="${r.item12}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="2">
									预计脱贫
									</td>
									<td class="tables_contentcell" colspan="2">
									预计本年脱贫户数(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item13" value="${r.item13}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="2">
									预计本年脱贫人数(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item14" value="${r.item14}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="15">
									2.贫困户帮扶措施落实情况
									</td>
									<td class="tables_contentcell" rowspan="2">
									到村到户
									</td>
									<td class="tables_contentcell">
									帮扶单位领导(人次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item15" value="${r.item15}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									帮扶单位干部　职工(人次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item16" value="${r.item16}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="2">
									农业生产
									</td>
									<td class="tables_contentcell">
									种植(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item17" value="${r.item17}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									养殖(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item18" value="${r.item18}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="2">
									劳动力转移
									</td>
									<td class="tables_contentcell">
									务工(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item19" value="${r.item19}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									创业(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item20" value="${r.item20}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="2">
									培训
									</td>
									<td class="tables_contentcell">
									农业科技培训(人次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item21" value="${r.item21}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									就业技能培训(人次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item22" value="${r.item22}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="2">
									完成危房改造(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item23" value="${r.item23}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="2">
									保障
									</td>
									<td class="tables_contentcell">
									参加农村合作医疗(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item24" value="${r.item24}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									参加农村养老保险(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item25" value="${r.item25}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="3">
									助学
									</td>
									<td class="tables_contentcell">
									义务教育阶段(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item26" value="${r.item26}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									高中、职高、技校、中专等(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item27" value="${r.item27}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									大专、本科以上(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item28" value="${r.item28}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="2">
									产业发展带动农户(户)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item29" value="${r.item29}"/>
									</td>
								</tr>
								<tr>
									<td align="center" class="tables_headercell" colspan="4">帮扶到村</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="3">
									上年村级集体经济收入(元)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item30" value="${r.item30}" readonly="readonly" class="auto_readonly"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="3">
									预计今年村级集体经济收入(元)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item31" value="${r.item31}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="26">
									3.贫困村帮扶措施落实情况
									</td>
									<td class="tables_contentcell" rowspan="3">
									"两委"班子
									</td>
									<td class="tables_contentcell">
									组织活动(次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item32" value="${r.item32}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									扶贫工作会议(次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item33" value="${r.item33}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									发展新党员(人)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item34" value="${r.item34}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="4">
									文化活动
									</td>
									<td class="tables_contentcell">
									文娱体育(次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item35" value="${r.item35}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									送医送药(次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item36" value="${r.item36}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									科技下乡(次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item37" value="${r.item37}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									其他(次)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item38" value="${r.item38}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="6">
									村集体项目
									</td>
									<td class="tables_contentcell">
									工业开发项目(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item39" value="${r.item39}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									商贸旅游项目(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item40" value="${r.item40}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									农业开发项目(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item41" value="${r.item41}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									手工加工项目(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item42" value="${r.item42}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									招商引资项目(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item43" value="${r.item43}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									企业捐建项目(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item44" value="${r.item44}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="4">
									基础建设
									</td>
									<td class="tables_contentcell">
									硬底化村道(公里)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item45" value="${r.item45}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									安装路灯村道(公里)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item46" value="${r.item46}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									二次改水工程(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item47" value="${r.item47}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									生活污水处理设施(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item48" value="${r.item48}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="3">
									农田建设
									</td>
									<td class="tables_contentcell">
									农田水利设施(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item49" value="${r.item49}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									受益农田(鱼塘)面积(亩)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item50" value="${r.item50}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									标准农田(鱼塘)(亩)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item51" value="${r.item51}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" rowspan="6">
									建设或改造村公共文化卫生设施
									</td>
									<td class="tables_contentcell">
									村委会(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item52" value="${r.item52}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									文化室(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item53" value="${r.item53}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									卫生站(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item54" value="${r.item54}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									环卫设施(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item55" value="${r.item55}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									体育设施(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item56" value="${r.item56}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell">
									其他(个)
									</td>
									<td class="tables_contentcell">
									<input type="text" name="r.item57" value="${r.item57}"/>
									</td>
								</tr>
								<tr>
									<td class="tables_contentcell" colspan="4" style="color:gray;text-align: left;padding-left:30px;">
									说明：
									<br/>
									灰色输入框为系统自动提取数据
									</td>
								</tr>
							</table>							
						</td>
					</tr>
					<c:if test="${empty r.id || r.lock==0}">
					<tr>
						<td align="center" class="tables_contentcell" colspan="4">&nbsp;
						<input type="button" value="保存" class="button" name="保存" onclick="saveReport();">
						</td>
					</tr>
					</c:if>	
				</tbody>
			</table>
		</form>
	</body>
</html>