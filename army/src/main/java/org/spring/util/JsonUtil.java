package org.spring.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

public class JsonUtil {
	private static final Logger logger = LoggerFactory.getLogger(JsonUtil.class);
	
	public static <T> T parseJson(String jsonString, Class<T> clazz) {
		Gson gson = new Gson();
		
		T result = gson.fromJson(jsonString, clazz);
		logger.info("parseJson {} : "+jsonString);
		logger.info("parseJson result {} : "+result);
		
		return result;
	}
}
