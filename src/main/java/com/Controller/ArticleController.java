package com.Controller;

import com.Entity.Article;
import com.Repository.ArticleRepository;
import com.Repository.AuthorRepository;
import com.Service.EmailService;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import jakarta.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/articles")
public class ArticleController {

    private static final Logger logger = LoggerFactory.getLogger(ArticleController.class);

    @Autowired
    private ArticleRepository articleRepo;

    @Autowired
    private AuthorRepository authorRepo;

    @Autowired
    private Cloudinary cloudinary;

    @Autowired
    private EmailService emailService;

    // open article-form
    @GetMapping("/new")
    public String showForm(Model model) {
        logger.info("Accessed article creation form");
        model.addAttribute("article", new Article());
        model.addAttribute("authors", authorRepo.findAll());
        return "article-form";
    }

    //add new article
    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("article") Article article,
                       BindingResult bindingResult,
                       @RequestParam("banner") MultipartFile bannerFile,
                       Model model) {
        logger.info("Attempting to save a new article: {}", article.getTitle());

        if (bindingResult.hasErrors()) {
            logger.warn("Validation failed for article: {}", article.getTitle());
            model.addAttribute("authors", authorRepo.findAll());
            return "article-form";
        }

        try {
            if (!bannerFile.isEmpty()) {
                Map<?, ?> result = cloudinary.uploader().upload(bannerFile.getBytes(), ObjectUtils.emptyMap());
                String imageUrl = result.get("secure_url").toString();
                article.setBannerPath(imageUrl);
                logger.info("Uploaded banner image for article: {}", imageUrl);
            }

            article.setStatus("DRAFT");
            articleRepo.save(article);
            logger.info("Article saved: {}", article.getTitle());

            emailService.sendNotification(
                    "Article Created: " + article.getTitle(),
                    "A new article titled \"" + article.getTitle() + "\" was successfully created."
            );

            return "redirect:/articles/list";

        } catch (IOException e) {
            logger.error("Error while uploading banner image: {}", e.getMessage(), e);
            model.addAttribute("fileError", "Failed to upload image: " + e.getMessage());
            model.addAttribute("authors", authorRepo.findAll());

            emailService.sendNotification(
                    "Error while creating article",
                    "Error occurred while uploading banner for \"" + article.getTitle() + "\": " + e.getMessage()
            );

            return "article-form";
        } catch (Exception e) {
            logger.error("Unexpected error while saving article: {}", e.getMessage(), e);
            model.addAttribute("error", "An unexpected error occurred.");
            return "article-form";
        }
    }

    // ========== READ ==========
    @GetMapping(value = {"/", "/list"})
    public String list(Model model) {
        logger.info("Fetching article list");
        model.addAttribute("articles", articleRepo.findAll());
        return "article-list";
    }

    @GetMapping("/view/{id}")
    public String viewArticle(@PathVariable Long id, Model model) {
        logger.info("Viewing article with ID: {}", id);
        Optional<Article> optionalArticle = articleRepo.findById(id);
        if (optionalArticle.isPresent()) {
            model.addAttribute("article", optionalArticle.get());
            return "article-view";
        } else {
            logger.warn("Article not found with ID: {}", id);
            return "redirect:/articles/list";
        }
    }

    // ========== UPDATE ==========
    @GetMapping("/edit/{id}")
    public String editArticle(@PathVariable("id") Long id, Model model) {
        logger.info("Editing article with ID: {}", id);
        Article article = articleRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Article not found with ID: " + id));
        model.addAttribute("article", article);
        model.addAttribute("authors", authorRepo.findAll());
        return "article-edit-form";
    }

    @PostMapping("/update")
    public String updateArticle(@Valid @ModelAttribute("article") Article article,
                                BindingResult bindingResult,
                                @RequestParam("banner") MultipartFile bannerFile,
                                Model model) {
        logger.info("Updating article with ID: {}", article.getId());

        if (bindingResult.hasErrors()) {
            logger.warn("Validation errors while updating article: {}", article.getTitle());
            model.addAttribute("authors", authorRepo.findAll());
            return "article-edit-form";
        }

        try {
            Article existingArticle = articleRepo.findById(article.getId())
                    .orElseThrow(() -> new RuntimeException("Article not found with ID: " + article.getId()));

            existingArticle.setTitle(article.getTitle());
            existingArticle.setDescription(article.getDescription());
            existingArticle.setPublishDate(article.getPublishDate());
            existingArticle.setAuthors(article.getAuthors());

            if (!bannerFile.isEmpty()) {
                Map<?, ?> uploadResult = cloudinary.uploader().upload(bannerFile.getBytes(), ObjectUtils.emptyMap());
                existingArticle.setBannerPath(uploadResult.get("secure_url").toString());
                logger.info("Updated banner for article: {}", existingArticle.getTitle());
            }

            articleRepo.save(existingArticle);
            logger.info("Article updated successfully: {}", existingArticle.getTitle());

            emailService.sendNotification(
                    "Article Updated: " + existingArticle.getTitle(),
                    "The article titled \"" + existingArticle.getTitle() + "\" was updated."
            );

            return "redirect:/articles/list";

        } catch (IOException e) {
            logger.error("Error while updating banner image: {}", e.getMessage(), e);
            model.addAttribute("fileError", "Failed to upload image: " + e.getMessage());
            model.addAttribute("authors", authorRepo.findAll());
            return "article-edit-form";
        } catch (Exception e) {
            logger.error("Unexpected error while updating article: {}", e.getMessage(), e);
            model.addAttribute("error", "An unexpected error occurred.");
            return "article-edit-form";
        }
    }

    // ========== DELETE ==========
    @GetMapping("/delete/{id}")
    public String deleteArticle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        logger.info("Attempting to delete article with ID: {}", id);
        try {
            if (articleRepo.existsById(id)) {
                articleRepo.deleteById(id);
                logger.info("Article deleted with ID: {}", id);
                redirectAttributes.addFlashAttribute("message", "Article deleted successfully!");

                emailService.sendNotification(
                        "Article Deleted",
                        "Article with ID " + id + " has been deleted."
                );
            } else {
                logger.warn("Article not found for deletion with ID: {}", id);
                redirectAttributes.addFlashAttribute("error", "Article not found!");
            }
        } catch (Exception e) {
            logger.error("Error deleting article with ID {}: {}", id, e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "An error occurred while deleting the article.");
        }

        return "redirect:/articles/list";
    }
}
