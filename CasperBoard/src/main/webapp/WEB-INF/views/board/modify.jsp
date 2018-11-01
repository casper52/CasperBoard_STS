<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- START BREADCRUMB -->
<ul class="breadcrumb">
	<li><a href="#">Home</a></li>
	<li><a href="#">Board</a></li>
	<li class="active">Modify</li>
</ul>
<!-- END BREADCRUMB -->

<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">

	<div class="row">
		<div class="col-md-12">

			<form class="form-horizontal" action="/board/modify" method='post'>
			<input type="hidden" name="bno" value="${board.bno}">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<strong>Modify / Remove</strong>
						</h3>
						<ul class="panel-controls">
							<li><a href="#" class="panel-remove"><span
									class="fa fa-times"></span></a></li>
						</ul>
					</div>
					
					<div class="panel-body">
					
						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Title</label>
							<div class="col-md-6 col-xs-12">
								<div class="input-group">
									<span class="input-group-addon"><span
										class="fa fa-pencil"></span></span> <input type="text"
										class="form-control" name="title" value='<c:out value="${board.title}"/>'>
								</div>

							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Writer</label>
							<div class="col-md-6 col-xs-12">
								<div class="input-group">
									<span class="input-group-addon"><span
										class="fa fa-pencil"></span></span> <input type="text"
										class="form-control" name="mid" value='<c:out value="${board.mid}"/>'/>
								</div>

							</div>
						</div>

						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Content</label>
							<div class="col-md-6 col-xs-12">
								<textarea class="form-control" name="content" rows="5"> 
								<c:out value="${board.content}" /></textarea>

							</div>
						</div>

						
					<button type="submit" class="btn btn-info btn-block">Modify</button>
		
					</div>
				</div>
			</form>
			
								<form role="form" action="/board/remove" method='post'>
								 <input type="hidden" name="page" value="${pageObj.page}">
								 <input type="hidden" name="bno" value="${pageObj.bno}">
									<button type="submit" class="btn btn-default">Remove</button>
								</form>
								<form role="form" action="/board/list" method='get'>
								<input type="hidden" name="page" value="${pageObj.page}">
									<button type="submit" class="btn btn-default">Go List</button>
								</form>
		</div>
				
						
	</div>
</div>
			


<!-- END PAGE CONTENT WRAPPER -->
<%@include file="../includes/footer.jsp"%>