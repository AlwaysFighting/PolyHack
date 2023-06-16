package com.swus.polyhack_echo.service;

import com.swus.polyhack_echo.db.dao.NewsRepository;
import com.swus.polyhack_echo.db.domain.NewsEntity;
import com.swus.polyhack_echo.dto.NewsItemDto;
import com.swus.polyhack_echo.util.NewsProvider;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class NewsService {
    private final NewsRepository newsRepository;
    private final NewsProvider newsProvider;

    @Autowired
    public NewsService(NewsRepository newsRepository, NewsProvider newsProvider) {
        this.newsRepository = newsRepository;
        this.newsProvider = newsProvider;
    }

    // Get entire list of news data
    public void getAllService() {
    }

    // Get list of personalized news data
    public void getOppNewsService() {

    }

    // Get detail data of article
    public void getDetail() {

    }

    // Get top headline
    public NewsItemDto getTopHeadlineService() throws InternalError {
        NewsEntity headline = newsRepository.findTopByIsTopTrueOrderByPublishedAtDesc().orElse(null);

        if (headline == null) {
            return null;
        }

        return new NewsItemDto(headline);
    }
}
