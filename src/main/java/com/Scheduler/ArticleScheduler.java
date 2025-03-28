package com.Scheduler;

import com.Entity.Article;
import com.Repository.ArticleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
@RequiredArgsConstructor
@Slf4j
public class ArticleScheduler {

	@Autowired
    private ArticleRepository articleRepo;

    
    @Scheduled(cron = "0 0 0 * * ?")
    public void publishScheduledArticles() {
        log.info("Running article publish scheduler at 12:00 AM");

        LocalDate today = LocalDate.now();

        List<Article> articles = articleRepo.findAll();

        for (Article article : articles) {
            if ("DRAFT".equalsIgnoreCase(article.getStatus()) &&
                article.getPublishDate() != null &&
                article.getPublishDate().isEqual(today)) {

                article.setStatus("PUBLISHED");
                articleRepo.save(article);
                log.info("Published article: {}", article.getTitle());
            }
        }
    }
}
