<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset==gbk" />
	<title>推我网 - 发布任务</title>	
	<link href="/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="/css/mian.css" rel="stylesheet" type="text/css" />
	<link href="/css/member.css" rel="stylesheet" type="text/css" />
	<link href="/css/publish.css" rel="stylesheet" type="text/css" />
	<script src="/js/jquery.js" type="text/javascript"></script>
	<script src="/js/member.js" type="text/javascript"></script>
	<script type="text/javascript">
	</script>
	<#include "/WEB-INF/template/member/msg.ftl">
</head>
<body>
	<#include "/WEB-INF/template/include/head.ftl">
	<div id="mian">		
		<#include "/WEB-INF/template/include/member_nav.ftl">
		<!-- 内容区域 -->
		<div class="body_content">
			<#include "/WEB-INF/template/include/member_left.ftl">
			<div class="publish_body">
			    <div class="publish_box">
			    	<div class="publish_box_title">
				   		<ul><li>发布任务</li></ul>
				   </div>
				   <div class="publish_box_content">
				   		<form action="/member_publish.do" method="post">
					    <h3>任务所属的一级分类</h3>
					    <p class="class1">
							<#list topTypeList as topType>
							<input type="radio" value="${topType.pinyin}" onclick="showChildTypes(this.value);" name="toptypepinyin" <#if toptypepinyin==topType.pinyin>checked="checked"</#if>>${topType.name}&nbsp;&nbsp;
							</#list>
							<script>
								function showChildTypes(typepinyin){
									$('.class2').hide();
									$('.' + typepinyin).show();
								}
								$(function(){
									var ttpinyin = '${toptypepinyin}';
									var tpinyin = '${typepinyin}';
									if(ttpinyin != ''){
										$('.class1 input[value="'+ttpinyin+'"]').attr('checked',true);
										showChildTypes(ttpinyin);
									}else{
										$('.class1 input:eq(0)').attr('checked',true);
										showChildTypes($('.class1 input:eq(0)').val());
									}
									if(tpinyin != ''){
										$('.class2 input[value="'+tpinyin+'"]').attr('checked',true);
									}
								});
							</script>
					    </p>
					    <h3>请选择推广方式</h3>
					    <#list topTypeList as topType>
					    <p class="class2 ${topType.pinyin} none"><#list typeMap[topType.pinyin] as t>
						<span><input name="typepinyin" onclick="javascript:self.location.href='/member_publish.do?typepinyin=${t.pinyin}';" value="${t.pinyin}" type="radio" <#if typepinyin==t.pinyin>checked="checked"</#if>>${t.name}</span>
						</#list></p>
						</#list>
						<#if typepinyin?exists>
						
						<#include "/WEB-INF/template/member/frag/${typepinyin}.ftl">
						
					    <p>
					   	是否公布:<input type="radio" checked="checked" value="1" name="isGongBu">直接扣款，立即发布
					   	&nbsp;&nbsp;<input type="radio" value="0" name="isGongBu">等我通知
					   	<br/><span class="orange">选择"可直接扣款公布任务"，是在您有足够余额的情况下，由客服人员直接操作任务上线，不需通知雇主。</span>
					    </p>
					    <p>
					   	是否屏蔽搜索引擎:<input type="radio" value="1" name="task.nospider">是
					   	&nbsp;&nbsp;<input type="radio" value="0" checked="checked" name="task.nospider">否
					   	<br/><span class="orange">友情提醒：屏蔽搜索引擎抓取需要额外支付￥10元。若您的内容不涉及政治等敏感因素，可以不屏蔽。</span>
					    </p>
						<p class="ctr">
					   	<input type="checkbox" checked="checked" name="know_xieyi" id="know_xieyi"/><a href="javascript:void(0)" onclick="$('#xieyi').toggle();">我已阅读并接受任务发布的协议与规定</a>
					    </p>
					    <p class="ctr"><input type="button" class="button" value="提交任务" id="submit_task"></p>
					    <script>
					    	$('#submit_task').click(function(){
					    		if($('#task_title').length > 0){
					    			var title = $('#task_title').val();
					    			if(title == ''){
					    				alert('标题不能为空');
					    				return false;
					    			}
					    		}
					    		if($('#taskURL').length > 0){
					    			var url = $('#taskURL').val();
					    			if(url == ''){
					    				alert('任务的地址不能为空');
					    				return false;
					    			}else if(!Validator.Url.test(url)){
					    				alert('任务的地址的格式不正确，请检查');
					    				return false;
					    			}
					    		}
					    		if('${typepinyin}' == 'weibo'){
					    			if(!$('input[name="task.wbType"]:eq(0)').attr('checked') && !$('input[name="task.wbType"]:eq(1)').attr('checked')){
					    				alert('请选择新浪或腾讯的推广平台');
					    				return false;
					    			}
					    		}
					    		var pclass = $('input[name="task.priceClass"]').val();
					    		if(pclass == '3'){
					    			var rate1 = parseInt($('#rate1').val());
					    			var rate2 = parseInt($('#rate2').val());
					    			var rate3 = parseInt($('#rate3').val());
					    			if(rate1 + rate2 + rate3 != 100){
					    				alert('请保证多人中选的奖金分配比例的综合为100%');
					    				return false;
					    			} 
					    		}
					    		if($('#task_money').length > 0){
					    			var m = $('#task_money').val();
					    			if(m == '' || !Validator.Currency.test(m)){
					    				alert('请正确填写任务的奖金金额');
					    				return false;
					    			}
					    		}
					    		if(confirm('确认无误，需要发布了吗？')){
						    		$(this).val('提交中...');
						    		$(this).attr('disabled',true);
						    		$('form:eq(0)').submit();
					    		}
					    	});
					    </script>
					    </#if>
					    </form>
			       </div>
			   </div>
			   <#include "/WEB-INF/template/member/frag/xieyi.ftl">
			</div>
		</div>
		<!-- 内容区域结束 -->
		<#include "/WEB-INF/template/include/foot.ftl">
	</div>
</body>
</html>