package com.ecom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class ShoppingCartApplication extends SpringBootServletInitializer {
	@Override
	public SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(ShoppingCartApplication.class);
	}
	public static void main(String[] args) {

		System.setProperty("server.servlet.context-path", "/shopping");
		SpringApplication.run(ShoppingCartApplication.class, args);
	}

}

	