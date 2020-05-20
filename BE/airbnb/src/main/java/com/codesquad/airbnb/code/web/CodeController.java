package com.codesquad.airbnb.code.web;

import com.codesquad.airbnb.accmmodation.data.type.AccommodationType;
import com.codesquad.airbnb.accmmodation.data.type.ImageType;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "dev")
@RequiredArgsConstructor
@RequestMapping("/dev-api/")
@RestController
public class CodeController {

  @ApiOperation(value = "Code 값을 가져옵니다")
  @GetMapping
  public Enum[] accommodation(@RequestParam String type) {
    if (type.equals("image")) {
      return ImageType.values();
    }

    if (type.equals("accommodation")) {
      return AccommodationType.values();
    }

    throw new RuntimeException("올바르지 않은 입력 값 입니다");
  }
}
