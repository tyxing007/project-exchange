					    <h3>��ѡ�����ļ۸�</h3>
					    <p>
							<input type="radio" value="0" name="danjia">�Զ���&nbsp;&nbsp;
							<input type="radio" value="50" name="danjia">100Ԫ��ƪ&nbsp;&nbsp;
							<input type="radio" value="100" name="danjia">100Ԫһƪ&nbsp;&nbsp;
							<input type="radio" value="200" name="danjia">200Ԫһƪ&nbsp;&nbsp;
							<input type="radio" value="300" name="danjia">300Ԫһƪ&nbsp;&nbsp;
					    </p>
					    <#include "/WEB-INF/template/member/frag/common/title.ftl">
					    <#include "/WEB-INF/template/member/frag/common/price_class_2.ftl">
					    <h3>����Ҫ��</h3>
					    <p>
					   	<textarea size="60" id="task_content" class="txtArea4"type="text" name="task.content">${(task.content)?default('')}</textarea>
					   	<br/><span class="orange">�������Ҫ�󾡿��ܵ�д����� �Ա������Ǹ���Ч���Ϊ����������500�����Ļ�1000��Ӣ�����ڣ�</span>
					    </p>
					    <#include "/WEB-INF/template/member/frag/common/attachment.ftl">
					    <#include "/WEB-INF/template/member/frag/common/contact.ftl">
					    <div class="money_info">
					   	<h3>�������Ͷ���Ǯ�أ�</h3>
					   	<p class="ft12">������Խ�ߣ��������ֽ�Խ�࣬�ƹ�������ɵ�����Ҳ��Խ�á�</p>
					   	<p><input type="text" size="20" class="text1" name="task.money" id="task_money" value="${(task.money)?default('')}">Ԫ</p>
					   	<h3>ѡ���б�ģʽ</h3>
					   	<p>
					   		<input type="radio" name="task_priceclass" value="1" onclick="selectType(0)">
						    <label for="radio1">�����б�</label>��
						    <input type="radio" name="task_priceclass" value="2" onclick="selectType(1)">
						    <label for="radio2">�����б�</label>
					   	</p>
					   	<script>
					   	function selectType(t){
					   		if(t==0){
					   			$('#price_class').hide();
					   			$('input[name="task.priceClass"]').val(2);
					   			$('input[name="task_priceclass"]:eq(0)').attr('checked',true);
					   		}else if(t==1){
					   			$('#price_class').show();
					   			$('input[name="task.priceClass"]').val(3);
					   			$('input[name="task_priceclass"]:eq(1)').attr('checked',true);
					   		}
					   	}
					   	var rate1 = '${(task.rate1)?default("")}';
					   	var rate2 = '${(task.rate2)?default("")}';
					   	var rate3 = '${(task.rate3)?default("")}';
					   	$(function(){
					   		if(rate1 != '')
					   			setTimeout(function(){$('#rate1').val(rate1)},1);
					   		if(rate2 != '')
					   			setTimeout(function(){$('#rate2').val(rate2)},1);
					   		if(rate3 != '')
					   			setTimeout(function(){$('#rate3').val(rate3)},1);
					   		if($('#people1').val() == '')
					   			$('#people1').val(1);
					   		if($('#people2').val() == '')
					   			$('#people2').val(1);
					   		if($('#people3').val() == '')
					   			$('#people3').val(1);
					   		if(!$('input[name="task_priceclass"]:eq(0)').attr('checked') 
					   			&& !$('input[name="task_priceclass"]:eq(1)').attr('checked')){
					   			$('input[name="task_priceclass"]:eq(0)').attr('checked',true);
					   			$('input[name="task.priceClass"]').val(2);
					   		}else if($('input[name="task_priceclass"]:eq(1)').attr('checked')){
					   			selectType(1);
					   		}
					   	});
					   	</script>
					   	<p id="price_class" class="none">
					   		(����ĳ�Ƚ�,������0��)<br/>һ�Ƚ�
							  <input name="task.people1" id="people1" type="text" class="text2" size="3" value="${(task.people1)?default('')}"/>
						    �ˣ�ƽ�ֽ����
						    <select name="task.rate1" id="rate1" style="font-weight:bold; color:#666;">
						      <option value="100">100%</option>
						      <option value="90">90%</option>
						      <option value="80">80%</option>
						      <option value="70" selected="selected">70%</option>
						      <option value="60">60%</option>
						      <option value="50">50%</option>
						      <option value="40">40%</option>
						      <option value="30">30%</option>
						      <option value="20">20%</option>
						      <option value="10">10%</option>
						      <option value="0">0%</option>
						      </select>
							  <span id="selFirstTxt"></span><br/>
							  ���Ƚ�
							  <input name="task.people2" id="people2" type="text" class="text2" size="3" value="${(task.people2)?default('')}"/>
						    �ˣ�ƽ�ֽ����
						    <select name="task.rate2" id="rate2" style="font-weight:bold; color:#666;">
						      <option value="100">100%</option>
						      <option value="90">90%</option>
						      <option value="80">80%</option>
						      <option value="70">70%</option>
						      <option value="60">60%</option>
						      <option value="50">50%</option>
						      <option value="40">40%</option>
						      <option value="30">30%</option>
						      <option value="20" selected="selected">20%</option>
						      <option value="10">10%</option>
						      <option value="0">0%</option>
						      </select>
							  <span id="selSecondTxt"></span><br/>
							  ���Ƚ�
							  <input name="task.people3" id="people3" type="text" class="text2" size="3" value="${(task.people3)?default('')}"/>
						    �ˣ�ƽ�ֽ����
						    <select name="task.rate3" id="rate3" style="font-weight:bold; color:#666;">
						      <option value="100">100%</option>
						      <option value="90">90%</option>
						      <option value="80">80%</option>
						      <option value="70">70%</option>
						      <option value="60">60%</option>
						      <option value="50">50%</option>
						      <option value="40">40%</option>
						      <option value="30">30%</option>
						      <option value="20">20%</option>
						      <option value="10" selected="selected">10%</option>
						      <option value="0">0%</option>
						      </select>
							  <span id="selThirdTxt"></span>							  
					   	</p>
					    </div>
					    <#include "/WEB-INF/template/member/frag/common/days7.ftl">
					    
<script>
var preInfoArr = [];
preInfoArr[preInfoArr.length] = ['','','',''];
preInfoArr[preInfoArr.length] = ['1��Ҫ��ԭ��д�������ݺͱ���ԭ�������ܳ�Ϯ��\n2�����˽��ҵĲ�Ʒ����վ��www.xxx.com\n3��������⣬Ҫ���ջ�������������������\n4������300-500�֣��������Լ������ں��ḻ�������Ͽڣ����ڼ���ʹ�����\n5�������ʺ�����̳�����͡�΢�����Ż���վ�ȷ�����',''];
preInfoArr[preInfoArr.length] = ['1��Ҫ��ԭ��д�������ݺͱ���ԭ�������ܳ�Ϯ��\n2�����˽��ҵĲ�Ʒ����վ��www.xxx.com\n3��������ģ�Ҫ����ɫ����������ģ�����Ҫ��ӱ�������㹻��������\n4����������Ҫ���ֲ�Ʒ��Ϣ���������ԵĹ��ζ������Ҫ�����������ɶ��ԣ������Թ��¡����飬רҵ�Եȱ����ַ�����������ᡢ�ĵ�����д��\n5������500�����ϣ��������Լ������ں��ḻ�������Ͽڣ����ڼ���ʹ�����\n6�������ʺ�����̳�����͡�΢�����Ż���վ�ȷ�����',''];
preInfoArr[preInfoArr.length] = ['1��Ҫ��ԭ��д�������ݺͱ���ԭ�������ܳ�Ϯ��\n2�����˽��ҵĲ�Ʒ����վ��www.xxx.com\n3����������кϵ�ǰ��ʱ���ȵ㡢���������¼������������ԵĹ���������Ա������ĵ��ƹ��봫����\n4����������Ҫ�����Ʒ��Ϣ��ͼ�Ĳ�ï������Ҫ�����������ɶ��ԣ��Լ������顢���ű�����רҵ�Ա����ȱ����ַ�д����\n5������500-800�֣�Χ���ҵĲ�Ʒ����վչ��д�����ı�ͨ���׶�������ӡ����̣����������߿����ܲ���ʹ�õ�������\n6�������ʺ��������Ż���վ����̳�����͡�΢���ȷ�����'];
preInfoArr[preInfoArr.length] = ['1��Ҫ��ԭ��д�������ݺͱ���ԭ�������ܳ�Ϯ��\n2�����˽��ҵĲ�Ʒ����վ��www.xxx.com\n3������ӱ��������ı��⣬����һ�����е���鿴�ĳ嶯��\n4��������500-800��Ϊ�ѣ����ĵ�����ǿ�����������߿����ܲ��������������\n5����������кϵ�ǰ��ʱ���ȵ㡢���������¼���ͼ�Ĳ�ï���ɶ���ǿ��Ҫ�Ե���Ȼ������Ȥζ���޹��ζ�����������ĵ��ƹ��봫����\n6����������Ҫ�����ҵĲ�Ʒ��Ϣ���Լ������顢���ű�����רҵ�Ա����ȱ����ַ�д��������Ҫ���������͹��������������Ѳ������ۡ�\n7�������ʺ��������Ż���վ����̳�����͡�΢���ȷ�����'];
function selectDanjia(dom, index){
	if($(dom).attr('checked')){
		$('#task_content').val(preInfoArr[index][0]);
		danjia = dom.value;
		try{danjia = parseInt(danjia);}catch(e){}
		if(danjia>=100){
			$('#task_money').val(danjia);
			selectType(0);
		}else if(danjia==50){
			$('#task_money').val(danjia*2);
			selectType(1);
			setTimeout(function(){$('#rate1').val('100');},1);
			setTimeout(function(){$('#rate2').val('0');},1);
			setTimeout(function(){$('#rate3').val('0');},1);
			$('#people1').val(2);
			$('#people2').val(0);
			$('#people3').val(0);
		}else{
			$('#task_money').val('');
			selectType(0);
		}
	}
}
var danjia = '${(req.getParameter("danjia"))?default("")}';
$(function(){
	//����ѡ��������
	$('input[name="danjia"]').each(function(index){
		$(this).click(function(){
			selectDanjia(this,index);
		});
		if($(this).val() == danjia)
			selectDanjia(this,index);
	});
	//���ۺ͸�ѵļ���
	
});
</script>