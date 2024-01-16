package org.spring.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Properties;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.net.ssl.HttpsURLConnection;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.spring.domain.SnsAuthResponse;
import org.spring.domain.SnsTokenResponse;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import lombok.extern.log4j.Log4j;

@Log4j
public class RestApiUtil {
	private static final Logger logger = LoggerFactory.getLogger(RestApiUtil.class);

	public static String gmailSender(String email) {
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost("smtp.gmail.com");
		sender.setPort(587);
		sender.setUsername("rparPwjs10@gmail.com");
		sender.setPassword("hhga iwql ewxz gtva");

		Properties javaMailProperties = new Properties();
		javaMailProperties.put("mail.transport.protocol", "smtp");
		javaMailProperties.put("mail.smtp.auth", "true");
		javaMailProperties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		javaMailProperties.put("mail.smtp.starttls.enable", "true");
		javaMailProperties.put("mail.debug", "true");
		javaMailProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		javaMailProperties.put("mail.smtp.ssl.protocols", "TLSv1.2");

		sender.setJavaMailProperties(javaMailProperties);
		
		MimeMessage mailContent = sender.createMimeMessage();
		MimeMessageHelper helper;
		String randomASKII="";
		String code="";
		for(int i=65; i<=90; i++) {
			randomASKII+=(char)i;
		}
		for(int i=97; i<=122; i++) {
			randomASKII+=(char)i;
		}
		for(int i=0; i<=9; i++) {
			randomASKII+=i+"";
		}
		System.out.println(randomASKII);
		Random random=new Random();
		for(int i=0; i<8; i++) {
			code+=randomASKII.charAt(random.nextInt(randomASKII.length()));
		}
		
		String content="<h1> (주)당군입니다.</h1><br>"+code+" 확인코드 입니다."; //메일 내용
		
		try {
			helper = new MimeMessageHelper(mailContent, true, "UTF-8");
			helper.setTo(email);
			helper.setSubject("당군 이메일 인증");
			helper.setText(content,true);
			sender.send(mailContent);
		} catch (MessagingException e) {
			code="유효하지 않은 이메일입니다.";
			e.printStackTrace();
		}
		return code;
	}

	// 여기부터 SNS LOGIN 이용 메서드
	public static String AuthLinkMaker(String v) {
		String uri = "";
		HashMap<String, String> kmap = new HashMap<String, String>();
		HashMap<String, String> nmap = new HashMap<String, String>();
		HashMap<String, String> gmap = new HashMap<String, String>();
		HashMap<String, String> smap = null;
		nmap.put("uri", "https://nid.naver.com/oauth2.0/authorize");
		nmap.put("response_type", "code");
		nmap.put("client_id", "wHHigv5v7qWxvZa99IXH");
		nmap.put("redirect_uri", "http://localHost:8090/user/auth?v=n");
		nmap.put("state", "nloginForDanggun");

		gmap.put("uri", "https://accounts.google.com/o/oauth2/v2/auth");
		gmap.put("response_type", "code");
		gmap.put("client_id", "701798029806-45sh6d0gnheca5ka2e29ktr2ude0du1g.apps.googleusercontent.com");
		gmap.put("redirect_uri", "http://localHost:8090/user/auth?v=g");
		gmap.put("scope", "email");

		kmap.put("uri", "https://kauth.kakao.com/oauth/authorize");
		kmap.put("response_type", "code");
		kmap.put("client_id", "db298f996b480565adcb0c586b747932");
		kmap.put("redirect_uri", "http://localHost:8090/user/auth?v=k");

		switch (v) {
		case "n":
			smap = nmap;
			break;
		case "g":
			smap = gmap;
			break;
		case "k":
			smap = kmap;
			break;
		}
		uri += smap.get("uri");
		smap.remove("uri");
		log.info("log" + smap);
		int cnt = 0;
		for (String key : smap.keySet()) {
			if (cnt == 0) {
				uri += "?" + key + "=" + smap.get(key);
				cnt = 1;
			} else {
				uri += "&" + key + "=" + smap.get(key);
			}
		}
		return uri;
	}

	public static <T> SnsTokenResponse getToken(String portal, SnsAuthResponse response) {
		SnsTokenResponse token = null;
		String uri = "";
		String PostDate = "";
		HashMap<String, String> kmap = new HashMap<String, String>();
		HashMap<String, String> nmap = new HashMap<String, String>();
		HashMap<String, String> gmap = new HashMap<String, String>();
		HashMap<String, String> smap = null;

		HashMap<String, String> gheader = new HashMap<String, String>();
		HashMap<String, String> kheader = new HashMap<String, String>();
		HashMap<String, String> header = null;

		nmap.put("uri", "https://nid.naver.com/oauth2.0/token");
		nmap.put("grant_type", "authorization_code");
		nmap.put("client_id", "wHHigv5v7qWxvZa99IXH");
		nmap.put("client_secret", "r7ZgoltV_O");
		nmap.put("code", response.getCode());
		nmap.put("state", "nloginForDanggun");

		gheader.put("Content-Type", "application/x-www-form-urlencoded");
		gmap.put("uri", "https://oauth2.googleapis.com/token");
		gmap.put("grant_type", "authorization_code");
		gmap.put("client_id", "701798029806-45sh6d0gnheca5ka2e29ktr2ude0du1g.apps.googleusercontent.com");
		gmap.put("code", response.getCode());
		gmap.put("client_secret", "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");
		gmap.put("redirect_uri", "http://localHost:8090/user/auth?v=g");

		kheader.put("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		kmap.put("uri", "https://kauth.kakao.com/oauth/token");
		kmap.put("grant_type", "authorization_code");
		kmap.put("client_id", "db298f996b480565adcb0c586b747932");
		kmap.put("redirect_uri", "http://localHost:8090/user/auth?v=k");
		kmap.put("code", response.getCode());

		switch (portal) {
		case "n":
			smap = nmap;
			break;
		case "g":
			smap = gmap;
			header = gheader;
			break;
		case "k":
			smap = kmap;
			header = kheader;
			break;
		}
		uri = smap.get("uri");
		smap.remove("uri");
		for (String key : smap.keySet()) {
			PostDate += key + "=" + smap.get(key) + "&";
		}
		try {
			String s = postHttpConn(uri, header, PostDate);
			System.out.println(s);
			token = JsonUtil.parseJson(s, SnsTokenResponse.class);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return token;
	}

	public static String getUserData(String portal, SnsTokenResponse token) {
		String[] urlData = { "https://openapi.naver.com/v1/nid/me", "https://www.googleapis.com/oauth2/v3/userinfo",
				"https://kapi.kakao.com/v2/user/me" };
		String url = "";
		String result = "";
		String snsID = "";
		HashMap<String, String> nheader = new HashMap<String, String>();
		HashMap<String, String> gheader = new HashMap<String, String>();
		HashMap<String, String> kheader = new HashMap<String, String>();
		HashMap<String, String> header = null;

		nheader.put("Authorization", "Bearer " + token.getAccess_token());
		gheader.put("Authorization", token.getToken_type() + token.getAccess_token());

		kheader.put("Authorization", token.getToken_type() + " " + token.getAccess_token());
		kheader.put("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		try {
			switch (portal) {
			case "n":
				header = nheader;
				url = urlData[0];
				result = postHttpConn(url, header, null);
				break;
			case "g":
				header = gheader;
				url = urlData[1];
				result = getHttpConn(url, header, null);
				break;
			case "k":
				header = kheader;
				url = urlData[2];
				result = postHttpConn(url, header, null);
				break;
			}

			JSONObject obj = new JSONObject(result);
			snsID = portal.equals("n") ? "n/" + obj.getJSONObject("response").getString("id")
					: portal.equals("k") ? "k/" + obj.getLong("id")
							: portal.equals("g") ? "g/" + obj.getString("sub") : "";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return snsID;
	} // 여기까지 SNS LOGIN Method

	// http연결을 위한 url, 헤더/본문 요청 파라미터, 응답할 데이터 형식 전달 필요
	public static <T> T ConnHttpGetType(String conUrl, HashMap<String, String> headerData, HashMap<String, String> data,
			Class<T> classType) {
		try {
			// 원래 String 클래스는 불변
//			String s = "hello";
//			s = "hi"; // 문자열 변경할때 마다 객체 다시 생성

			// 문자열 동적(가변) 처리 : 문자열의 처리 효율 증대
			StringBuilder urlBuilder = new StringBuilder(conUrl);

			// 반복 횟수 체크
			int count = 0;
			// 요청 : conUrl?name=value&name2=value......
			if (data != null) {
				for (String key : data.keySet()) {
					if (count == 0) {
						urlBuilder.append("?" + URLEncoder.encode(key, "UTF-8") + "="
								+ URLEncoder.encode(data.get(key), "UTF-8"));
					} else {
						urlBuilder.append("&" + URLEncoder.encode(key, "UTF-8") + "="
								+ URLEncoder.encode(data.get(key), "UTF-8"));
					}
					count++;
				} // for 닫기
			}
			if (urlBuilder.toString().startsWith("https")) {
				return JsonUtil.parseJson(RestApiUtil.httpsConn(urlBuilder.toString(), headerData), classType);
			} else {
				return JsonUtil.parseJson(RestApiUtil.httpConn(urlBuilder.toString(), headerData), classType);
			}

		} catch (Exception e) {
			logger.error("ConnHttpGetType Error : {}", e);
			return null;
		}
	}

	public static String httpsConn(String conUrl, HashMap<String, String> headerData) throws IOException {
		URL url = new URL(conUrl);
		// 서비스를 제공할 API에 파라미터 정보와 함께 요청
		HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		if (headerData != null) {
			for (String key : headerData.keySet()) {
				conn.addRequestProperty(key, headerData.get(key));
			}
		}
		BufferedReader rd;

		// 응답 성공
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			// 응답 실패
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		return sb.toString();
	}

	public static String httpConn(String conUrl, HashMap<String, String> headerData) throws IOException {
		URL url = new URL(conUrl);
		// 서비스를 제공할 API에 파라미터 정보와 함께 요청
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		for (String key : headerData.keySet()) {
			conn.addRequestProperty(key, headerData.get(key));
		}
		BufferedReader rd;

		// 응답 성공
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			// 응답 실패
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		return sb.toString();
	}

	// POST 방식으로 요청시
	public static String postHttpConn(String conUrl, HashMap<String, String> headerData, String postData)
			throws IOException {
		URL url = new URL(conUrl);
		// 서비스를 제공할 API에 파라미터 정보와 함께 요청
		HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		if (headerData != null) {
			for (String key : headerData.keySet()) {
				conn.addRequestProperty(key, headerData.get(key));
			}
		} else {
		}

		conn.setDoOutput(true); // false : Get, true : Post

		// String postData

		// HttpURLConnection객체에서 출력 스트림 얻기
		// :요청을 받는 곳에서 데이터를 읽고 쓸수있도록 해줌
		if (postData != null) {
			conn.setRequestProperty("Content-Length", String.valueOf(postData.getBytes("UTF-8").length));
			conn.getOutputStream().write(postData.getBytes("UTF-8"));
			System.out.println(postData);
			System.out.println(conUrl);
		} // 응답처리 단계 시작
		BufferedReader rd;

		// 응답 성공
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			// 응답 실패
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		return sb.toString();
	}

	public static String getHttpConn(String conUrl, HashMap<String, String> headerData, String postData)
			throws IOException {
		URL url = new URL(conUrl);
		// 서비스를 제공할 API에 파라미터 정보와 함께 요청
		HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		if (headerData != null) {
			for (String key : headerData.keySet()) {
				conn.addRequestProperty(key, headerData.get(key));
			}
		} else {
		}

		conn.setDoOutput(true); // false : Get, true : Post

		// String postData

		// HttpURLConnection객체에서 출력 스트림 얻기
		// :요청을 받는 곳에서 데이터를 읽고 쓸수있도록 해줌
		if (postData != null) {
			conn.setRequestProperty("Content-Length", String.valueOf(postData.getBytes("UTF-8").length));
			conn.getOutputStream().write(postData.getBytes("UTF-8"));
			System.out.println(postData);
			System.out.println(conUrl);
		} // 응답처리 단계 시작
		BufferedReader rd;

		// 응답 성공
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			// 응답 실패
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		return sb.toString();
	}
}
