package com.codesquad.airbnb.accmmodation.web;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class SimpleAccommodationDto {

  private final List<Accommodation> accommodations;
}
