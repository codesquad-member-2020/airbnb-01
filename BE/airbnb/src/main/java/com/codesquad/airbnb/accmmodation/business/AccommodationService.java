package com.codesquad.airbnb.accmmodation.business;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import com.codesquad.airbnb.accmmodation.data.Price;
import com.codesquad.airbnb.accmmodation.web.AccommodationQuery;
import com.codesquad.airbnb.accmmodation.web.DetailAccommodationView;
import com.codesquad.airbnb.accmmodation.web.AccommodationView;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AccommodationService {

  private final AccommodationRepository accommodationRepository;

  public List<AccommodationView> accommodation(AccommodationQuery query) {
    List<Accommodation> accommodations = accommodationRepository
        .findByLocationContainingAndPriceBetween(
            query.getLocation(),
            Price.builder().price(query.getPriceMin()).build(),
            Price.builder().price(query.getPriceMax()).build());
    return accommodations.stream().map(AccommodationView::new).collect(Collectors.toList());
  }

  public DetailAccommodationView detailAccommodation(Long id) {
    Accommodation accommodation = accommodationRepository.findById(id)
        .orElseThrow(NoSuchElementException::new);
    return new DetailAccommodationView(accommodation);
  }
}
