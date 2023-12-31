package com.swus.polyhack_echo.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.swus.polyhack_echo.dto.NewsDetailDto;
import com.swus.polyhack_echo.dto.NewsItemDto;
import com.swus.polyhack_echo.dto.TopicResponseDto;
import com.swus.polyhack_echo.dto.response.DataResponseDto;
import com.swus.polyhack_echo.dto.response.ResponseDto;
import com.swus.polyhack_echo.service.NewsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/news")
public class NewsController {
    private final NewsService newsService;

    @Autowired
    public NewsController(NewsService newsService) {
        this.newsService = newsService;
    }

    // Get entire list of news data
    @GetMapping()
    public ResponseEntity<ResponseDto> getAll() {
        List<NewsItemDto> data;
        try {
            data = newsService.getAllService();

            if (data.size() == 0) {
                log.error("News data update error.");
                return ResponseEntity.status(404).body(ResponseDto.of(404, "Data not found."));
            }

            return ResponseEntity.ok(DataResponseDto.of(data, 200));
        } catch (Exception e) {
            log.error(e.getMessage());

            return ResponseEntity.internalServerError().body(ResponseDto.of(500));
        }
    }

    // Get list of topic words // * Get list of personalized news data (incomplete)
    @GetMapping(value = "/opp/{news_id}")
    public ResponseEntity<ResponseDto> getOppNews(@PathVariable Long news_id) throws JsonProcessingException {
        TopicResponseDto data = null;
        try {
            data = newsService.getOppNewsService(news_id);

            if (data == null) {
                return ResponseEntity.badRequest().body(ResponseDto.of(400, "Invalid news id."));
            }

            return ResponseEntity.ok(DataResponseDto.of(data, 200));
        } catch (Exception e) {
            log.error(e.getMessage());

            return ResponseEntity.internalServerError().body(ResponseDto.of(500));
        }
    }

    // Get detail data of article
    @GetMapping("/detail/{news_id}")
    public ResponseEntity<ResponseDto> getDetail(@PathVariable Long news_id) {
        NewsDetailDto data = null;
        try {
            data = newsService.getDetail(news_id);

            if (data == null) {
                return ResponseEntity.badRequest().body(ResponseDto.of(400, "Invalid news id."));
            }

            return ResponseEntity.ok(DataResponseDto.of(data, 200));
        } catch (Exception e) {
            log.error(e.getMessage());

            return ResponseEntity.internalServerError().body(ResponseDto.of(500));
        }
    }

    // Get top headline
    @GetMapping("/top")
    public ResponseEntity<ResponseDto> getTopHeadline() {
        try {
            NewsItemDto data = newsService.getTopHeadlineService();

            if (data == null) {
                return ResponseEntity.status(404).body(ResponseDto.of(404, "Data not found."));
            }

            return ResponseEntity.ok(DataResponseDto.of(data, 200));
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(ResponseDto.of(500));
        }
    }
}
