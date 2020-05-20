package com.codesquad.airbnb.accmmodation.business;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import java.util.List;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AccommodationService {

  private final AccommodationRepository accommodationRepository;

  public List<Accommodation> accommodation() {
    return accommodationRepository.findAll();

  }

  public Accommodation detailAccommodation(Long id) {
    return accommodationRepository.findById(id).orElseThrow(NoSuchElementException::new);
  }
}
