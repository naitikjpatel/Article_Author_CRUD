<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page import="java.time.LocalDate" %>
<%
    LocalDate tomorrow = LocalDate.now().plusDays(1);
%>

<html>
<head>
    <title>Add New Article</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>

    <!-- Bootstrap Select CSS -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css"/>

    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            max-width: 800px;
            margin-top: 40px;
            padding: 30px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .error {
            color: red;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Add New Article</h2>

    <form:form action="/articles/save" modelAttribute="article" method="post" enctype="multipart/form-data">
        

        <div class="form-group">
            <label>Title</label>
            <form:input path="title" cssClass="form-control"/>
            <form:errors path="title" cssClass="error"/>
        </div>

        <div class="form-group">
            <label>Description</label>
            <form:textarea path="description" cssClass="form-control" rows="4"/>
            <form:errors path="description" cssClass="error"/>
        </div>

        <div class="form-group">
            <label>Publish Date</label>
           <form:input path="publishDate" cssClass="form-control"
                type="date"
                value="${article.publishDate}"
                min="<%= tomorrow.toString() %>" />
    <form:errors path="publishDate" cssClass="text-danger"/>
        </div>

        <div class="form-group">
            <label>Banner Image</label>
            <input type="file" name="banner" class="form-control-file"/>
            <c:if test="${fileError != null}">
                <span class="error">${fileError}</span>
            </c:if>
        </div>

        <div class="form-group">
            <label>Authors</label>
            <form:select path="authors" multiple="true" cssClass="form-control selectpicker" data-live-search="true"
                         data-style="btn-outline-primary">
                <form:options items="${authors}" itemValue="id" itemLabel="name"/>
            </form:select>
            <form:errors path="authors" cssClass="error"/>
        </div>

        <div class="form-group text-right">
            <a href="/articles/list" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-success">Save Article</button>
        </div>
    </form:form>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>


<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js"></script>
</body>
</html>
