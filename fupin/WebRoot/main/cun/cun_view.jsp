<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.throne212.fupin.domain.Family"%>
<%@page import="com.throne212.fupin.domain.Person"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
		<title>贫困村资料</title>
		<link href="${appPath}main/main_data/manage.css" rel="stylesheet">
		<script src="${appPath}js/jquery.js" language="javascript"></script>
		<script src="${appPath}js/validateForm.js" language="javascript"></script>
		<script src="${appPath}js/sel_style.js" language="javascript"></script>
		<script src="${appPath}js/common.js" language="javascript"></script>
		<script>
			<jsp:include page="../../msg.jsp"></jsp:include>
		</script>
	</head>
	<body>
		<c:set var="c" value="${cun}" scope="page"></c:set>
		<form method="get" onsubmit="return Validator.Validate(this);" action="${appPath}diqu_saveDiqu.action" name="">
			<input type="hidden" value="${cun.id}" name="cun.id" id="">
			<table height="100%" cellspacing="0" cellpadding="0" border="0" width="100%" class="tables_table">
	<tbody><tr>
		<td height="30" align="right" class="tables_leftcell">所属镇</td>
		<td class="tables_contentcell">&nbsp;${c.zhen.name }&nbsp;</td>

		<td height="30" align="right" class="tables_leftcell">村名</td>
		<td class="tables_contentcell">&nbsp;${c.zhen.area.name}${c.zhen.name}${c.name}</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">户数</td>
		<td class="tables_contentcell">&nbsp;${c.familyNum }</td>

		<td height="30" align="right" class="tables_leftcell">人口数</td>
		<td class="tables_contentcell">&nbsp;${c.personNum }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">劳动力总人数</td>
		<td class="tables_contentcell">&nbsp;${c.labor }</td>

		<td height="30" align="right" class="tables_leftcell">外出务工人数</td>
		<td class="tables_contentcell">&nbsp;${c.outLabor }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">贫困户数</td>
		<td class="tables_contentcell">&nbsp;${c.poorFamilyNum }</td>

		<td height="30" align="right" class="tables_leftcell">贫困人口数</td>
		<td class="tables_contentcell">&nbsp;${c.poorPersonNum }</td>
	</tr>
	<!-- 新增字段 -->
	<tr>
		<td height="30" align="right" class="tables_leftcell">有劳动能力的低保户户数</td>
		<td class="tables_contentcell">&nbsp;${c.poorFamilyNum1 }</td>

		<td height="30" align="right" class="tables_leftcell">有劳动能力的低保户人口数</td>
		<td class="tables_contentcell">&nbsp;${c.poorPersonNum1 }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">无劳动能力的低保户户数</td>
		<td class="tables_contentcell">&nbsp;${c.poorFamilyNum2 }</td>

		<td height="30" align="right" class="tables_leftcell">无劳动能力的低保户人口数</td>
		<td class="tables_contentcell">&nbsp;${c.poorPersonNum2 }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">有劳动能力低收入困难家庭户数</td>
		<td class="tables_contentcell">&nbsp;${c.poorFamilyNum3 }</td>

		<td height="30" align="right" class="tables_leftcell">有劳动能力低收入困难家庭人口数</td>
		<td class="tables_contentcell">&nbsp;${c.poorPersonNum3 }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">无劳动能力低收入困难家庭人口数</td>
		<td class="tables_contentcell">&nbsp;${c.poorFamilyNum4 }</td>

		<td height="30" align="right" class="tables_leftcell">无劳动能力低收入困难家庭人口数</td>
		<td class="tables_contentcell">&nbsp;${c.poorPersonNum4 }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">通电自然村数</td>
		<td class="tables_contentcell">&nbsp;${c.dian }</td>

		<td height="30" align="right" class="tables_leftcell">通邮自然村数</td>
		<td class="tables_contentcell">&nbsp;${c.you }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">耕地总面积</td>
		<td class="tables_contentcell">&nbsp;${c.mianji }</td>

		<td height="30" align="right" class="tables_leftcell">泥砖房数</td>
		<td class="tables_contentcell">&nbsp;${c.house }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">危房</td>
		<td class="tables_contentcell">&nbsp;${c.weiHouse }</td>

		<td height="30" align="right" class="tables_leftcell">解决人畜饮水自然村数</td>
		<td class="tables_contentcell">&nbsp;${c.water }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">通广播电视自然村数</td>
		<td class="tables_contentcell">&nbsp;${c.tv }</td>

		<td height="30" align="right" class="tables_leftcell">村集体经济收入</td>
		<td class="tables_contentcell">&nbsp;${c.income }<font>元</font></td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">100人以上自然村是否硬底化</td>
		<td height="30" class="tables_contentcell">${c.ying }</td>

		<td height="30" align="right" class="tables_leftcell">村两委是否有固定办公场所</td>
		<td height="30" class="tables_contentcell">${c.office }</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">贫困村简介</td>
		<td height="30" class="tables_contentcell" colspan="3">
			<textarea readonly="true" rows="5" cols="45" id="textarea" name="pkcjj">${c.remark }</textarea>
		</td>
	</tr>
	<tr>
		<td height="30" align="right" class="tables_leftcell">
			贫困村发展村集体项目计划
		</td>
		<td height="30" class="tables_contentcell" colspan="3">
			<textarea readonly="true" rows="5" cols="45" id="jxjsxm" name="jxjsxm">${c.item }</textarea>
		</td>
	</tr>

	<tr>
		<td align="center" class="tables_contentcell" colspan="4">
			<input type="button" onclick="self.close();" class="button" value="关闭" name="关闭">
		</td>
	</tr>
</tbody></table>
		</form>
	</body>
</html>