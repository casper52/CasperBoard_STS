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
					<ul class="chat">
						<li class="media" data-rno='12'><a class="pull-left" href="#">
						<img class="media-object img-text" src="/resources/assets/images/users/no-image.jpg"
								alt="Dmitry Ivaniuk" width="64">
						</a>
							<div class="media-body">
								<h4 class="media-heading">Dmitry</h4>
								<p>test
									</p>
								<p class="text-muted">October 24, 2014, 15:20</p>
								
							</div></li>
					</ul>
					
					<button id="addReplyBtn" class="btn btn-primary pull-left">New Comment</button>
				</div>
			</div>

		</div>

	</div>

</div>
<!-- END PAGE CONTENT WRAPPER -->
<div class="modal in" id="myModal" tabindex="-1" role="dialog" aria-labelledby="largeModalHead" aria-hidden="false" style="display:none;"><div class="modal-backdrop  in"></div>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="defModalHead">Reply Modal</h4>
            </div>
            <div class="modal-body">
              			<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Reply</label>
							<input type="text" class="form-control" name="reply" value='New Reply!!'/>
						</div>
						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Replyer</label>
							 <input type="text" class="form-control" name="replyer" value='replyer'/>
						</div>
						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Reply Date</label>
							<input type="text" class="form-control" name="replyDate" value=''/>
						</div>
						<div class="modal-footer">
                <button id='modalModBtn' type="button" class="btn btn-primary btn-rounded" data-dismiss="modal">Modify</button>
                <button id='modalRemoveBtn' type="button" class="btn btn-primary btn-rounded" data-dismiss="modal">Remove</button>
                <button id='modalRegisterBtn' type="button" class="btn btn-primary btn-rounded" data-dismiss="modal">Register</button>
                <button id='modalCloseBtn' type="button" class="btn btn-primary btn-rounded" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

$(document).ready(function(){
	
		var bno = '<c:out value="${pageObj.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno:bno, page:page||1}, function(list){
				
				var str="";
				if(list == null || list.length == 0){
					replyUL.html("");
					
					return;
				}
				for(var i = 0, len = list.length || 0; i < len; i++){
					str +="<li class='media' data-rno='"+list[i].rno+"'>";
					str +="<a class='pull-left' href='#''> <img class='media-object img-text' src='/resources/assets/images/users/user.jpg' alt='Dmitry Ivaniuk' width='64'></a>";
					str +="<div class='media-body'><h4 class='media-heading'>"+list[i].replyer+"</h4>";
					str +="<p>"+list[i].reply+"</p>";
					str +="<p class='text-muted'>"+replyService.displayTime(list[i].replyDate)+"</p></div></li></ul>"
			
				}
				
			replyUL.html(str);
			});
		}
		
		var modal = $("#myModal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		var modalCloseBtn = $("#modalCloseBtn");
		
		$("#addReplyBtn").on("click",function(e){
			
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id !='modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$("#myModal").show();
			
		})
		
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno: bno
			};
			
			replyService.add(reply, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.hide();
				
				showList(1);
			});
			
		});
		
		$(".chat").on("click","li",function(e){
			
			var rno = $(this).data("rno");
			
			replyService.read(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
				modal.data("rno",reply.rno);
				
				modal.find("button[id !='modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$("#myModal").show();
				
			});
			
		});
		
		modalModBtn.on("click", function(e){
			
			var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
			
			replyService.modify(reply, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(1);
				
			});
			
		});
		
		modalRemoveBtn.on("click", function(e){
			
			var rno = modal.data("rno");
			
			replyService.remove(rno, function(result){
				
				alert(result);
				modal.modal("hide");
				showList(1);
				
			});
		});
		
		modalCloseBtn.on("click", function(e){
			 console.log("modal close");
			 $("#.myModal").hide();
		});
		
		
		
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