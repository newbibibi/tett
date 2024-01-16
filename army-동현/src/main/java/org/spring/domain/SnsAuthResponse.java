package org.spring.domain;

import lombok.Data;

@Data
public class SnsAuthResponse {
	private String code;
	private String state;
	private int error;
	private String error_description;
}
