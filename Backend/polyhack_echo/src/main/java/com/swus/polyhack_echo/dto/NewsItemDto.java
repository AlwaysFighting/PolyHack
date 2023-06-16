package com.swus.polyhack_echo.dto;

import com.swus.polyhack_echo.db.domain.NewsEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class NewsItemDto {
    private String title;
    private String source;
    private LocalDateTime published_at;
    private String author;
    private String image_url;

    public NewsItemDto(NewsEntity news) {
        this.title = news.getTitle();
        this.source = news.getSource();
        this.published_at = news.getPublishedAt();
        this.author = news.getAuthor();
        this.image_url = news.getImage_url();
    }
}
