package com;

import java.util.Map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@SpringBootApplication
@EnableScheduling
public class ManagmentTaskApplication {

	public static void main(String[] args) {
		SpringApplication.run(ManagmentTaskApplication.class, args);
	}
	
	@Bean
 	Cloudinary cloudinary() {
 		Map<String, String> config = ObjectUtils.asMap("cloud_name", "ddolp4fuu", "api_key", "221774898368287",
 				"api_secret", "mzX_GMhlRtb6CJBeMQ1KLHQbGmQ");
 		return new Cloudinary(config);
 	}

}
