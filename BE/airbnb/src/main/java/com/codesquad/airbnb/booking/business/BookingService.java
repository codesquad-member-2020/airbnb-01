package com.codesquad.airbnb.booking.business;

import com.codesquad.airbnb.accmmodation.data.Accommodation;
import com.codesquad.airbnb.accmmodation.data.AccommodationRepository;
import com.codesquad.airbnb.booking.data.Booking;
import com.codesquad.airbnb.booking.data.BookingRepository;
import com.codesquad.airbnb.booking.web.model.BookingCommand;
import com.codesquad.airbnb.booking.web.model.BookingView;
import com.codesquad.airbnb.user.data.User;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class BookingService {

  private final BookingRepository bookingRepository;
  private final AccommodationRepository accommodationRepository;

  public BookingView booking(BookingCommand command) {
    User user = User.builder().email("anonymous@gmail.com").build();
    Accommodation accommodation = accommodationRepository.findById(command.getAccommodationId())
        .orElseThrow(NoSuchElementException::new);
    Booking booking = Booking.builder()
        .user(user)
        .accommodation(accommodation)
        .command(command)
        .build();

    Booking savedBooking = bookingRepository.save(booking);

    return BookingView.builder()
        .booking(savedBooking)
        .build();
  }
}
