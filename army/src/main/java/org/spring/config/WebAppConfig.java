package org.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

@Configuration
public class WebAppConfig {
	 @Bean
	    public MultipartResolver multipartResolver() {
	        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
	        multipartResolver.setMaxUploadSize(5000000); // 5MB로 파일 크기 제한 설정
	        return multipartResolver;
	    }
	 public void addResourceHandlers(ResourceHandlerRegistry registry) {
	        registry.addResourceHandler("/boardImages/**")
	                .addResourceLocations("file:///C:/Users/keduit/Desktop/STSWS/army/src/main/resources/boardImage/");
	    }
}
