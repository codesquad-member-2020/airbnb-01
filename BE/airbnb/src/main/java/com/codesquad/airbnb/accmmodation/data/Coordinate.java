package com.codesquad.airbnb.accmmodation.data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Embeddable
public class Coordinate {

  @Column(nullable = false)
  private String location;

  @Column(nullable = false)
  private Double latitude;

  @Column(nullable = false)
  private Double longitude;
}
