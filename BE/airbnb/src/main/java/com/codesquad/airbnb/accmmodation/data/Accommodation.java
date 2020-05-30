package com.codesquad.airbnb.accmmodation.data;

import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import com.codesquad.airbnb.accmmodation.data.type.ImageType;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OrderColumn;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Entity
public class Accommodation {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String name;

  @Enumerated(EnumType.STRING)
  @Column(nullable = false)
  private AccommodationType type;

  @Column(nullable = false)
  private String location;

  @Embedded
  private Coordinate coordinate;

  @ElementCollection(fetch = FetchType.EAGER)
  @OrderColumn
  private List<Image> images;

  @Embedded
  private Price price;

  @ElementCollection(fetch = FetchType.EAGER)
  private List<LocalDate> bookedDate;

  @Builder
  public Accommodation(Long id, String name, AccommodationType type, String location,
      Coordinate coordinate, List<Image> images, Price price) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.location = location;
    this.coordinate = coordinate;
    this.images = images;
    this.price = price;
  }

  public boolean isAlreadyBookedDate(LocalDate targetDate) {
    return bookedDate.stream().anyMatch(bookedDate -> bookedDate.isEqual(targetDate));
  }

  public void addBookDate(LocalDate targetDate) {
    bookedDate.add(targetDate);
  }

  public List<Image> getImages(ImageType type) {
    return images.stream()
        .filter(image -> image.getType().equals(type))
        .collect(Collectors.toList());
  }
}
