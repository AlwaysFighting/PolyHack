package com.swus.polyhack_echo.service;

import com.swus.polyhack_echo.db.dao.NewsRepository;
import com.swus.polyhack_echo.db.domain.NewsEntity;
import com.swus.polyhack_echo.dto.NewsDetailDto;
import com.swus.polyhack_echo.dto.NewsItemDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class NewsService {
    private final NewsRepository newsRepository;

    @Autowired
    public NewsService(NewsRepository newsRepository) {
        this.newsRepository = newsRepository;
    }

    // Get entire list of news data
    public List<NewsItemDto> getAllService() throws Exception {
        List<NewsItemDto> result = new ArrayList<>();
        List<NewsEntity> articles = newsRepository.findAllByOrderByPublishedAtDesc();

        for (NewsEntity news : articles) {
            NewsItemDto newsItemDto = new NewsItemDto(news);

            result.add(newsItemDto);
        }

        return result;
    }

    // Get list of personalized news data
    public void getOppNewsService() {
        // API connecting needed after AI part developed
        String URL = System.getenv("AI_API_BASE_URL");
    }

    // Get detail data of article
    public NewsDetailDto getDetail(Long news_id) throws Exception {
        NewsDetailDto newsDetailDto = null;
        NewsEntity newsEntity = newsRepository.findById(news_id).orElse(null);

        if (newsEntity != null) {
            newsDetailDto = new NewsDetailDto(newsEntity);
        }

        return newsDetailDto;
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
