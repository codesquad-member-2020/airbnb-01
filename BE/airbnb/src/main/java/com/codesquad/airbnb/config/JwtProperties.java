package com.codesquad.airbnb.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Getter
@Component
public class JwtProperties {

  public static final Long EXPIRED_TIME = 1000L * 60L * 60L;

  @Value("${jwt.salt}")
  private String salt;
}
