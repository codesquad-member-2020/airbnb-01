package com.codesquad.airbnb.booking.web;

import com.codesquad.airbnb.booking.web.model.BookingCommand;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "prod")
@RequiredArgsConstructor
@RequestMapping("/api/booking")
@RestController
public class BookingController {

  @ApiOperation(value = "숙소를 예약합니다")
  @PostMapping
//  public List<AccommodationView> booking(BookingCommand command) {
  public Object booking(@RequestBody @Valid BookingCommand command) {
    return command;
//    return accommodationService.accommodation(command);
  }

//  @ApiImplicitParam(name = "id", value = "전체 리스트에서 가져오는 숙소 ID", required = true)
//  @ApiOperation(value = "특정 숙소의 상세 정보를 가져옵니다")
//  @GetMapping("/{id}")
//  public DetailAccommodationView detailAccommodation(@PathVariable Long id) {
//    return accommodationService.detailAccommodation(id);
//  }
}
