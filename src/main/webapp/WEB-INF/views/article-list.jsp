<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Article List</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body {
            padding: 30px;
            background-color: #f8f9fa;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .action-btns a {
            margin-right: 8px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h2 {
            margin: 0;
        }

        img.banner-img {
            max-width: 100px;
            height: auto;
        }
    </style>
</head>
<body>

<div class="container">

    <div class="header">
        <h2>Article List</h2>
        <a href="/articles/new" class="btn btn-success">+ Add New Article</a>
    </div>

    <c:if test="${empty articles}">
        <div class="alert alert-warning">No articles found.</div>
    </c:if>

    <c:if test="${not empty articles}">
        <table class="table table-bordered table-striped table-hover">
            <thead class="thead-dark">
            <tr>
                <th>#</th>
                <th>Title</th>
                <th>Banner</th>
                <th>Status</th>
                <th>Authors</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="article" items="${articles}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${article.title}</td>
                    <td>
                        <c:if test="${not empty article.bannerPath}">
                            <img src="${article.bannerPath}" alt="Banner" class="banner-img"/>
                        </c:if>
                        <c:if test="${empty article.bannerPath}">
                            No image
                        </c:if>
                    </td>
                    <td>${article.status}</td>
                    <td>
                        <c:forEach var="author" items="${article.authors}">
                            ${author.name}<br/>
                        </c:forEach>
                    </td>
                    <td class="action-btns">
                        <a href="/articles/view/${article.id}" class="btn btn-info btn-sm">View</a>
                        <a href="/articles/edit/${article.id}" class="btn btn-warning btn-sm">Edit</a>
                        <a href="/articles/delete/${article.id}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this article?');">
                            Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>

</body>
</html>
