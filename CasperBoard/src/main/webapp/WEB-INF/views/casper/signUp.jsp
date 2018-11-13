<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<head>
<!-- META SECTION -->
<title>Casper Sign Up</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />


<!-- END META SECTION -->

<!-- CSS INCLUDE -->
<link rel="stylesheet" type="text/css" id="theme"
	href="/resources/css/theme-default.css" />
<!-- EOF CSS INCLUDE -->
</head>
 <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a href="/casper/customLogin">Casper</a></li>
                    <li class="active">Sign Up</li>
                </ul>
                <!-- END BREADCRUMB -->
                
                <!-- PAGE CONTENT WRAPPER -->
                <div class="page-content-wrap">
                
                    <div class="row">
                        <div class="col-md-12">
                            
                            <form class="form-horizontal myForm" action="/casper/signUp" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><strong>Sign</strong> Up</h3>
                                    <ul class="panel-controls">
                                        <li><a href="#" class="panel-remove"><span class="fa fa-times"></span></a></li>
                                    </ul>
                                </div>
                                <div class="panel-body">
                                    <p>회원 가입 페이지입니다.</p>
                                </div>
                                <div class="panel-body form-group-separated">
                                    
                                    <div class="form-group">
                                        <label class="col-md-3 col-xs-12 control-label">ID</label>
                                        <div class="col-md-6 col-xs-12">                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                                <input type="text" class="form-control" name="mid"/>
                                            </div>                                            
                                            <span class="help-block">회원ID를 입력하세요.</span>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">                                        
                                        <label class="col-md-3 col-xs-12 control-label">Password</label>
                                        <div class="col-md-6 col-xs-12">
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-unlock-alt"></span></span>
                                                <input type="password" class="form-control" name="password"/>
                                            </div>            
                                            <span class="help-block">패스워드를 입력하세요.</span>
                                        </div>
                                    </div>
                                      <div class="form-group">
                                        <label class="col-md-3 col-xs-12 control-label">닉네임</label>
                                        <div class="col-md-6 col-xs-12">                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                                <input type="text" class="form-control" name="mname"/>
                                            </div>                                            
                                            <span class="help-block">닉네임을 입력하세요.</span>
                                        </div>
                                    </div>
                                   
                                    <div class="form-group">
                                        <label class="col-md-3 col-xs-12 control-label">자기소개</label>
                                        <div class="col-md-6 col-xs-12">                                            
                                            <textarea class="form-control" name="info" rows="5"></textarea>
                                            <span class="help-block">간단한 자기소개와 가입인사를 입력해주세요.</span>
                                        </div>
                                    </div>
                           
                                </div>
                                <div class="panel-footer">
                                    <button class="btn btn-default">Clear Form</button>                                    
                                    <button type="submit" id="submitBtn" class="btn btn-primary pull-right">Submit</button>
                                </div>
                            </div>
                            </form>
                            
                        </div>
                    </div>                    
                    
                </div>
                <!-- END PAGE CONTENT WRAPPER -->                                                
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
	
<script>

$(document).ready(function(){

	var formObj = $(".myForm");
	
	$("#submitBtn").on("click", function(e){
		
		e.preventDefault();
				
		console.log("submit clicked");
		
		formObj.append().submit();

	});
	
});
	
</script>
	