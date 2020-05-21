package com.codesquad.airbnb.accmmodation.data.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum AccommodationType {

  HOTEL("HOTEL", "호텔"), HOSTEL("HOSTEL", "호스텔"), INN("INN", "여관");

  private final String key;
  private final String title;
}
