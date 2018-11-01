<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- PAGE TITLE -->
<div class="page-title">
	<h2>
		<span class="fa fa-arrow-circle-o-left"></span> Read
	</h2>
</div>
<!-- END PAGE TITLE -->

<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">

	<div class="row">
		<div class="col-md-9">

			<div class="panel panel-default">
				<div class="panel-body posts">

					<div class="post-item">
						<div class="post-title" name="title">
							<c:out value="${board.title}" />
						</div>
						<div class="post-date" name="mid">
							<span class="fa fa-calendar"></span> <c:out value="${board.updatedate}"/> / <a
								href="pages-blog-post.html#comments">3 Comments</a> / <a
								href="pages-profile.html">by <c:out value="${board.mid}"/></a>
						</div>
						<div class="post-text" name="content">
						<c:out value="${board.content}" />
						
						</div>
						
						<form role="form" action="/board/list" method='get'>
								<input type='hidden' name='page' value="${pageObj.page}">
									<button class="btn btn-default">Go List</button>
								</form>
								<form role="form" action="/board/modify" method='get'>
									<input type='hidden' name='page' value="${pageObj.page}">
								  	<input type='hidden' name='bno' value="${pageObj.bno}">
									<button type="submit" class="btn btn-default">Modify</button>
								</form>

					<h3 class="push-down-20">Comments</h3>
					<ul class="media-list">
						<li class="media"><a class="pull-left" href="#"> <img
								class="media-object img-text" src="/resources/assets/images/users/user.jpg"
								alt="Dmitry Ivaniuk" width="64">
						</a>
							<div class="media-body">
								<h4 class="media-heading">Dmitry Ivaniuk</h4>
								<p>Cras sit amet nibh libero, in gravida nulla. Nulla vel
									metus scelerisque ante sollicitudin commodo. Cras purus odio,
									vestibulum in vulputate at, tempus viverra turpis. Fusce
									condimentum nunc ac nisi vulputate fringilla. Donec lacinia
									congue felis in faucibus.</p>
								<p class="text-muted">October 24, 2014, 15:20</p>
								<div class="media">
									<a class="pull-left" href="#"> <img
										class="media-object img-text"
										src="/resources/assets/images/users/user6.jpg" alt="Darh Vader"
										width="64">
									</a>
									<div class="media-body">
										<h4 class="media-heading">Darth Vader</h4>
										<p>What? What did you say? It's not even a language...</p>
										<p class="text-muted">October 24, 2014, 16:20</p>
									</div>
								</div>
							</div></li>
						<li class="media"><a class="pull-left" href="#"> <img
								class="media-object img-text"
								src="/resources/assets/images/users/user7.jpg" alt="Samuel Leroy Jackson"
								width="64">
						</a>
							<div class="media-body">
								<h4 class="media-heading">Samuel Leroy Jackson</h4>
								<p>We happy? Vincent, we happy?</p>
								<p class="text-muted">October 24, 2014, 14:30</p>
								<div class="media">
									<a class="pull-left" href="#"> <img
										class="media-object img-text"
										src="/resources/assets/images/users/user5.jpg" alt="John Travolta"
										width="64">
									</a>
									<div class="media-body">
										<h4 class="media-heading">John Travolta</h4>
										<p>Yeeees we happy!</p>
										<p class="text-muted">October 24, 2014, 14:32</p>
									</div>
								</div>
							</div></li>
					</ul>
				</div>
			</div>

		</div>

	</div>

</div>
<!-- END PAGE CONTENT WRAPPER -->
