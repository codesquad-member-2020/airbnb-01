package com.codesquad.airbnb.accmmodation.business;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import com.codesquad.airbnb.accmmodation.data.type.ImageType;
import com.codesquad.airbnb.accmmodation.web.AccommodationDto;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AccommodationService {

  private final AccommodationRepository accommodationRepository;

  public List<AccommodationDto> accommodation() {
    return accommodationRepository.findAll().stream().map(
        accommodation -> AccommodationDto.builder()
            .id(accommodation.getId())
            .name(accommodation.getName())
            .images(accommodation.getImages().stream()
                .filter(image -> image.getType().equals(ImageType.MAIN))
                .collect(Collectors.toList()))
            .price(accommodation.getPrice())
            .build()).collect(Collectors.toList());
  }

  public AccommodationDto detailAccommodation(Long id) {
    Accommodation accommodation = accommodationRepository.findById(id)
        .orElseThrow(NoSuchElementException::new);

    return AccommodationDto.builder()
        .id(accommodation.getId())
        .name(accommodation.getName())
        .images(accommodation.getImages())
        .coordinate(accommodation.getCoordinate())
        .build();
  }
}
