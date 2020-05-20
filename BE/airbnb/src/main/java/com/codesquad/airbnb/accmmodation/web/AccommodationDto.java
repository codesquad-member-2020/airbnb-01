package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.data.Coordinate;
import com.codesquad.airbnb.accmmodation.data.Image;
import com.codesquad.airbnb.accmmodation.data.Price;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@JsonInclude(Include.NON_NULL)
@Builder
@Getter
public class AccommodationDto {

  private final Long id;
  private final String name;
  private final Coordinate coordinate;
  private final List<Image> images;
  private final Price price;
}
