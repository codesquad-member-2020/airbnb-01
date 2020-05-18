package com.codesquad.airbnb01.model.type;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum RoomType {

  HOTEL("호텔"), HOSTEL("호스텔"), INN("여관");

  private final String name;
}
