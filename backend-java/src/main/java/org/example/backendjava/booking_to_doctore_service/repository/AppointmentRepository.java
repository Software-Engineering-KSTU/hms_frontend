package org.example.backendjava.booking_to_doctore_service.repository;

import org.example.backendjava.booking_to_doctore_service.model.entity.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    List<Appointment> findByDoctorId(Long doctorId);

    List<Appointment> findByPatientId(Long patientId);

    boolean existsByDoctorIdAndDateTime(Long doctorId, LocalDateTime dateTime);
}
