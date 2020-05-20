package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.business.AccommodationService;
import com.codesquad.airbnb.accmmodation.data.Accommodation;
import java.util.List;
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
  public List<Accommodation> accommodation() {
    return accommodationService.accommodation();
  }
}
