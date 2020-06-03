package com.codesquad.airbnb.accmmodation.data;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccommodationRepository extends JpaRepository<Accommodation, Long> {

    Page<Accommodation> findByLocationContainingAndPriceBetweenAndGuestsGreaterThanEqual (String location, Price min, Price max,
                                                                                         Integer guests,
                                                                                         Pageable Pageable);

    Page<Accommodation> findByCoordinate_LatitudeBetweenAndCoordinate_LongitudeBetween(
            Double leftTopLatitude, Double rightBottomLatitude
            , Double leftTopLongitude, Double rightBottomLongitude, Pageable Pageable);
}
