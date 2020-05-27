package com.codesquad.airbnb.booking.web.model;

import java.time.LocalDate;
import javax.validation.constraints.Future;
import javax.validation.constraints.FutureOrPresent;
import javax.validation.constraints.NotNull;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.hibernate.validator.constraints.Range;
import org.springframework.validation.annotation.Validated;

@Validated
@RequiredArgsConstructor
@Getter
public class BookingCommand {

  @NotNull
  private final Long accommodationId;

  @FutureOrPresent
  private final LocalDate checkIn;

  @Future
  private final LocalDate checkOut;

  @Range(min = 1, max = 9)
  private final Integer personCount;
}
