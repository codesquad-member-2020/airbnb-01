package com.codesquad.airbnb.accmmodation.web.model;

import java.util.Objects;
import lombok.Getter;
import org.springframework.util.ObjectUtils;

@Getter
public class AccommodationQuery {

  private String location;
  private Long priceMin = 0L;
  private Long priceMax = 1000000L;
  private Integer pageCount = 0;

  public AccommodationQuery(String location, Long priceMin, Long priceMax, Integer pageCount) {
    if (ObjectUtils.isEmpty(location.trim())) {
      throw new RuntimeException("지명은 검색 필수 조건 입니다");
    }

    this.location = location;
    this.priceMin = (Objects.isNull(priceMin)) ? this.priceMin : priceMin;
    this.priceMax = (Objects.isNull(priceMax)) ? this.priceMax : priceMax;
    this.pageCount = (Objects.isNull(pageCount)) ? this.pageCount : pageCount;
  }
}
