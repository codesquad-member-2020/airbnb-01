package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.Coordinate;
import com.codesquad.airbnb.accmmodation.data.Image;
import com.codesquad.airbnb.accmmodation.data.Price;
import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import com.codesquad.airbnb.accmmodation.data.type.ImageType;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Builder;
import lombok.Getter;

@JsonInclude(Include.NON_NULL)
@Builder
@Getter
public class AccommodationDto {

  private final Long id;
  private final String name;
  private final AccommodationType type;
  private final Coordinate coordinate;
  private final List<Image> images;
  private final Price price;

  public static List<AccommodationDto> createAccmmodations(List<Accommodation> accommodations) {
    return accommodations.stream().map(
        accommodation -> AccommodationDto.builder()
            .id(accommodation.getId())
            .type(accommodation.getType())
            .name(accommodation.getName())
            .images(accommodation.getImages(ImageType.MAIN))
            .price(accommodation.getPrice())
            .build()).collect(Collectors.toList());
  }

  public static AccommodationDto createAccommodation(Accommodation accommodation) {
    return AccommodationDto.builder()
        .id(accommodation.getId())
        .type(accommodation.getType())
        .name(accommodation.getName())
        .images(accommodation.getImages())
        .coordinate(accommodation.getCoordinate())
        .build();
  }
}
