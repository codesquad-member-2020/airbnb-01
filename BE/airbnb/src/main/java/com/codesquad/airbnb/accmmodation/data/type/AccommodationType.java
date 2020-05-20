package com.codesquad.airbnb.accmmodation.data.type;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum AccommodationType {

  HOTEL(0L, "호텔"), HOSTEL(1L, "호스텔"), INN(2L, "여관");

  private final Long seq;
  private final String name;
}
