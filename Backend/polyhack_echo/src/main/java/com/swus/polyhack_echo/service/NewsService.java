package com.swus.polyhack_echo.service;

import com.swus.polyhack_echo.db.dao.NewsRepository;
import com.swus.polyhack_echo.db.domain.NewsEntity;
import com.swus.polyhack_echo.dto.NewsDetailDto;
import com.swus.polyhack_echo.dto.NewsItemDto;
import com.swus.polyhack_echo.dto.TopicResponseDto;
import com.swus.polyhack_echo.util.TopicProvider;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class NewsService {
    private final NewsRepository newsRepository;
    private final TopicProvider topicProvider;

    @Autowired
    public NewsService(NewsRepository newsRepository, TopicProvider topicProvider) {
        this.newsRepository = newsRepository;
        this.topicProvider = topicProvider;
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
    public TopicResponseDto getOppNewsService(Long news_id) throws Exception {
        NewsEntity newsEntity = newsRepository.findById(news_id).orElse(null);

        if (newsEntity == null) {
            throw new Exception("Invalid news id.");
        }

        TopicResponseDto topicResponseDto = null;
        String content = newsEntity.getContent();

        if (content != null) {
            topicResponseDto = topicProvider.getTopicWords(content);
        }

        return topicResponseDto;
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
