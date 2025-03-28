<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Author Form</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Add / Edit Author</h4>
        </div>
        <div class="card-body">
            <form:form method="post" modelAttribute="author" action="/authors/save">
                <form:hidden path="id" />

                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <form:input path="name" cssClass="form-control" />
                    <form:errors path="name" cssClass="text-danger small" />
                </div>

                <button type="submit" class="btn btn-success">Save Author</button>
                <a href="/authors/list" class="btn btn-secondary">Back to List</a>
            </form:form>
        </div>
    </div>
</div>

<!-- Bootstrap JS CDN (optional, for enhanced interactivity) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
