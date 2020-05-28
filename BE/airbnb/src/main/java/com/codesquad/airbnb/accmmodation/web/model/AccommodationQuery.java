package com.codesquad.airbnb.accmmodation.web.model;

import java.util.Objects;
import lombok.Getter;
import org.springframework.util.ObjectUtils;

@Getter
public class AccommodationQuery {

  private String location;
  private Long priceMin;
  private Long priceMax;
  private Integer pageCount;

  public AccommodationQuery(String location, Long priceMin, Long priceMax, Integer pageCount) {
    if (ObjectUtils.isEmpty(location.trim())) {
      throw new RuntimeException("지명은 검색 필수 조건 입니다");
    }

    this.location = location;

    final long DEFAULT_MIN_PRICE = 0L;
    final long DEFAULT_MAX_PRICE = 1000000L;
    final int DEFAULT_PAGE_COUNT = 0;

    this.priceMin = (Objects.isNull(priceMin)) ? DEFAULT_MIN_PRICE : priceMin;
    this.priceMax = (Objects.isNull(priceMax)) ? DEFAULT_MAX_PRICE : priceMax;
    this.pageCount = (Objects.isNull(pageCount)) ? DEFAULT_PAGE_COUNT : pageCount;
  }
}
