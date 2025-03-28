package com.Repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.Entity.Author;

public interface AuthorRepository extends JpaRepository<Author, Long> {
}
