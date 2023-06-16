package com.swus.polyhack_echo.db.dao;

import com.swus.polyhack_echo.db.domain.NewsEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface NewsRepository extends JpaRepository<NewsEntity, Long> {
    Optional<NewsEntity> findByUrl(String url);

    boolean existsByUrl(String url);

    List<NewsEntity> findTop10ByIsTopOrderByPublishedAtDesc(boolean is_top);

    Optional<NewsEntity> findTopOrderByPublishedAtDesc();

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "UPDATE NewsEntity n SET n.isTop = :isTop WHERE n.id = :id")
    void updateIsTop(@Param("isTop") boolean isTop, @Param("id") Long id);

}
