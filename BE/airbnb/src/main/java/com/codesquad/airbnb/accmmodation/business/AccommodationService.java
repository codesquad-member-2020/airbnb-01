package com.codesquad.airbnb.accmmodation.business;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AccommodationService {

  private final AccommodationRepository accommodationRepository;

  public List<Accommodation> accommodation() {
    return accommodationRepository.findAll();
  }
}
