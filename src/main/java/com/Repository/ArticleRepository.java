package com.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Entity.Article;

public interface ArticleRepository extends JpaRepository<Article, Long> {
}