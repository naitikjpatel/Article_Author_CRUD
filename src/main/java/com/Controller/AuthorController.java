package com.Controller;

import com.Entity.Author;
import com.Repository.AuthorRepository;
import com.Service.EmailService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/authors")
public class AuthorController {

    @Autowired
    private AuthorRepository authorRepository;

    @Autowired
    private EmailService emailService;

    private final Logger logger = LoggerFactory.getLogger(AuthorController.class);

    @GetMapping("/new")
    public String showForm(Model model) {
        logger.info("Accessed author form");
        model.addAttribute("author", new Author());
        return "author-form";
    }

    @PostMapping("/save")
    public String save(@Valid @ModelAttribute("author") Author author,
                       BindingResult bindingResult) {
        logger.info("Saving author: {}", author.getName());

        if (bindingResult.hasErrors()) {
            logger.warn("Validation failed for author: {}", bindingResult.getAllErrors());
            return "author-form";
        }

        try {
            authorRepository.save(author);
            logger.info("Author saved: {}", author.getName());

            emailService.sendNotification(
                    "Author Saved: " + author.getName(),
                    "Author \"" + author.getName() + "\" was successfully saved/updated."
            );

        } catch (Exception e) {
            logger.error("Failed to save author: {}", author.getName(), e);

            emailService.sendNotification(
                    "Error Saving Author",
                    "Error occurred while saving author \"" + author.getName() + "\": " + e.getMessage()
            );
        }

        return "redirect:/authors/list";
    }

    @GetMapping("/list")
    public String list(Model model) {
        logger.info("Listing all authors");
        model.addAttribute("authors", authorRepository.findAll());
        return "author-list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        logger.info("Editing author with ID: {}", id);
        Author author = authorRepository.findById(id)
                .orElseThrow(() -> {
                    logger.error("Author not found with ID: {}", id);

                    emailService.sendNotification(
                            "Author Not Found",
                            "Attempted to edit author with ID " + id + ", but not found."
                    );

                    return new RuntimeException("Author not found");
                });

        model.addAttribute("author", author);
        return "author-form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        logger.info("Deleting author with ID: {}", id);
        authorRepository.deleteById(id);
        logger.info("Author deleted successfully");

        emailService.sendNotification(
                "Author Deleted",
                "Author with ID " + id + " has been deleted from the system."
        );

        return "redirect:/authors/list";
    }
}
