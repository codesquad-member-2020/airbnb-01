package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.business.AccommodationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/accommodation")
@RestController
public class AccommodationController {

  private final AccommodationService accommodationService;

  @GetMapping
  public SimpleAccommodationDto accommodation() {
    return accommodationService.accommodation();
  }
}
