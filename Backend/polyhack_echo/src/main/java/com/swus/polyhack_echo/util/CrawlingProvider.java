package com.swus.polyhack_echo.util;

import lombok.extern.slf4j.Slf4j;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@Slf4j
public class CrawlingProvider {
    private String getDataList(Document doc, String query) {
        Elements selects = doc.select(query);

        return selects.size() == 1 ? selects.get(0).text() : null;
    }

    public String getNewsContent(String url, String query) throws IOException {
        Connection conn = Jsoup.connect(url);

        Document doc = null;
        doc = conn.get();

        return getDataList(doc, query);
    }


}
