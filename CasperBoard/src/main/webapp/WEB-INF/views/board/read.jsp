<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- PAGE TITLE -->

<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
</div>

<style>
.uploadResult{
	width:100%;
	background-color:white;
	}

.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}	
.uploadResult ul li{
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}
.uploadResult ul li img{
	width:100px;
}
.uploadResult ul li span{
	color:white;
}

.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: white;
	z-index: 100;
	background:rgba(255,255,255,0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img{
	width: 600px;	
}
</style>
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
						<div class="panel-heading">Files</div>
						<div class="panel-body">
							<div class='uploadResult'>
								<ul>
								</ul>
							</div>
						</div>
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

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	
<script>

$(document).ready(function(){
	
		var bno = '<c:out value="${pageObj.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
			console.log(arr);
			
			var str ="";
			
			$(arr).each(function(i,attach){
				
				//image type
				if(attach.fileType){
					var fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_"+ attach.uuid + "_" + attach.fileName);
					var fileCallPathOrigin = encodeURIComponent(attach.uploadPath+ "/"+ attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span><a href='/board/download?fileName="+fileCallPathOrigin+"'><font color='black'> "+ attach.fileName+ "</font></a></span><br/>";
					str += "<img src='/board/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str +"</li>";
				}else{
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span><font color='black'> "+ attach.fileName+ "</font></span><br/>";
					str += "<img src='/resources/img/filetree/file.png'></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			
			$(".uploadResult ul").html(str);
		}); //end getjson
});

$(".uploadResult").on("click","li",function(e){
	console.log("view image");
	
	var liObj = $(this);
	
	var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid")+"_"+liObj.data("filename"));
	
	if(liObj.data("type")){
		showImage(path.replace(new RegExp(/\\/g),"/"));
	}else{
		//download
		self.location ="/board/download?fileName="+path
	}
});

	function showImage(fileCallPath){
		

		$(".bigPictureWrapper").css("display","flex").show();
		$(".bigPicture")
		.html("<img src='/board/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		},1000);
	});

</script>