package com.swus.polyhack_echo.db.dao;

import com.swus.polyhack_echo.db.domain.NewsEntity;
import com.swus.polyhack_echo.db.domain.RelatedNewsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RelatedNewsRepository extends JpaRepository<RelatedNewsEntity, Long> {
    List<RelatedNewsEntity> findAllByNews(NewsEntity news);
}
