package com.swus.polyhack_echo.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.swus.polyhack_echo.dto.TopicResponseDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Component
@Slf4j
public class TopicProvider {
    private final String API_URL = System.getenv("AI_API_BASE_URL") + "/topic";

    public TopicResponseDto getTopicWords(String content) throws JsonProcessingException {

        // header
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.TEXT_PLAIN);

        // body
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("text", content);

        // HTTP request entity
        HttpEntity<String> requestEntity = new HttpEntity<>(body.getFirst("text"), headers);

        // post
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(API_URL, HttpMethod.POST, requestEntity, String.class);

        if (response.getStatusCode().is2xxSuccessful()) {
            String res = response.getBody();
            TopicResponseDto topicResponseDto = new TopicResponseDto(res);

            return topicResponseDto;
        } else {
            log.error("[ " + API_URL + " ]" + " Request failed.");

            return null;
        }
    }
}
