package com.codesquad.airbnb.accmmodation.business;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import com.codesquad.airbnb.accmmodation.web.DetailAccommodationDto;
import com.codesquad.airbnb.accmmodation.web.SimpleAccommodationDto;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AccommodationService {

  private final AccommodationRepository accommodationRepository;

  public List<SimpleAccommodationDto> accommodation() {
    List<Accommodation> accommodations = accommodationRepository.findAll();
    return accommodations.stream().map(SimpleAccommodationDto::new).collect(Collectors.toList());
  }

  public DetailAccommodationDto detailAccommodation(Long id) {
    Accommodation accommodation = accommodationRepository.findById(id)
        .orElseThrow(NoSuchElementException::new);
    return new DetailAccommodationDto(accommodation);
  }
}
