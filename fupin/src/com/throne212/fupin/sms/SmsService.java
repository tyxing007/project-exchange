package com.throne212.fupin.sms;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.logging.Logger;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;

/**
 * This class was generated by the JAX-WS RI. JAX-WS RI 2.1.3-hudson-390-
 * Generated source version: 2.0
 * <p>
 * An example of how this class may be used:
 * 
 * <pre>
 * smsService service = new smsService();
 * SmsServicePortType portType = service.getSmsServiceHttpPort();
 * portType.sendMessageToUser(...);
 * </pre>
 * 
 * </p>
 * 
 */
@WebServiceClient(name = "smsService", targetNamespace = "www.kwhope.com", wsdlLocation = "http://192.168.1.91:7003/kwoa/gzagriservices/smsService?wsdl")
public class SmsService extends Service {

	private final static URL SMSSERVICE_WSDL_LOCATION;
	private final static Logger logger = Logger.getLogger(com.throne212.fupin.sms.SmsService.class.getName());

	static {
		URL url = null;
		try {
			URL baseUrl;
			baseUrl = com.throne212.fupin.sms.SmsService.class.getResource(".");
			url = new URL(baseUrl, "http://192.168.1.91:7003/kwoa/gzagriservices/smsService?wsdl");
		} catch (MalformedURLException e) {
			logger.warning("Failed to create URL for the wsdl Location: 'http://192.168.1.91:7003/kwoa/gzagriservices/smsService?wsdl', retrying as a local file");
			logger.warning(e.getMessage());
		}
		SMSSERVICE_WSDL_LOCATION = url;
	}

	public SmsService(URL wsdlLocation, QName serviceName) {
		super(wsdlLocation, serviceName);
	}

	public SmsService() {
		super(SMSSERVICE_WSDL_LOCATION, new QName("www.kwhope.com", "smsService"));
	}

	/**
	 * 
	 * @return returns SmsServicePortType
	 */
	@WebEndpoint(name = "smsServiceHttpPort")
	public SmsServicePortType getSmsServiceHttpPort() {
		return super.getPort(new QName("www.kwhope.com", "smsServiceHttpPort"), SmsServicePortType.class);
	}

}