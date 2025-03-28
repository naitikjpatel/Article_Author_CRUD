<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Author List</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

	<div class="container mt-5">
		<div class="d-flex justify-content-between align-items-center mb-3">
			<h2 class="text-primary">All Authors</h2>
			<a href="/authors/new" class="btn btn-success">Add New Author</a>
		</div>

		<div class="table-responsive">
			<table
				class="table table-bordered table-striped table-hover align-middle">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Articles</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="author" items="${authors}">
						<tr>
							<td>${author.id}</td>
							<td>${author.name}</td>
							<td>
								<ul class="list-unstyled mb-0">
									<c:forEach var="article" items="${author.articles}">
										<li class="d-flex align-items-start mb-1"><span
											class="badge bg-primary me-2">${article.title}</span></li>
									</c:forEach>
								</ul>
							</td>

							<td><a href="/authors/edit/${author.id}"
								class="btn btn-sm btn-warning">Edit</a> <a
								href="/authors/delete/${author.id}"
								class="btn btn-sm btn-danger"
								onclick="return confirm('Are you sure?')">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Bootstrap JS (Optional) -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
