package eahoosoft.freemarker;

import java.net.URL;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import eahoosoft.common.Constants;
import eahoosoft.dao.HibernateSessionFactory;
import eahoosoft.pojo.Product;


public class Common {
	public static void fillCommonVar(Map map){
		map.put("appPath", "/soft/");
		map.put("appTitle", Constants.APP_TITLE);
		map.put("appDesc", Constants.APP_DESC);
		map.put("appKeywords", Constants.APP_KEY_WORDS);
	}
	public static void fillPageInfoFromURL(String urlStr,Map map){
		try {
			URL url = new URL(urlStr);
			Document doc = Jsoup.parse(url,5000);
			String title = doc.title();			
			map.put("appTitle", title);
			String keywords = doc.select("meta[name=keywords]").get(0).attr("content");
			map.put("appKeywords", keywords);
			String description = doc.select("meta[name=description]").get(0).attr("content");
			map.put("appDesc", description);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("发生错误的URL是：" + urlStr);
		} 
	}
	public static void fillRightData(Map map){
		Session s = HibernateSessionFactory.getSession();
		List<Product> mList = s.createQuery("from Product p where p.cate.fileName='m' order by p.orderNum").list();
		map.put("mList", mList);
		
		List<Product> vList = s.createQuery("from Product p where p.cate.fileName='' and p.name not like '%DVD%' order by p.orderNum").list();
		map.put("vList", vList);
		
		List<Product> dList = s.createQuery("from Product p where p.cate.fileName='' and p.name like '%DVD%' order by p.orderNum").list();
		map.put("dList", dList);
		
		List<Product> iList = s.createQuery("from Product p where p.cate.fileName='i' order by p.orderNum").list();
		map.put("iList", iList);
		
		List<Product> aList = s.createQuery("from Product p where p.cate.fileName='a' order by p.orderNum").list();
		map.put("aList", aList);
	}
	public static String replaceChars(String content){
		content = content.replaceAll("“", "\"");
		content = content.replaceAll("’", "'");
		content = content.replaceAll("<br>", "<br/>");
		content = content.replaceAll("eahoosoft-DVD-Ripper.html", "eahoosoft-dvd-ripper.html");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-14", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-10&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-35", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-11&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-34", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-12&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-36", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-13&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-2", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-2&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-1", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-3&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-4", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-4&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-3", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-5&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-7", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-6&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-10", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-7&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-9", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-8&q=1&v=0&d=0");
		content = content.replaceAll("https://www.regnow.com/softsell/nph-softsell.cgi?item=29237-20", "https://usd.swreg.org/cgi-bin/s.cgi?s=128442&p=128442-9&q=1&v=0&d=0");
		//content = content.replaceAll("", "");
		//content = content.replaceAll("", "");
		
		return content;
	}
}
