package org.example.backendjava.auth_service.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DoctorResumeDto {

    private Long id;

    private String username;

    private String specialization;

    private String phoneNumber;

    private LocalDate birthDate;

    private Integer experienceYears;

    private String photoUrl;

    private String educationDescription;

    private String diplomaPhotoUrl;

    private String additionalInfo;
}