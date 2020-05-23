package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.Image;
import com.codesquad.airbnb.accmmodation.data.Price;
import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import com.codesquad.airbnb.accmmodation.data.type.ImageType;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@Getter
public class SimpleAccommodationDto {

  private final Long id;
  private final String name;
  private final AccommodationType type;
  private final Price price;
  private final List<Image> images;

  public SimpleAccommodationDto(Accommodation accommodation) {
    this.id = accommodation.getId();
    this.name = accommodation.getName();
    this.type = accommodation.getType();
    this.images = accommodation.getImages(ImageType.MAIN);
    this.price = accommodation.getPrice();
  }
}