package com.codesquad.airbnb.accmmodation.web.model;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.Coordinate;
import com.codesquad.airbnb.accmmodation.data.Image;
import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@Getter
public class DetailAccommodationView {

  private final Long id;
  private final String name;
  private final AccommodationType type;
  private final String location;
  private final Coordinate coordinate;
  private final List<Image> images;

  @Builder
  public DetailAccommodationView(Accommodation accommodation) {
    this.id = accommodation.getId();
    this.name = accommodation.getName();
    this.type = accommodation.getType();
    this.location = accommodation.getLocation();
    this.coordinate = accommodation.getCoordinate();
    this.images = accommodation.getImages();
  }
}
