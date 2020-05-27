package com.codesquad.airbnb.accmmodation.web.model;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.Image;
import com.codesquad.airbnb.accmmodation.data.Price;
import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import com.codesquad.airbnb.accmmodation.data.type.ImageType;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@Getter
public class AccommodationView {

  private final Long id;
  private final String name;
  private final AccommodationType type;
  private final String location;
  private final Price price;
  private final List<Image> images;

  @Builder
  public AccommodationView(Accommodation accommodation) {
    this.id = accommodation.getId();
    this.name = accommodation.getName();
    this.type = accommodation.getType();
    this.location = accommodation.getLocation();
    this.price = accommodation.getPrice();
    this.images = accommodation.getImages(ImageType.MAIN);
  }
}
