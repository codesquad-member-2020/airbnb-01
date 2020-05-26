package com.codesquad.airbnb.accmmodation.web;

import java.util.Objects;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.util.ObjectUtils;

@ToString
@Getter
@Setter
public class AccommodationQuery {

  private String location;
  private Long priceMin;
  private Long priceMax;
  private Integer pageCount;

  public void makeFormed() {
    if (ObjectUtils.isEmpty(location.trim())) {
      throw new RuntimeException("지명은 검색 필수 조건 입니다");
    }

    final long DEFAULT_MIN_PRICE = 0L;
    final long DEFAULT_MAX_PRICE = 1000000L;
    final int DEFAULT_PAGE_COUNT = 0;

    if (Objects.isNull(priceMin)) {
      priceMin = DEFAULT_MIN_PRICE;
    }

    if (Objects.isNull(priceMax)) {
      priceMax = DEFAULT_MAX_PRICE;
    }

    if (Objects.isNull(pageCount)) {
      pageCount = DEFAULT_PAGE_COUNT;
    }
  }
}
