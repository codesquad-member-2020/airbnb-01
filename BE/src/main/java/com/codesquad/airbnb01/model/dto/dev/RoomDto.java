package com.codesquad.airbnb01.model.dto.dev;

import com.codesquad.airbnb01.model.entity.Room;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RoomDto {

  private final List<Room> roomList;
}
