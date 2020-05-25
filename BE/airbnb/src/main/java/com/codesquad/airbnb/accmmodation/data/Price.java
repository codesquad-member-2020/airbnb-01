package com.codesquad.airbnb.accmmodation.data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Embeddable
public class Price {

  @Column(nullable = false)
  private Double price;
}
