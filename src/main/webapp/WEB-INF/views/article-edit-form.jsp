<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Edit Article</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .author-badge {
            display: inline-flex;
            align-items: center;
            background-color: #e9ecef;
            border-radius: 20px;
            padding: 5px 10px;
            margin: 4px 4px 0 0;
        }
        .author-badge button {
            margin-left: 8px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card p-4">
        <h3 class="text-center mb-4">✏️ Edit Article</h3>

        <form:form method="POST" action="/articles/update" modelAttribute="article" enctype="multipart/form-data">
            <form:hidden path="id"/>

            <div class="form-group">
                <label><strong>Title</strong></label>
                <form:input path="title" cssClass="form-control"/>
                <form:errors path="title" cssClass="text-danger"/>
            </div>

            <div class="form-group">
                <label><strong>Description</strong></label>
                <form:textarea path="description" cssClass="form-control" rows="4"/>
                <form:errors path="description" cssClass="text-danger"/>
            </div>

            <div class="form-group">
                <label><strong>Publish Date</strong></label>
                <form:input path="publishDate" cssClass="form-control" type="date"/>
                <form:errors path="publishDate" cssClass="text-danger"/>
            </div>

            <div class="form-group">
                <label><strong>Selected Authors</strong></label>
                <div id="selected-authors">
                    <c:forEach var="author" items="${article.authors}">
                        <div class="author-badge" id="selected-author-${author.id}">
                            <input type="hidden" name="authors" value="${author.id}" id="author-${author.id}"/>
                            <span>${author.name}</span>
                            <button type="button" class="btn btn-sm btn-danger py-0 px-2 ml-2"
                                    onclick="removeAuthor(${author.id})">&times;</button>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="form-group">
                <label><strong>Banner Image</strong></label><br/>
                <input type="file" name="banner" class="form-control-file"/>

                <c:if test="${not empty article.bannerPath}">
                    <img src="${article.bannerPath}" alt="Banner" class="img-thumbnail mt-2" style="max-height: 200px;">
                </c:if>

                <c:if test="${not empty fileError}">
                    <p class="text-danger">${fileError}</p>
                </c:if>
            </div>

            <div class="form-group d-flex justify-content-between">
                <a href="/articles/list" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Cancel
                </a>
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i> Update
                </button>
            </div>
        </form:form>
    </div>
</div>

<!-- Font Awesome for icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<!-- JavaScript for author add/remove -->
<script>
    function removeAuthor(authorId) {
        const hiddenInput = document.getElementById('author-' + authorId);
        if (hiddenInput) hiddenInput.remove();

        const displayDiv = document.getElementById('selected-author-' + authorId);
        if (displayDiv) displayDiv.remove();
    }
</script>
</body>
</html>
