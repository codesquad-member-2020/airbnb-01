package com.codesquad.airbnb01.model.entity;

import com.codesquad.airbnb01.model.type.RoomType;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class Room {

  private final Long id;
  private final RoomType type;
  private final String name;
  private final User user;
}
