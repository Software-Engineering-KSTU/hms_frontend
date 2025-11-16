package org.example.backendjava.booking_to_doctore_service.repository;

import org.example.backendjava.booking_to_doctore_service.model.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
}
