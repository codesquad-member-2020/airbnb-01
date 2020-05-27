package com.codesquad.airbnb.booking.web;

import com.codesquad.airbnb.booking.business.BookingService;
import com.codesquad.airbnb.booking.web.model.BookingCommand;
import com.codesquad.airbnb.booking.web.model.BookingView;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "prod")
@RequiredArgsConstructor
@RequestMapping("/api/booking")
@RestController
public class BookingController {

  private final BookingService bookingService;

  @ApiOperation(value = "숙소를 예약합니다", notes = "Authrization 이 없으면 anonymous@gmail.com 으로 강제됩니다")
  @PostMapping
  public BookingView booking(@RequestBody @Valid BookingCommand command) {
    return bookingService.booking(command);
  }

  @ApiOperation(value = "예약된 숙소 정보를 가져옵니다", notes = "Authrization 이 없으면 anonymous@gmail.com 으로 강제됩니다")
  @GetMapping
  public List<BookingView> showBookings() {
    return bookingService.showBookings();
  }
}
