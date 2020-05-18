package com.codesquad.airbnb01.controller;

import com.codesquad.airbnb01.model.dto.dev.RoomDto;
import com.codesquad.airbnb01.model.entity.Room;
import com.codesquad.airbnb01.model.entity.User;
import com.codesquad.airbnb01.model.type.RoomType;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.ArrayList;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Api(tags = "dev")
@RequestMapping("/dev-api")
public class DevController {

  @GetMapping("/room")
  @ApiOperation(value = "", notes = "숙소에 대한 메인 정보")
  public RoomDto room() {
    List<Room> roomList = new ArrayList<>();
    roomList.add(Room.builder().id(10L).type(RoomType.HOTEL).name("베네키아")
        .user(new User("choi8608@gmail.com")).build());
    roomList.add(Room.builder().id(12L).type(RoomType.INN).name("소노펠리체")
        .user(new User("dingo@gmail.com")).build());

    return RoomDto.builder().roomList(roomList).build();
  }
}
