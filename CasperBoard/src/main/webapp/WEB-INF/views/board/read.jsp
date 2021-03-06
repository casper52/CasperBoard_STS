<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp"%>
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

.comment ul{
list-style:none;
padding-left:0px;
}

.content {
	white-space: pre-wrap;
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
								href="#"><c:out value="${board.rcnt}"/> Comments</a> / <a
								href="#">by <c:out value="${board.mid}"/></a>
						</div>
						<div class="content" name="content">
						<h4><c:out value="${board.content}" /></h4>
						
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
								  	<sec:authentication property="principal" var="pinfo"/>
								  	<sec:authorize access="isAuthenticated()">
								  	<c:if test="${pinfo.username eq board.mid}">
									<button type="submit" class="btn btn-default">Modify</button>
									</c:if>
									</sec:authorize>
								</form>

			<div class="comment">
					<h3 class="push-down-20">Comments</h3>
				
					<ul class="chat">
						<li class="media" data-rno='12'><a class="pull-left" href="#">
						
						<img class="media-object img-text" src="/resources/assets/images/users/no-image.jpg"
								alt="Dmitry Ivaniuk" width="64">
						</a>
							<div class="media-body">
								<h4 class="media-heading"></h4>
								<p>
									</p>
								<p class="text-muted"></p>
							</div>
							</li>
							
					</ul>
				</div>
					<div class="panel-footer">
				
					</div>
				
					<button id="addReplyBtn" class="btn btn-primary pull-left">New Comment</button>
					
				</div>
			</div>

		</div>

	</div>

</div>
<!-- END PAGE CONTENT WRAPPER -->
<div class="modal in" id="myModal"  role="dialog" aria-labelledby="largeModalHead" aria-hidden="false" style="display:none;"><div class="modal-backdrop  in"></div>
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
			    <button id='modalRegBtn2' type="button" class="btn btn-primary btn-rounded" data-dismiss="modal">Reply</button>
                <button id='modalCloseBtn' type="button" class="btn btn-primary btn-rounded" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

$(document).ready(function(){
	
		//댓글 출력
		var bno = '<c:out value="${pageObj.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno:bno, page:page||1}, function(replyCnt, list){
				
				console.log("replyCnt: " + replyCnt);
				console.log("list: " + list);
				console.log(list);
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str="";
				if(list == null || list.length == 0){
					
					return;
				}
				for(var i = 0, len = list.length || 0; i < len; i++){
					str +="<li class='media' data-rno='"+list[i].rno+"'>";
					if(list[i].depth == 1){
					str +="<a class='pull-left' href='#'> <img class='media-object img-text' src='/resources/assets/images/users/user.jpg' alt='Dmitry Ivaniuk' width='64'></a>";
					str +="<div class='media-body'><p class='text-warning'>"+list[i].replyer+"</h4>";
					}else{
						str +="<a class='pull-left' href='#''> <img class='media-object img-text' src='/resources/assets/images/users/user.jpg' alt='Dmitry Ivaniuk' width='64'></a>"
							str +="<div class='media-body'><p class='text-warning'>"+list[i].replyer+"</h4>";
					}
					str +="<p>"+list[i].reply+"</p>";
					str +="<p class='text-muted'>"+replyService.displayTime(list[i].replyDate)+"</p></div></li><div><button id='addRereplyBtn' type='button' class='btn btn-primary btn-rounded pull-right' data-parent='"+list[i].parent+"' data-rno='"+list[i].rno+"'>댓글</button></div></ul>";
					
				}
				
			parent=list[list.length-1].parent;	
			replyUL.html(str);
			
			showReplyPage(replyCnt);
			});
		}
		
		//댓글 페이징
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum/10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "<ul class='pagination'>";
			
			if(prev){
				str+= "<li class='page-item'><a class='page-link' href='"+(startNum - 1)+"'>prev</a></li>";
			}
			
			for(var i = startNum; i<= endNum; i++){
				
				var active = pageNum == i? "active":"";
				
				str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>next</a></li>";
			}
			
			str += "</ul>";
			
			
			replyPageFooter.html(str);
		}
		
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum: "+ targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		})
		
		//댓글 모달창
		var modal = $("#myModal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		var modalRegBtn2=$("#modalRegBtn2");
		var modalCloseBtn = $("#modalCloseBtn");
		
		var replyer = null;
		
	<sec:authorize access="isAuthenticated()">
		
		replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
		
		
		
		//댓글 추가 모달
		$("#addReplyBtn").on("click",function(e){
			
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id !='modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$("#myModal").show();
			
		})
		
		//대댓글 추가 모달
		$(".chat").on("click","button",function(e){
			
			console.log("add rereply....")
			var btn = e.target;
			modal.find("input").val("");
			parent=btn.getAttribute("data-parent");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id !='modalCloseBtn']").hide();
			
			modalRegBtn2.show();
			
			$("#myModal").show();
			
		})
		
		//시큐리티 csrf토큰
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		//댓글 등록
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno: bno,
				parent:++parent,
				depth:0
			};
			
			replyService.add(reply, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.hide();
				
				//showList(1);
				showList(-1);
			});
			
		});
		
		//대댓글 등록
		modalRegBtn2.on("click",function(e){
			var reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno: bno,
					parent:parent,
					depth:1
			};
			replyService.add(reply,function(result){
				alert(result);
				
				modal.find("input").val("");
				modal.hide();
				showList(-1);
			});
			
		})
		
		//댓글 작성자에게 수정, 삭제버튼 보이기
		$(".chat").on("click","li",function(e){
		
			var rno = $(this).data("rno");
			var username = "<c:out value='${pinfo.username}'/>"
			
			console.log("username:"+username);
			
			replyService.read(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
				modal.data("rno",reply.rno);
				
				modal.find("button[id !='modalCloseBtn']").hide();
				
			
				if(username == reply.replyer){
				
					modalModBtn.show();
				
					modalRemoveBtn.show();
				}
			
				
				$("#myModal").show();
				
			});
			
		});
		
		//댓글 수정
		modalModBtn.on("click", function(e){
			
			var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
			
			replyService.modify(reply, function(result){
				
				alert(result);
				$("#myModal").hide();
				showList(pageNum);
				
			});
			
		});
		
		//댓글 삭제
		modalRemoveBtn.on("click", function(e){
			
			var rno = modal.data("rno");
			
			console.log("RNO: " + rno);
			console.log("REPLYER: " + replyer);

			replyService.remove(rno, function(result){
				
				alert(result);
				$("#myModal").hide();
				showList(pageNum);
				
			});
		});
		
		//모달창 클로즈
		modalCloseBtn.on("click", function(e){
			 console.log("modal close");
			 $("#myModal").hide();
		});
		
		
		//첨부파일 출력
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