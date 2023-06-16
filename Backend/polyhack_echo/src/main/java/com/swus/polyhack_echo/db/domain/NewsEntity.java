package com.swus.polyhack_echo.db.domain;

import com.kwabenaberko.newsapilib.models.Article;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicInsert;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "News")
@DynamicInsert
public class NewsEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    @Column(columnDefinition = "TEXT")
    private String content;
    private String source;
    private LocalDateTime publishedAt;
    private String author;
    private String url;
    private String image_url;
    private boolean isTop;
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Builder
    public NewsEntity(Article article, String content) {
        this.title = article.getTitle();
        this.source = article.getSource().getName();
        this.publishedAt = LocalDateTime.parse(article.getPublishedAt().replace("Z", ""));
        this.author = article.getAuthor();
        this.url = article.getUrl();
        this.image_url = article.getUrlToImage();
        this.content = content;
        isTop = false;
    }

    public NewsEntity(Article article, String content, boolean isTop) {
        this.title = article.getTitle();
        this.source = article.getSource().getName();
        this.publishedAt = LocalDateTime.parse(article.getPublishedAt().replace("Z", ""));
        this.author = article.getAuthor();
        this.url = article.getUrl();
        this.image_url = article.getUrlToImage();
        this.content = content;
        this.isTop = isTop;
    }
}