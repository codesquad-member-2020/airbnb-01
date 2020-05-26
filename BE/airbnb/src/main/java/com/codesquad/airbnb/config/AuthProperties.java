package com.codesquad.airbnb.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Getter
@Component
public class AuthProperties {

  public static final String AUTHORIZE_URL = "https://github.com/login/oauth/authorize";
  public static final String ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token";
  public static final String USER_EMAIL_URL = "https://api.github.com/user/emails";

  @Value("${auth.client-id}")
  private String clientId;
  @Value("${auth.client-secret}")
  private String clientSecret;
}
