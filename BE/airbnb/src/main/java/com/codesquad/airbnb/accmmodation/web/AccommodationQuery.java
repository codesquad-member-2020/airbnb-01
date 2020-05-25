package com.codesquad.airbnb.accmmodation.web;

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
}
