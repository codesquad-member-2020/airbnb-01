package com.codesquad.airbnb.accmmodation.business;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import com.codesquad.airbnb.accmmodation.data.Price;
import com.codesquad.airbnb.accmmodation.web.AccommodationQuery;
import com.codesquad.airbnb.accmmodation.web.AccommodationView;
import com.codesquad.airbnb.accmmodation.web.DetailAccommodationView;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AccommodationService {

  private final AccommodationRepository accommodationRepository;

  public List<AccommodationView> accommodation(AccommodationQuery query) {
    query.makeFormed();

    Price minPrice = Price.builder().price(query.getPriceMin()).build();
    Price maxPrice = Price.builder().price(query.getPriceMax()).build();
    final int PAGE_ROW_COUNT = 10;
    PageRequest requestPage = PageRequest.of(query.getPageCount(), PAGE_ROW_COUNT);

    Page<Accommodation> accommodations =
        accommodationRepository.findByLocationContainingAndPriceBetween(
            query.getLocation(), minPrice, maxPrice, requestPage);
    return accommodations.stream().map(AccommodationView::new).collect(Collectors.toList());
  }

  public DetailAccommodationView detailAccommodation(Long id) {
    Accommodation accommodation = accommodationRepository.findById(id)
        .orElseThrow(NoSuchElementException::new);
    return new DetailAccommodationView(accommodation);
  }
}
