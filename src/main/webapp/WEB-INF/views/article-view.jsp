<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>View Article</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            background-color: #f5f6f8;
            padding: 40px 15px;
            font-family: 'Segoe UI', sans-serif;
            color: #2c3e50;
        }

        .article-container {
            max-width: 1100px;
            margin: auto;
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: transform 0.2s ease;
        }

        .article-container:hover {
            transform: translateY(-5px);
        }

        .banner-img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            border-bottom: 4px solid #3498db;
        }

        .content-wrapper {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            padding: 30px;
        }

        .sidebar {
            padding: 20px;
            background: rgba(245, 246, 248, 0.7);
            border-right: 1px solid rgba(238, 238, 238, 0.5);
        }

        .main-content {
            padding: 20px;
        }

        .section-title {
            font-weight: 700;
            color: #2980b9;
            margin-bottom: 20px;
            font-size: 1.2rem;
            position: relative;
            padding-bottom: 8px;
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 2px;
            background: #3498db;
        }

        .meta-info {
            color: #7f8c8d;
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .badge-status {
            font-size: 0.85rem;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .authors-list {
            padding: 0;
            list-style: none;
            margin: 0;
        }

        .authors-list li {
            padding: 12px 0;
            border-bottom: 1px dashed #eee;
            display: flex;
            align-items: center;
            transition: color 0.3s ease;
        }

        .authors-list li:hover {
            color: #3498db;
        }

        .authors-list li:before {
            content: '\f007';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            margin-right: 10px;
            color: #3498db;
        }

        .article-title {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 25px;
            line-height: 1.3;
        }

        .description {
            font-size: 1.05rem;
            line-height: 1.8;
            color: #34495e;
        }

        .back-btn {
            margin-top: 25px;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
            transform: translateX(-5px);
        }

        @media (max-width: 768px) {
            .content-wrapper {
                grid-template-columns: 1fr;
            }
            
            .sidebar {
                border-right: none;
                border-bottom: 1px solid rgba(238, 238, 238, 0.5);
            }
        }
    </style>
</head>
<body>

<div class="article-container">
    <c:if test="${not empty article.bannerPath}">
        <img src="${article.bannerPath}" alt="Banner Image" class="banner-img">
    </c:if>

    <div class="content-wrapper">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="meta-section">
                <div class="section-title">Article Info</div>
                <div class="meta-info">
                    <strong>Publish Date:</strong> ${article.publishDate}<br/>
                    <strong>Status:</strong>
                    <span class="badge badge-status badge-${article.status == 'PUBLISHED' ? 'success' : 'secondary'}">
                        ${article.status}
                    </span>
                </div>
            </div>

            <div class="authors-section">
                <div class="section-title">Authors</div>
                <ul class="authors-list">
                    <c:forEach var="author" items="${article.authors}">
                        <li>${author.name}</li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="section-title">Title</div>
            <h2 class="article-title">${article.title}</h2>

            <div class="section-title">Description</div>
            <p class="description">${article.description}</p>

            <a href="/articles/list" class="btn btn-outline-primary back-btn">← Back to Articles</a>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>