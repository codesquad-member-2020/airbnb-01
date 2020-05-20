package com.codesquad.airbnb.accmmodation.data;

import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import com.codesquad.airbnb.accmmodation.data.type.ImageType;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Accommodation {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String name;

  @Column(nullable = false)
  private AccommodationType type;

  @Embedded
  private Coordinate coordinate;

  @OneToMany
  @JoinColumn(name = "accommodation_id")
  private List<Image> images;

  @Embedded
  private Price price;

  public List<Image> getImages(ImageType type) {
    return images.stream()
        .filter(image -> image.getType().equals(type))
        .collect(Collectors.toList());
  }
}
