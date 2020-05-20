package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.business.AccommodationService;
import com.codesquad.airbnb.accmmodation.data.Accommodation;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "prod")
@RequiredArgsConstructor
@RequestMapping("/api/accommodation")
@RestController
public class AccommodationController {

  private final AccommodationService accommodationService;
  private final AccommodationDto accommodationDto;

  @ApiOperation(value = "숙소 전체 리스트를 가져옵니다")
  @GetMapping
  public List<AccommodationDto> accommodations() {
    List<Accommodation> accommodations = accommodationService.accommodation();
    return accommodationDto.createAccmmodations(accommodations);
  }

  @ApiOperation(value = "득정 숙소의 상세 정보를 가져옵니다")
  @GetMapping("/{id}")
  public AccommodationDto detailAccommodation(@PathVariable Long id) {
    Accommodation accommodation = accommodationService.detailAccommodation(id);
    return accommodationDto.createAccmmodation(accommodation);
  }
}
