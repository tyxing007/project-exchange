<!--%@ page contentType="image/jpeg" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*" %-->
<%@ page import="com.bean.*"%>
<%@ page import="java.io.OutputStream" %>
<%@ page contentType="image/jpeg" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*,com.sun.image.codec.jpeg.JPEGCodec,com.sun.image.codec.jpeg.JPEGImageEncoder;"%>
<%!
Color getRandColor(int fc,int bc){//������Χ��������ɫ
       // Random random = new Random();
       int r=fc,g=fc,b=bc;
//   int r=255,g=255,b=80;
//        if(fc>255) fc=255;
//        if(bc>255) bc=255;
//        int r=fc+random.nextInt(bc-fc);
//        int g=fc+random.nextInt(bc-fc);
//        int b=fc+random.nextInt(bc-fc);
        return new Color(r,g,b);
        }
%>
<%
//����ҳ�治����
response.reset();
response.setContentType("image/jpeg");
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

// ���ڴ��д���ͼ��
int width=60, height=20;
BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
OutputStream os=response.getOutputStream();

// ��ȡͼ��������
Graphics g = image.getGraphics();

//���������
Random random = new Random();

// �趨����ɫ
g.setColor(getRandColor(250,250));
g.fillRect(0, 0, width, height);

//�趨����
g.setFont(new Font("Times New Roman",Font.PLAIN,18));

//���߿�
//g.setColor(new Color());
//g.drawRect(0,0,width-1,height-1);


// �������155�������ߣ�ʹͼ���е���֤�벻�ױ���������̽�⵽
g.setColor(getRandColor(160,200));
for (int i=0;i<0;i++)
{
	int x = random.nextInt(width);
	int y = random.nextInt(height);
        int xl = random.nextInt(12);
        int yl = random.nextInt(12);
	g.drawLine(x,y,x+xl,y+yl);
}

// ȡ�����������֤��(4λ����)
//String rand = request.getParameter("rand");
//rand = rand.substring(0,rand.indexOf("."));

 char[]   seeds   =   {'1','2','3','4','5','6','7','8','9','0'};

String sRand="";
String rand="";
for (int i=0;i<4;i++){
//    String rand=String.valueOf(random.nextInt(10));
    rand= ""+seeds[random.nextInt(10)];
    sRand+=rand;
    // ����֤����ʾ��ͼ����
    g.setColor(new Color(10+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));//���ú�����������ɫ��ͬ����������Ϊ����̫�ӽ�������ֻ��ֱ������
    g.drawString(rand,13*i+4,16);
}

// ����֤�����SESSION
session.removeAttribute(Parameter.IMG_CODE);
session.setAttribute(Parameter.IMG_CODE,sRand);

// ͼ����Ч
g.dispose();

// ���ͼ��ҳ��
JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
encoder.encode(image);
//ImageIO.write(image, "JPEG", response.getOutputStream());
os.flush();
os.close();
os=null;
response.flushBuffer();
out.clear();
out = pageContext.pushBody();
%>