package eahoosoft.freemarker;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.hibernate.Session;

import eahoosoft.dao.HibernateSessionFactory;
import eahoosoft.pojo.Product;
import freemarker.template.Configuration;
import freemarker.template.Template;

public class ProductDetail {
	public static void main(String[] args) throws Exception {

		Configuration cfg = new Configuration();
		cfg.setDirectoryForTemplateLoading(new File(All.SAMPLE_DIR));
		cfg.setEncoding(Locale.US, "UTF8");

		Template template = cfg.getTemplate("product_detail.ftl");

		Session s = HibernateSessionFactory.getSession();
		List<Product> list = s.createQuery("from Product").list();
		for (Product p : list) {
			Map map = new HashMap();

			// 添加公用的数据模型
			Common.fillCommonVar(map);
			String fileName = "eahoosoft-video-converter";
			String oldFileName = "EahoosoftVideoConverter";
			if (fileName.equals(p.getFileName()))
				Common.fillPageInfoFromURL(All.SITE_PRE + p.getFileName() + "/" + oldFileName + ".html", map);
			else
				Common.fillPageInfoFromURL(All.SITE_PRE + p.getFileName() + "/" + p.getFileName() + ".html", map);

			// 标题栏模块下标
			map.put("currModule", 1);// 产品
			// 产品，用p变量
			map.put("p", p);
			// 添加顶部、底部和右侧的变量
			Common.fillRightData(map);

			File dir = new File(All.SOFT_DIR + p.getFileName());
			if (!dir.exists())
				dir.mkdir();
			String dirPathName = p.getDirName() == null || "".equals(p.getDirName()) ? (p.getFileName() == null ? "" : p.getFileName()) : p.getDirName();
			File file = new File(All.SOFT_DIR + dirPathName + "\\" + p.getFileName() + ".html");
			PrintWriter pw = new PrintWriter(new FileOutputStream(file));
			template.process(map, pw);
			pw.close();
		}

	}
}
