package com.swus.polyhack_echo.util;

import lombok.extern.slf4j.Slf4j;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@Slf4j
public class CrawlingProvider {
    private String formatText(Element element) {
        StringBuilder formattedText = new StringBuilder();

        for (Element child : element.children()) {
            formattedText.append(child.text()).append("\n");
            formattedText.append(formatText(child));
        }

        return formattedText.toString();
    }

    private String getDataList(Document doc, String query) {
        Elements selects = doc.select(query);
        String formattedText = null;

        if (selects.size() == 1) {
            formattedText = formatText(selects.get(0));
        }

        return formattedText;
    }

    public String getNewsContent(String url, String query) throws IOException {
        Connection conn = Jsoup.connect(url);

        Document doc = null;
        doc = conn.get();

        return getDataList(doc, query);
    }


}
