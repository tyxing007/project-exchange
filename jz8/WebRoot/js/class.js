function UpdateCheckCode(Img)
{
	var timenow = new Date().getTime();
	url="/code/yz_image.jsp";
	url = url + "?time=" + timenow;
	Img.src=url;
}
//��֤�����ַ�
function strangecode(code)
{   var strangCode = "<>";
    var temp;
    for (var i = 0; i<code.length; i++ )
    {
        temp = code.substring(i,i+1);
        if (strangCode.indexOf(temp) !=-1)
        {
            return (false);
        }
    }
}


//�ַ�����
function  getLength(stringIn)
{
        var   strLength=0;
        strLength=stringIn.length;
//        for(var   i=0;i<stringIn.length;i++)
//        {
//                if(stringIn.charCodeAt(i)>255)
//                {
//                        strLength+=2;
//                }
//                else
//                {
//                        strLength+=1;
//                }
//
//        }
        return   strLength;
}


function String.prototype.Trim() {return this.replace(/(^\s*)|(\s*$)/g,"");}
function String.prototype.Ltrim(){return this.replace(/(^\s*)/g, "");}
function String.prototype.Rtrim(){return this.replace(/(\s*$)/g, "");}

function Trim_char(obj)
{
  var str=obj.value.Trim();
  obj.value=str;
  }
function CheckForm(form){
   //��֤��Ϣ����

   if(form.kind[0].checked==false && form.kind[1].checked==false){
   	 alert("\n��ѡ����Ϣ���ͣ�");
        form.kind[0].focus();
        return (false);
   	}
      var salary=form.salary.value.Trim();
     form.salary.value=salary;
     if(form.salary.value==""){
   	 alert("\n����дн��Ҫ��");
        form.slary.focus();
        return (false);
   	}

    if (form.rtype1.value=="")
    {
        alert("\n��Ϣ���಻��Ϊ�գ�");
        form.rtype1.focus();
        return (false);
    }
     if (form.rtype2.value=="")
    {
        alert("\n��ѡ��������࣡");
        form.rtype2.focus();
        return (false);
    }
	 //��֤���ڵص�
    if (form.province.value == "")
    {
        alert("��Ϣ����ʡ�в���Ϊ�գ�");
        form.province.focus();
        return (false);
    }

    if (form.city.value == "")
    {
        alert("��Ϣ���ڵ�������Ϊ�գ�");
        form.city.focus();
        return (false);
    }

    //��֤����
     var title=form.title.value.Trim();
     form.title.value=title;
    if (form.title.value=="")
    {
        alert("���ⲻ��Ϊ�գ�");
        form.title.value="";
        form.title.focus();
        return (false);
    }
       if (strangecode(form.title.value)==false)
    {
        alert("\n���ⲻ�ܺ��������ַ� < >");
        form.title.focus();
        return (false);
    }

    //��֤��ϸ��Ϣ
     var content=form.content.value.Trim();
     form.content.value=content;
    if (form.content.value=="")
    {
        alert("��ϸ��Ϣ����Ϊ�գ�");
        form.content.value="";
        form.content.focus();
        return (false);
    }
    if (strangecode(form.content.value)==false)
    {
        alert("\n��ϸ��Ϣ���ܺ��������ַ� < >");
        form.content.focus();
        return (false);
    }
    if (getLength(form.content.value) < 15  || getLength(form.content.value) > 2000)
    {
        alert("��ϸ��ϢӦ����ʮ����ַ�,С�ڵ���2ǧ�ַ���");
        form.content.focus();
        return (false);
    }

     var user_name=form.user_name.value.Trim();
     form.user_name.value=user_name;
    if(getLength(form.user_name.value)<1){
    alert("��ϵ�˲���Ϊ�գ�����д��");
    form.user_name.focus();
    return(false);
    }
    if(getLength(form.user_name.value)>20){
    alert("��ϵ���ַ������ܳ���20�֣�");
    form.user_name.focus();
    return(false);
    }

    var contact=form.contact.value.Trim();
     form.contact.value=contact;
   if(getLength(form.contact.value)<1){
    alert("��ϵ��ʽ����Ϊ�գ�����д��");
    form.contact.focus();
    return(false);
    }

    if(getLength(form.contact.value)>200){
       alert("��ϵ��ʽ�ַ��������ܴ���200��")
       form.contact.focus();
       return(false);
     }
     document.all.submit2.value="�ύ��...";
     document.all.submit2.disabled = true;
    return true;
}





function clear(o){
l=o.length;
for (i = 0; i< l; i++){
	o.options[1]=null;
}
}


function sdistrict(oj,v){
     // alert(v);
	var m=-1;
	for (i=1;i<=34;i++){
		if (fclass[i]==v){
			m=i;
			}
	}

	clear(oj);
	if (m!=-1){
                  for (i=1;i<sclass[m].length;i++){
		 	oj.add(new Option(sclass[m][i],(v+tclass[m][i])));
                        // oj.add(new Option(sclass[m][i],sclass[m][i]));
		}
	}
}


//��������
var citys;
var province;
var name1;
province=new Array(36);
citys=new Array(36);
name1=new Array(36);


citys[1]=new Array(1);
citys[2]=new Array(1);
citys[3]=new Array(1);
citys[4]=new Array(1);
citys[5]=new Array(21);
citys[6]=new Array(9);
citys[7]=new Array(11);
citys[8]=new Array(13);
citys[9]=new Array(17);
citys[10]=new Array(14);
citys[11]=new Array(11);
citys[12]=new Array(21);
citys[13]=new Array(10);
citys[14]=new Array(17);
citys[15]=new Array(18);
citys[16]=new Array(11);
citys[17]=new Array(11);
citys[18]=new Array(12);
citys[19]=new Array(9);
citys[20]=new Array(13);
citys[21]=new Array(17);
citys[22]=new Array(14);
citys[23]=new Array(14);
citys[24]=new Array(19);
citys[25]=new Array(16);
citys[26]=new Array(9);
citys[27]=new Array(7);
citys[28]=new Array(14);
citys[29]=new Array(4);
citys[30]=new Array(8);
citys[31]=new Array(13);
citys[32]=new Array(1);
citys[33]=new Array(1);
citys[34]=new Array(1);
citys[35]=new Array(1);

name1[1]=new Array(1);
name1[2]=new Array(1);
name1[3]=new Array(1);
name1[4]=new Array(1);
name1[5]=new Array(21);
name1[6]=new Array(9);
name1[7]=new Array(11);
name1[8]=new Array(13);
name1[9]=new Array(17);
name1[10]=new Array(14);
name1[11]=new Array(11);
name1[12]=new Array(21);
name1[13]=new Array(10);
name1[14]=new Array(17);
name1[15]=new Array(18);
name1[16]=new Array(11);
name1[17]=new Array(11);
name1[18]=new Array(12);
name1[19]=new Array(9);
name1[20]=new Array(13);
name1[21]=new Array(17);
name1[22]=new Array(14);
name1[23]=new Array(14);
name1[24]=new Array(19);
name1[25]=new Array(16);
name1[26]=new Array(9);
name1[27]=new Array(7);
name1[28]=new Array(14);
name1[29]=new Array(4);
name1[30]=new Array(8);
name1[31]=new Array(13);
name1[32]=new Array(1);
name1[33]=new Array(1);
name1[34]=new Array(1);
name1[35]=new Array(1);

province[1]="01";
province[2]="02";
province[3]="03";
province[4]="04";
province[5]="05";
province[6]="06";
province[7]="07";
province[8]="08";
province[9]="09";
province[10]="10";
province[11]="11";
province[12]="12";
province[13]="13";
province[14]="14";
province[15]="15";
province[16]="16";
province[17]="17";
province[18]="18";
province[19]="19";
province[20]="20";
province[21]="21";
province[22]="22";
province[23]="23";
province[24]="24";
province[25]="25";
province[26]="26";
province[27]="27";
province[28]="28";
province[29]="29";
province[30]="30";
province[31]="31";
province[32]="32";
province[33]="33";
province[34]="34";
province[35]="35";


citys[1][1]="0100";
citys[2][1]="0200";
citys[3][1]="0300";
citys[4][1]="0400";
citys[5][1]="0501";
citys[5][2]="0502";
citys[5][3]="0503";
citys[5][4]="0504";
citys[5][5]="0505";
citys[5][6]="0506";
citys[5][7]="0507";
citys[5][8]="0508";
citys[5][9]="0509";
citys[5][10]="0510";
citys[5][11]="0511";
citys[5][12]="0512";
citys[5][13]="0513";
citys[5][14]="0514";
citys[5][15]="0515";
citys[5][16]="0516";
citys[5][17]="0517";
citys[5][18]="0518";
citys[5][19]="0519";
citys[5][20]="0520";
citys[5][21]="0521";
citys[6][1]="0601";
citys[6][2]="0602";
citys[6][3]="0603";
citys[6][4]="0604";
citys[6][5]="0605";
citys[6][6]="0606";
citys[6][7]="0607";
citys[6][8]="0608";
citys[6][9]="0609";
citys[7][1]="0701";
citys[7][2]="0702";
citys[7][3]="0703";
citys[7][4]="0704";
citys[7][5]="0705";
citys[7][6]="0706";
citys[7][7]="0707";
citys[7][8]="0708";
citys[7][9]="0709";
citys[7][10]="0710";
citys[7][11]="0711";
citys[8][1]="0801";
citys[8][2]="0802";
citys[8][3]="0803";
citys[8][4]="0804";
citys[8][5]="0805";
citys[8][6]="0806";
citys[8][7]="0807";
citys[8][8]="0808";
citys[8][9]="0809";
citys[8][10]="0810";
citys[8][11]="0811";
citys[8][12]="0812";
citys[8][13]="0813";
citys[9][1]="0901";
citys[9][2]="0902";
citys[9][3]="0903";
citys[9][4]="0904";
citys[9][5]="0905";
citys[9][6]="0906";
citys[9][7]="0907";
citys[9][8]="0908";
citys[9][9]="0909";
citys[9][10]="0910";
citys[9][11]="0911";
citys[9][12]="0912";
citys[9][13]="0913";
citys[9][14]="0914";
citys[9][15]="0915";
citys[9][16]="0916";
citys[9][17]="0917";
citys[10][1]="1001";
citys[10][2]="1002";
citys[10][3]="1003";
citys[10][4]="1004";
citys[10][5]="1005";
citys[10][6]="1006";
citys[10][7]="1007";
citys[10][8]="1008";
citys[10][9]="1009";
citys[10][10]="1010";
citys[10][11]="1011";
citys[10][12]="1012";
citys[10][13]="1013";
citys[10][14]="1014";
citys[11][1]="1101";
citys[11][2]="1102";
citys[11][3]="1103";
citys[11][4]="1104";
citys[11][5]="1105";
citys[11][6]="1106";
citys[11][7]="1107";
citys[11][8]="1108";
citys[11][9]="1109";
citys[11][10]="1110";
citys[11][11]="1111";
citys[12][1]="1201";
citys[12][2]="1202";
citys[12][3]="1203";
citys[12][4]="1204";
citys[12][5]="1205";
citys[12][6]="1206";
citys[12][7]="1207";
citys[12][8]="1208";
citys[12][9]="1209";
citys[12][10]="1210";
citys[12][11]="1211";
citys[12][12]="1212";
citys[12][13]="1213";
citys[12][14]="1214";
citys[12][15]="1215";
citys[12][16]="1216";
citys[12][17]="1217";
citys[12][18]="1218";
citys[12][19]="1219";
citys[12][20]="1220";
citys[12][21]="1221";
citys[13][1]="1301";
citys[13][2]="1302";
citys[13][3]="1303";
citys[13][4]="1304";
citys[13][5]="1305";
citys[13][6]="1306";
citys[13][7]="1307";
citys[13][8]="1308";
citys[13][9]="1309";
citys[13][10]="1310";
citys[14][1]="1401";
citys[14][2]="1402";
citys[14][3]="1403";
citys[14][4]="1404";
citys[14][5]="1405";
citys[14][6]="1406";
citys[14][7]="1407";
citys[14][8]="1408";
citys[14][9]="1409";
citys[14][10]="1410";
citys[14][11]="1411";
citys[14][12]="1412";
citys[14][13]="1413";
citys[14][14]="1414";
citys[14][15]="1415";
citys[14][16]="1416";
citys[14][17]="1417";
citys[15][1]="1501";
citys[15][2]="1502";
citys[15][3]="1503";
citys[15][4]="1504";
citys[15][5]="1505";
citys[15][6]="1506";
citys[15][7]="1507";
citys[15][8]="1508";
citys[15][9]="1509";
citys[15][10]="1510";
citys[15][11]="1511";
citys[15][12]="1512";
citys[15][13]="1513";
citys[15][14]="1514";
citys[15][15]="1515";
citys[15][16]="1516";
citys[15][17]="1517";
citys[15][18]="1518";
citys[16][1]="1601";
citys[16][2]="1602";
citys[16][3]="1603";
citys[16][4]="1604";
citys[16][5]="1605";
citys[16][6]="1606";
citys[16][7]="1607";
citys[16][8]="1608";
citys[16][9]="1609";
citys[16][10]="1610";
citys[16][11]="1611";
citys[17][1]="1701";
citys[17][2]="1702";
citys[17][3]="1703";
citys[17][4]="1704";
citys[17][5]="1705";
citys[17][6]="1706";
citys[17][7]="1707";
citys[17][8]="1708";
citys[17][9]="1709";
citys[17][10]="1710";
citys[17][11]="1711";
citys[18][1]="1801";
citys[18][2]="1802";
citys[18][3]="1803";
citys[18][4]="1804";
citys[18][5]="1805";
citys[18][6]="1806";
citys[18][7]="1807";
citys[18][8]="1808";
citys[18][9]="1809";
citys[18][10]="1810";
citys[18][11]="1811";
citys[18][12]="1812";
citys[19][1]="1901";
citys[19][2]="1902";
citys[19][3]="1903";
citys[19][4]="1904";
citys[19][5]="1905";
citys[19][6]="1906";
citys[19][7]="1907";
citys[19][8]="1908";
citys[19][9]="1909";
citys[20][1]="2001";
citys[20][2]="2002";
citys[20][3]="2003";
citys[20][4]="2004";
citys[20][5]="2005";
citys[20][6]="2006";
citys[20][7]="2007";
citys[20][8]="2008";
citys[20][9]="2009";
citys[20][10]="2010";
citys[20][11]="2011";
citys[20][12]="2012";
citys[20][13]="2013";
citys[21][1]="2101";
citys[21][2]="2102";
citys[21][3]="2103";
citys[21][4]="2104";
citys[21][5]="2105";
citys[21][6]="2106";
citys[21][7]="2107";
citys[21][8]="2108";
citys[21][9]="2109";
citys[21][10]="2110";
citys[21][11]="2111";
citys[21][12]="2112";
citys[21][13]="2113";
citys[21][14]="2114";
citys[21][15]="2115";
citys[21][16]="2116";
citys[21][17]="2117";
citys[22][1]="2201";
citys[22][2]="2202";
citys[22][3]="2203";
citys[22][4]="2204";
citys[22][5]="2205";
citys[22][6]="2206";
citys[22][7]="2207";
citys[22][8]="2208";
citys[22][9]="2209";
citys[22][10]="2210";
citys[22][11]="2211";
citys[22][12]="2212";
citys[22][13]="2213";
citys[22][14]="2214";
citys[23][1]="2301";
citys[23][2]="2302";
citys[23][3]="2303";
citys[23][4]="2304";
citys[23][5]="2305";
citys[23][6]="2306";
citys[23][7]="2307";
citys[23][8]="2308";
citys[23][9]="2309";
citys[23][10]="2310";
citys[23][11]="2311";
citys[23][12]="2312";
citys[23][13]="2313";
citys[23][14]="2314";
citys[24][1]="2401";
citys[24][2]="2402";
citys[24][3]="2403";
citys[24][4]="2404";
citys[24][5]="2405";
citys[24][6]="2406";
citys[24][7]="2407";
citys[24][8]="2408";
citys[24][9]="2409";
citys[24][10]="2410";
citys[24][11]="2411";
citys[24][12]="2412";
citys[24][13]="2413";
citys[24][14]="2414";
citys[24][15]="2415";
citys[24][16]="2416";
citys[24][17]="2417";
citys[24][18]="2418";
citys[24][19]="2419";
citys[25][1]="2501";
citys[25][2]="2502";
citys[25][3]="2503";
citys[25][4]="2504";
citys[25][5]="2505";
citys[25][6]="2506";
citys[25][7]="2507";
citys[25][8]="2508";
citys[25][9]="2509";
citys[25][10]="2510";
citys[25][11]="2511";
citys[25][12]="2512";
citys[25][13]="2513";
citys[25][14]="2514";
citys[25][15]="2515";
citys[25][16]="2516";
citys[26][1]="2601";
citys[26][2]="2602";
citys[26][3]="2603";
citys[26][4]="2604";
citys[26][5]="2605";
citys[26][6]="2606";
citys[26][7]="2607";
citys[26][8]="2608";
citys[26][9]="2609";
citys[27][1]="2701";
citys[27][2]="2702";
citys[27][3]="2703";
citys[27][4]="2704";
citys[27][5]="2705";
citys[27][6]="2706";
citys[27][7]="2707";
citys[28][1]="2801";
citys[28][2]="2802";
citys[28][3]="2803";
citys[28][4]="2804";
citys[28][5]="2805";
citys[28][6]="2806";
citys[28][7]="2807";
citys[28][8]="2808";
citys[28][9]="2809";
citys[28][10]="2810";
citys[28][11]="2811";
citys[28][12]="2812";
citys[28][13]="2813";
citys[28][14]="2814";
citys[29][1]="2901";
citys[29][2]="2902";
citys[29][3]="2903";
citys[29][4]="2904";
citys[30][1]="3001";
citys[30][2]="3002";
citys[30][3]="3003";
citys[30][4]="3004";
citys[30][5]="3005";
citys[30][6]="3006";
citys[30][7]="3007";
citys[30][8]="3008";
citys[31][1]="3101";
citys[31][2]="3102";
citys[31][3]="3103";
citys[31][4]="3104";
citys[31][5]="3105";
citys[31][6]="3106";
citys[31][7]="3107";
citys[31][8]="3108";
citys[31][9]="3109";
citys[31][10]="3110";
citys[31][11]="3111";
citys[31][12]="3112";
citys[31][13]="3113";
citys[32][1]="3200";
citys[33][1]="3300";
citys[34][1]="3400";
citys[35][1]="3500";


name1[1][1]="������";

name1[2][1]="�Ϻ���";

name1[3][1]="�����";

name1[4][1]="������";

name1[5][1]="������";
name1[5][2]="������";
name1[5][3]="�麣��";
name1[5][4]="��ͷ��";
name1[5][5]="�ع���";
name1[5][6]="��Դ��";
name1[5][7]="÷����";
name1[5][8]="������";
name1[5][9]="��β��";
name1[5][10]="��ݸ��";
name1[5][11]="��ɽ��";
name1[5][12]="������";
name1[5][13]="��ɽ��";
name1[5][14]="������";
name1[5][15]="տ����";
name1[5][16]="ï����";
name1[5][17]="������";
name1[5][18]="��Զ��";
name1[5][19]="������";
name1[5][20]="������";
name1[5][21]="�Ƹ���";
name1[6][1]="������";
name1[6][2]="������";
name1[6][3]="������";
name1[6][4]="������";
name1[6][5]="Ȫ����";
name1[6][6]="������";
name1[6][7]="��ƽ��";
name1[6][8]="������";
name1[6][9]="������";
name1[7][1]="������";
name1[7][2]="������";
name1[7][3]="������";
name1[7][4]="������";
name1[7][5]="������";
name1[7][6]="������";
name1[7][7]="����";
name1[7][8]="������";
name1[7][9]="��ɽ��";
name1[7][10]="̨����";
name1[7][11]="��ˮ��";
name1[8][1]="�Ͼ���";
name1[8][2]="������";
name1[8][3]="���Ƹ���";
name1[8][4]="������";
name1[8][5]="��Ǩ��";
name1[8][6]="�γ���";
name1[8][7]="������";
name1[8][8]="̩����";
name1[8][9]="��ͨ��";
name1[8][10]="����";
name1[8][11]="������";
name1[8][12]="������";
name1[8][13]="������";
name1[9][1]="������";
name1[9][2]="�ൺ��";
name1[9][3]="�Ͳ���";
name1[9][4]="��ׯ��";
name1[9][5]="��Ӫ��";
name1[9][6]="Ϋ����";
name1[9][7]="��̨��";
name1[9][8]="������";
name1[9][9]="������";
name1[9][10]="̩����";
name1[9][11]="������";
name1[9][12]="������";
name1[9][13]="������";
name1[9][14]="������";
name1[9][15]="�ĳ���";
name1[9][16]="������";
name1[9][17]="������";
name1[10][1]="������";
name1[10][2]="������";
name1[10][3]="��ɽ��";
name1[10][4]="��˳��";
name1[10][5]="��Ϫ��";
name1[10][6]="������";
name1[10][7]="������";
name1[10][8]="��«����";
name1[10][9]="Ӫ����";
name1[10][10]="�̽���";
name1[10][11]="������";
name1[10][12]="������";
name1[10][13]="������";
name1[10][14]="������";
name1[11][1]="�ϲ���";
name1[11][2]="��������";
name1[11][3]="Ƽ����";
name1[11][4]="������";
name1[11][5]="�Ž���";
name1[11][6]="ӥ̶��";
name1[11][7]="������";
name1[11][8]="������";
name1[11][9]="�˴���";
name1[11][10]="������";
name1[11][11]="������";
name1[12][1]="�ɶ���";
name1[12][2]="�Թ���";
name1[12][3]="��֦����";
name1[12][4]="������";
name1[12][5]="������";
name1[12][6]="������";
name1[12][7]="��Ԫ��";
name1[12][8]="������";
name1[12][9]="�ڽ���";
name1[12][10]="��ɽ��";
name1[12][11]="�ϳ���";
name1[12][12]="�˱���";
name1[12][13]="�㰲��";
name1[12][14]="������";
name1[12][15]="������";
name1[12][16]="�Ű���";
name1[12][17]="üɽ��";
name1[12][18]="������";
name1[12][19]="������";
name1[12][20]="������";
name1[12][21]="��ɽ��";
name1[13][1]="������";
name1[13][2]="ͭ����";
name1[13][3]="������";
name1[13][4]="������";
name1[13][5]="μ����";
name1[13][6]="�Ӱ���";
name1[13][7]="������";
name1[13][8]="������";
name1[13][9]="������";
name1[13][10]="�������";
name1[14][1]="�人��";
name1[14][2]="��ʯ��";
name1[14][3]="�差��";
name1[14][4]="ʮ����";
name1[14][5]="������";
name1[14][6]="�˲���";
name1[14][7]="������";
name1[14][8]="������";
name1[14][9]="Т����";
name1[14][10]="�Ƹ���";
name1[14][11]="������";
name1[14][12]="������";
name1[14][13]="������";
name1[14][14]="������";
name1[14][15]="Ǳ����";
name1[14][16]="��ũ��";
name1[14][17]="��ʩ��";
name1[15][1]="֣����";
name1[15][2]="������";
name1[15][3]="������";
name1[15][4]="ƽ��ɽ��";
name1[15][5]="������";
name1[15][6]="�ױ���";
name1[15][7]="������";
name1[15][8]="������";
name1[15][9]="�����";
name1[15][10]="������";
name1[15][11]="�����";
name1[15][12]="����Ͽ��";
name1[15][13]="������";
name1[15][14]="������";
name1[15][15]="������";
name1[15][16]="�ܿ���";
name1[15][17]="פ������";
name1[15][18]="��Դ��";
name1[16][1]="ʯ��ׯ��";
name1[16][2]="��ɽ��";
name1[16][3]="�ػʵ���";
name1[16][4]="������";
name1[16][5]="��̨��";
name1[16][6]="������";
name1[16][7]="�żҿ���";
name1[16][8]="�е���";
name1[16][9]="������";
name1[16][10]="�ȷ���";
name1[16][11]="��ˮ��";
name1[17][1]="̫ԭ��";
name1[17][2]="��ͬ��";
name1[17][3]="��Ȫ��";
name1[17][4]="������";
name1[17][5]="������";
name1[17][6]="˷����";
name1[17][7]="������";
name1[17][8]="������";
name1[17][9]="�ٷ���";
name1[17][10]="�˳���";
name1[17][11]="��������";
name1[18][1]="���ͺ���";
name1[18][2]="��ͷ��";
name1[18][3]="�ں���";
name1[18][4]="�����";
name1[18][5]="ͨ����";
name1[18][6]="������˹";
name1[18][7]="�����첼";
name1[18][8]="���ֹ���";
name1[18][9]="���ױ���";
name1[18][10]="�����׶�";
name1[18][11]="��������";
name1[18][12]="�˰���";
name1[19][1]="������";
name1[19][2]="������";
name1[19][3]="��ƽ��";
name1[19][4]="��Դ��";
name1[19][5]="ͨ����";
name1[19][6]="��ɽ��";
name1[19][7]="��ԭ��";
name1[19][8]="�׳���";
name1[19][9]="�ӱ���";
name1[20][1]="��������";
name1[20][2]="�������";
name1[20][3]="�׸���";
name1[20][4]="˫Ѽɽ��";
name1[20][5]="������";
name1[20][6]="������";
name1[20][7]="������";
name1[20][8]="ĵ������";
name1[20][9]="��ľ˹��";
name1[20][10]="��̨����";
name1[20][11]="�ں���";
name1[20][12]="�绯��";
name1[20][13]="���˰���";
name1[21][1]="�Ϸ���";
name1[21][2]="�ߺ���";
name1[21][3]="������";
name1[21][4]="������";
name1[21][5]="����ɽ��";
name1[21][6]="������";
name1[21][7]="ͭ����";
name1[21][8]="������";
name1[21][9]="��ɽ��";
name1[21][10]="������";
name1[21][11]="������";
name1[21][12]="������";
name1[21][13]="������";
name1[21][14]="������";
name1[21][15]="������";
name1[21][16]="������";
name1[21][17]="������";
name1[22][1]="��ɳ��";
name1[22][2]="������";
name1[22][3]="��̶��";
name1[22][4]="������";
name1[22][5]="������";
name1[22][6]="������";
name1[22][7]="������";
name1[22][8]="�żҽ���";
name1[22][9]="������";
name1[22][10]="������";
name1[22][11]="������";
name1[22][12]="������";
name1[22][13]="¦����";
name1[22][14]="������";
name1[23][1]="������";
name1[23][2]="������";
name1[23][3]="������";
name1[23][4]="������";
name1[23][5]="������";
name1[23][6]="���Ǹ���";
name1[23][7]="������";
name1[23][8]="�����";
name1[23][9]="������";
name1[23][10]="����";
name1[23][11]="����";
name1[23][12]="����";
name1[23][13]="��ɫ";
name1[23][14]="�ӳ�";
name1[24][1]="����";
name1[24][2]="������";
name1[24][3]="��ָɽ��";
name1[24][4]="������";
name1[24][5]="������";
name1[24][6]="��ɽ��";
name1[24][7]="�Ĳ���";
name1[24][8]="������";
name1[24][9]="������";
name1[24][10]="������";
name1[24][11]="������";
name1[24][12]="�Ͳ���";
name1[24][13]="�ٸ���";
name1[24][14]="��ɳ��";
name1[24][15]="������";
name1[24][16]="�ֶ���";
name1[24][17]="��ˮ��";
name1[24][18]="��ͤ��";
name1[24][19]="������";
name1[25][1]="������";
name1[25][2]="������";
name1[25][3]="��Ϫ��";
name1[25][4]="��ɽ��";
name1[25][5]="��ͨ��";
name1[25][6]="˼é����";
name1[25][7]="�ٲ׵���";
name1[25][8]="��������";
name1[25][9]="��ɽ��";
name1[25][10]="�����";
name1[25][11]="��˫����";
name1[25][12]="������";
name1[25][13]="������";
name1[25][14]="�º���";
name1[25][15]="ŭ����";
name1[25][16]="������";
name1[26][1]="������";
name1[26][2]="����ˮ��";
name1[26][3]="������";
name1[26][4]="��˳��";
name1[26][5]="ͭ�ʵ���";
name1[26][6]="�Ͻڵ���";
name1[26][7]="ǭ������";
name1[26][8]="ǭ������";
name1[26][9]="ǭ����";
name1[27][1]="������";
name1[27][2]="��������";
name1[27][3]="��������";
name1[27][4]="ɽ�ϵ���";
name1[27][5]="�տ���";
name1[27][6]="�������";
name1[27][7]="��֥����";
name1[28][1]="������";
name1[28][2]="�����";
name1[28][3]="������";
name1[28][4]="��ˮ��";
name1[28][5]="��������";
name1[28][6]="������";
name1[28][7]="��������";
name1[28][8]="ƽ������";
name1[28][9]="��������";
name1[28][10]="¤�ϵ���";
name1[28][11]="��Ҵ����";
name1[28][12]="��Ȫ����";
name1[28][13]="������";
name1[28][14]="������";
name1[29][1]="������";
name1[29][2]="ʯ��ɽ��";
name1[29][3]="������";
name1[29][4]="��ԭ��";
name1[30][1]="������";
name1[30][2]="��������";
name1[30][3]="������";
name1[30][4]="������";
name1[30][5]="������";
name1[30][6]="������";
name1[30][7]="������";
name1[30][8]="������";
name1[31][1]="��³ľ��";
name1[31][2]="��������";
name1[31][3]="ʯ������";
name1[31][4]="��³��";
name1[31][5]="���ܵ���";
name1[31][6]="�������";
name1[31][7]="������";
name1[31][8]="��ʲ����";
name1[31][9]="��������";
name1[31][10]="��������";
name1[31][11]="������";
name1[31][12]="��������";
name1[31][13]="������";
name1[32][1]="���";
name1[33][1]="����";
name1[34][1]="̨��";
name1[35][1]="����";


function clear2(o){
l=o.length;
for (i = 0; i< l; i++){
	o.options[1]=null;
}
}
function sdistrict2(oj,v){
alert("fdd");
var m=-1;
    for (i=1;i<=34;i++){
        if (province[i]==v){
	 m=i;
	}
   }
  clear2(oj);
  if (m!=-1){
     for (i=1;i<citys[m].length;i++){
      oj.add(new Option(name1[m][i],citys[m][i]));
     }
  }
}
