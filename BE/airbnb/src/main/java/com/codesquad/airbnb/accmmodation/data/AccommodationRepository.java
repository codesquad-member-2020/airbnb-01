package com.codesquad.airbnb.accmmodation.data;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

  Page<Accommodation> findByLocationContainingAndPriceBetween(String location, Price min, Price max,
      Pageable Pageable);
}
