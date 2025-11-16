package org.example.backendjava.booking_to_doctore_service.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class AppointmentRequestDto {
    private Long doctorId;
    private Long patientId;
    private LocalDateTime dateTime;
}
