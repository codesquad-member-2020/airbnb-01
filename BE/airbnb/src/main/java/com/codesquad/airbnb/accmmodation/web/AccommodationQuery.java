package com.codesquad.airbnb.accmmodation.web;

import java.util.Objects;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class AccommodationQuery {

  private String location;
  private Long priceMin;
  private Long priceMax;

  public void makeFormed() {
    if (Objects.isNull(location)) {
      throw new RuntimeException("지명은 검색 필수 조건 입니다");
    }

    final long DEFAULT_MIN_PRICE = 0L;
    final long DEFAULT_MAX_PRICE = 1000000L;

    priceMin = (Objects.isNull(priceMin)) ? DEFAULT_MIN_PRICE : priceMin;
    priceMax = (Objects.isNull(priceMax)) ? DEFAULT_MAX_PRICE : priceMax;
  }
}
