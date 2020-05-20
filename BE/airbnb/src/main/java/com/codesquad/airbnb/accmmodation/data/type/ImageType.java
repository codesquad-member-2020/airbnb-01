package com.codesquad.airbnb.accmmodation.data.type;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum ImageType {

  MAIN(0L, "메인"), DETAIL(1L, "디테일"), BATH(2L, "화장실");

  private final Long seq;
  private final String name;
}
