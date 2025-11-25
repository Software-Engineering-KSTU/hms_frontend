package org.example.backendjava.auth_service.controller;

import org.example.backendjava.auth_service.model.dto.DoctorResumeDto;
import org.example.backendjava.auth_service.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/doctors")
public class DoctorController {

    @Autowired
    private DoctorService doctorService;

    @GetMapping("/{id}/resume")
    public ResponseEntity<DoctorResumeDto> getResume(@PathVariable Long id) {
        return ResponseEntity.ok(doctorService.getDoctorResume(id));
    }
}