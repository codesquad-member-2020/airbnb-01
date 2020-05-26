package com.codesquad.airbnb.util;


import com.codesquad.airbnb.config.JwtProperties;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;
import javax.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class JwtToken {

  private static JwtProperties staticJwtProperties;
  private final JwtProperties jwtProperties;

  public static String create(Map<String, String> claims) {
    try {
      JwtBuilder jwt = Jwts.builder()
          .setHeaderParam("typ", "JWT")
          .setIssuedAt(new Date(System.currentTimeMillis()))
          .setExpiration(new Date(System.currentTimeMillis() + JwtProperties.EXPIRED_TIME));
      for (String key : claims.keySet()) {
        jwt.claim(key, claims.get(key));
      }

      return jwt.signWith(SignatureAlgorithm.HS256, generateKey()).compact();
    } catch (Exception e) {
      throw new RuntimeException("JWT TOKEN 생성에 실패하였습니다");
    }
  }

  private static byte[] generateKey() {
    return staticJwtProperties.getSalt().getBytes(StandardCharsets.UTF_8);
  }

  public static String parseEmail(String jwt) throws RuntimeException {
    try {
      Claims claims = Jwts.parser().setSigningKey(generateKey()).parseClaimsJws(jwt)
          .getBody();

      return claims.get("email").toString();
    } catch (Exception e) {
      return null;
    }
  }

  @PostConstruct
  private void initStaticJwtProperties() {
    staticJwtProperties = this.jwtProperties;
  }
}
