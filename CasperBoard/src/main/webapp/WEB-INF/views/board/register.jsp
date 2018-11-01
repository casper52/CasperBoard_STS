<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	.uploadResult{
	
	width:100%;
	background-color:white;
	}
	
	.uploadResult ul{
	display:flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
	}
	
	.uploadResult ul li{
	list-style: none;
	padding: 10px;
	}
	
	.uploadResult ul li img{
	width: 60px;
	}
	
	
</style>

<!-- START BREADCRUMB -->
<ul class="breadcrumb">
	<li><a href="#">Home</a></li>
	<li><a href="#">Board</a></li>
	<li class="active">Register</li>
</ul>
<!-- END BREADCRUMB -->

<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">

	<div class="row">
		<div class="col-md-12">

			<form class="form-horizontal myForm" action="/board/register" method='post'>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<strong>Register</strong>
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
										class="form-control" name="title"/>
								</div>

							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Writer</label>
							<div class="col-md-6 col-xs-12">
								<div class="input-group">
									<span class="input-group-addon"><span
										class="fa fa-pencil"></span></span> <input type="text"
										class="form-control" name="mid"/>
								</div>

							</div>
						</div>

						<div class="form-group">
							<label class="col-md-3 col-xs-12 control-label">Content</label>
							<div class="col-md-6 col-xs-12">
								<textarea class="form-control" name="content" rows="5"></textarea>

							</div>
						</div>
				
						 <div class="form-group">
                              <label class="col-md-3 col-xs-12 control-label">File</label>
                              <div class="col-md-6 col-xs-12"> 
                              	<div class="panel-body">                                                                                                                                     
                                  <input type="file" class="fileinput btn-primary" name="uploadFile" id="filename" title="Browse file" multiple/>
                                  <span class="help-block">Input type file</span>
                              </div>
                              <div class='uploadResult'>
                              	<ul>
                              	
                              	</ul>
                              </div>
                             </div>  
                          </div>
                          

						
						<button id="submitBtn" class="btn btn-primary pull-right">Submit</button>
		
					</div>
				</div>
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
	
	$("#submitBtn").on("click", function(e){
		
		e.preventDefault();
				
		console.log("submit clicked");
		
		var str = "";
		
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
	
	$(".uploadResult").on("click","a", function(e){
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/board/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType:'text',
			type: 'POST',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
		})
	});
	
});

</script>