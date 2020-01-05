package io.github.choudharyhimanshu.whiteapp.controller;

import io.github.choudharyhimanshu.whiteapp.constant.AppConstants;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(AppConstants.ROUTE_HEALTH_CHECK_BASE)
public class HealthCheckController {

    @GetMapping()
    @ResponseBody
    public ResponseEntity<String> getHealthStatus() {
        return new ResponseEntity(AppConstants.MESSAGE_HEALTHCHECK, HttpStatus.OK);
    }

}
