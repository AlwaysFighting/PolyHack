package com.swus.polyhack_echo.controller;

import com.swus.polyhack_echo.dto.NewsItemDto;
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
        return ResponseEntity.ok(ResponseDto.of(200));
    }

    // Get list of personalized news data
    @GetMapping("/opp")
    public ResponseEntity<ResponseDto> getOppNews() {
        return ResponseEntity.ok(ResponseDto.of(200));
    }

    // Get detail data of article
    @GetMapping("/detail/{news_id}")
    public ResponseEntity<ResponseDto> getDetail(@PathVariable Long news_id) {
        return ResponseEntity.ok(ResponseDto.of(200));
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
