package com.codesquad.airbnb.accmmodation.business;

import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import com.codesquad.airbnb.accmmodation.web.SimpleAccommodationDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AccommodationService {

  private final AccommodationRepository accommodationRepository;

  public SimpleAccommodationDto accommodation() {
    return SimpleAccommodationDto.builder()
        .accommodations(accommodationRepository.findAll())
        .build();
  }
}
