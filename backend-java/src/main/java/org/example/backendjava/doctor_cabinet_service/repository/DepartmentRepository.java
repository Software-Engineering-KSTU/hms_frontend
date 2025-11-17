package org.example.backendjava.doctor_cabinet_service.repository;

import org.example.backendjava.doctor_cabinet_service.model.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DepartmentRepository extends JpaRepository<Department, Long> {
}
