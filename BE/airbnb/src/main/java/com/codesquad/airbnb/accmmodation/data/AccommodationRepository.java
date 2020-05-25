package com.codesquad.airbnb.accmmodation.data;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

  List<Accommodation> findByLocationContainingAndPriceBetween(String location, Price min,
      Price max);
}
