package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.Coordinate;
import com.codesquad.airbnb.accmmodation.data.Image;
import com.codesquad.airbnb.accmmodation.data.Price;
import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import java.util.List;
import lombok.Getter;

@Getter
public class DetailAccommodationDto {

  private final Long id;
  private final String name;
  private final AccommodationType type;
  private final Coordinate coordinate;
  private final Price price;
  private final List<Image> images;

  public DetailAccommodationDto(Accommodation accommodation) {
    this.id = accommodation.getId();
    this.name = accommodation.getName();
    this.type = accommodation.getType();
    this.coordinate = accommodation.getCoordinate();
    this.price = accommodation.getPrice();
    this.images = accommodation.getImages();
  }
}
