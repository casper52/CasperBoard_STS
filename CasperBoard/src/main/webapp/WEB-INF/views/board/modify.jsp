<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp"%>


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
	color:gray;
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
	width:100%;	
}
</style>
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

		<form class="form-horizontal myForm" action="/board/modify" method='post'>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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

						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Files</label>
							<div class="col-md-6 col-xs-12">
							 <input type="file" class="fileinput btn-primary" name="uploadFile" id="filename" title="Browse file" multiple/>
                                  <span class="help-block">Input type file</span>
								<div class='uploadResult'>
									<ul>
									
									</ul>
								</div>
							</div>
						</div>

					
					<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.mid}">
					<button id="modifyBtn" class="btn btn-info btn-block">Modify</button>
					</c:if>
					</sec:authorize>
					</div>

				
					</div>
				</form>
				</div>
			
			
								<form role="form" action="/board/remove" method='post'>
								 <input type="hidden" name="page" value="${pageObj.page}">
								 <input type="hidden" name="bno" value="${pageObj.bno}">
								 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								 <sec:authentication property="principal" var="pinfo"/>
								<sec:authorize access="isAuthenticated()">
								<c:if test="${pinfo.username eq board.mid}">
									<button type="submit" class="btn btn-default">Remove</button>
								</c:if>
								</sec:authorize>
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

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	
<script>

$(document).ready(function(){

	var formObj = $(".myForm");
	
	$("#modifyBtn").on("click", function(e){
	
		e.preventDefault();
		
		console.log("modify clicked");
		
		var str ="";
		
		$(".uploadResult ul li").each(function(i,obj){
			
			var jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});
		
		
		formObj.append(str).submit();
	});
	
	
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
				str += "<span><font color='black'> "+ attach.fileName+ "</font></a></span><br/>";
				str += "<a href='#' data-file=\'"+fileCallPath+"\'data-type='image' class='panel-remove'><span class='fa fa-times'></span></a><br>";
				str += "<img src='/board/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str +"</li>";
			}else{
				
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<span><font color='black'> "+ attach.fileName+ "</font></span><br/>";
				str += "<a href='#' data-file=\'"+fileCallPath+"\'data-type='image' class='panel-remove'><span class='fa fa-times'></span></a><br>";
				str += "<img src='/resources/img/filetree/file.png'></a>";
				str += "</div>";
				str +"</li>";
			}
		});
		
		$(".uploadResult ul").html(str);
	}); //end getjson
	
});

$(".uploadResult").on("click","a", function(e){
	console.log("delete file");
	
	if(confirm("Remove this file?")){
		var targetLi = $(this).closest("li");
		targetLi.remove();
	}
});

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;

function checkExtension(fileName, fileSize){
	
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
	
	if(regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$("input[type='file']").change(function(e){
	
	var formData = new FormData();
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;
	for(var i = 0; i < files.length; i++){
		if(!checkExtension(files[i].name, files[i].size)){
			return false;
		}
		formData.append("uploadFile",files[i]);
	}
	
	$.ajax({
		url: '/board/uploadAjaxAction',
		processData: false,
		contentType: false,data:
		formData,type: 'POST',
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		dataType:'json',
		success: function(result){
			console.log(result);
			
		showUploadResult(result);
		}
	});

});

function showUploadResult(uploadResultArr){
	
	if(!uploadResultArr || uploadResultArr.length == 0){return; }
	
	var uploadUL = $(".uploadResult ul");
	
	var str="";
	$(uploadResultArr).each(function(i,obj){
		
		if(obj.fileType){
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
			
			str += "<li data-path='"+obj.uploadPath+"'";
			str += " data-uuid='"+obj.uuid + "' data-filename='"+obj.fileName+"'data-type='"+obj.fileType+"'"
			str +"><div>";
			str += "<span>" + obj.fileName + "</span>";
			str += "<a href='#' data-file=\'"+fileCallPath+"\'data-type='image' class='panel-remove'><span class='fa fa-times'></span></a><br>";
			str += "<img src='/board/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str += "</li>";
		}else{
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
			str += "<li "
			str += "data-path='"+obj.uploadPath+"'data-uuid='" + obj.uuid+"'data-filename='"+obj.fileName+"'data-type='"+obj.fileType+"'><div>";
			str += "<span>" + obj.fileName + "</span>";
			str += "<a href='#' data-file=\'"+fileCallPath+"\'data-type='file' class='panel-remove'><span class='fa fa-times'></span></a><br>";
			str += "<img src='/resources/img/filetree/file.png'></a>";
			str += "</div>";
			str += "</li>";
			
		}
	});
	uploadUL.append(str);
}


</script>