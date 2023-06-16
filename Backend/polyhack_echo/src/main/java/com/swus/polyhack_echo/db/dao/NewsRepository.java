package com.swus.polyhack_echo.db.dao;

import com.swus.polyhack_echo.db.domain.NewsEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface NewsRepository extends JpaRepository<NewsEntity, Long> {
    Optional<NewsEntity> findByUrl(String url);

    boolean existsByUrl(String url);

    Optional<NewsEntity> findTopByIsTopTrueOrderByPublishedAtDesc();

    Optional<NewsEntity> findTopByOrderByPublishedAtDesc();

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "UPDATE NewsEntity n SET n.isTop = :isTop WHERE n.id = :id")
    void updateIsTop(@Param("isTop") boolean isTop, @Param("id") Long id);

}
