package org.example.backendjava.auth_service.service;

import org.example.backendjava.auth_service.model.dto.DoctorResumeDto;
import org.example.backendjava.auth_service.model.entity.Doctor;
import org.example.backendjava.auth_service.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    public DoctorResumeDto getDoctorResume(Long doctorId) {
        Doctor doctor = doctorRepository.findById(doctorId).orElseThrow();
        DoctorResumeDto dto = new DoctorResumeDto();
        dto.setId(doctor.getId());
        dto.setUsername(doctor.getUser().getUsername());
        dto.setSpecialization(doctor.getSpecialization());
        dto.setPhoneNumber(doctor.getPhoneNumber());
        dto.setBirthDate(doctor.getBirthDate());
        dto.setExperienceYears(doctor.getExperienceYears());
        dto.setPhotoUrl(doctor.getPhotoUrl());
        dto.setEducationDescription(doctor.getEducationDescription());
        dto.setDiplomaPhotoUrl(doctor.getDiplomaPhotoUrl());
        dto.setAdditionalInfo(doctor.getAdditionalInfo());
        return dto;
    }
}