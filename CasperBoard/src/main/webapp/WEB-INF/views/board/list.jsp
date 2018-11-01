<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- START BREADCRUMB -->
<ul class="breadcrumb">
	<li><a href="#">Home</a></li>
	<li><a href="#">Board</a></li>
	<li class="active">List</li>
</ul>
<!-- END BREADCRUMB -->

<!-- PAGE TITLE -->
<div class="page-title">
	<h2>
		<span class="fa fa-arrow-circle-o-left"></span> Casper Freeboard
	</h2>
</div>
<!-- END PAGE TITLE -->

<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">

	<div class="row">
		<div class="col-md-6">

			<!-- START BORDERED TABLE SAMPLE -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">List</h3>
					<select onchange ="change(this)">
						<option value="10" ${pageObj.display == 10? "selected":""}>10</option>
						<option value="20" ${pageObj.display == 20? "selected":""}>20</option>
						<option value="50" ${pageObj.display == 50? "selected":""}>50</option>
						<option value="100" ${pageObj.display == 100? "selected":""}>100</option>
					</select>
				</div>
				<div class="panel-body">

					<table class="table table-bordered">
						<thead>
							<tr>
								<th>No</th>
								<th>Title</th>
								<th>Writer</th>
								<th>Date</th>
								<th>Update Date</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="board">
								<tr>
									<td><c:out value="${board.bno}" /></td>
									<td><a href='${board.bno}' class='board'><c:out value="${board.title}" /></a></td>
									<td><c:out value="${board.mid}" /></td>
									<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td><fmt:formatDate value="${board.updatedate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		
			<!-- END BORDERED TABLE SAMPLE -->
<button class="btn btn-info btn-block"
					onclick="location.href='/board/register'">Write</button>
					
<div class="col-sm-12">
		  <div>
		    <select name="type">
		      <option value=""
		       <c:out value="${pageObj.type == null?'selected':'' }"/>>--</option>
		      <option value="t" <c:out value="${pageObj.type == 't'?'selected':'' }"/> >제목</option>
		      <option value="c" <c:out value="${pageObj.type == 'c'?'selected':'' }"/> >내용</option>
		      <option value="w" <c:out value="${pageObj.type == 'w'?'selected':'' }"/> >작성자</option>
		      <option value="tc" <c:out value="${pageObj.type == 'tc'?'selected':'' }"/> >제목 + 내용</option>
		      <option value="tcw" <c:out value="${pageObj.type == 'tcw'?'selected':'' }"/> >제목 + 내용 + 작성자</option>
		    </select>
		    <input type='text' name='keyword' value="${pageObj.keyword}">
		    <button id="searchBtn">Search</button>
		  </div>
		</div>
		
<ul class="pagination">
	<c:if test="${pageObj.prev}">
     <li><a href="${pageObj.start-1}">prev</a></li>
    </c:if>
    <c:forEach begin="${pageObj.start}" end="${pageObj.end}" var="num">
     <li data-page='${num}'><a href="${num}"><c:out value="${num}"/></a></li>
     </c:forEach>
     <c:if test="${pageObj.next}">
     <li><a href="${pageObj.end+1}">next</a></li>
     </c:if>
 </ul>
</div>
</div>
</div>

<form id='actionForm'>
	<input type='hidden' name='page' id='page' value='${pageObj.page}'>
	<input type='hidden' name='display' id='display' value='${pageObj.display}'>
	<input type='hidden' name='type' id='type' value='${pageObj.type}'>
	<input type='hidden' name='keyword' id='keyword' value='${pageObj.keyword}'>
</form>

<div class="modal in" id="myModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="false" style="display: none;"><div class="modal-backdrop  in"></div>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="defModalHead">Modal Without Footer</h4>
            </div>
            <div class="modal-body">
                <p>Some content in modal example</p>
                <button type="button" class="btn btn-default modelClose" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<!-- END RESPONSIVE TABLES -->

<%@include file="../includes/footer.jsp"%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>


<script>
// 페이지 당 글 개수
function change(obj){
	var display = obj.options[obj.selectedIndex].value;
	console.log(display);
	self.location = "list?page=1&display="+display;
	}

</script>
<script>

$(document).ready(function() {

	// 페이징
	var pageNum = ${pageObj.page};
	
	$('.pagination li[data-page=' +pageNum +']').addClass("active");
	
	$('.pagination li a').on("click", function(e){
		
		e.preventDefault();
		var target = $(this).attr("href");
		$("#page").val(target);
		console.log(target);
		actionForm.attr("action","/board/list").attr("method","get").submit();
	});
	
	// 글 조회
	var actionForm = $("#actionForm");

    $(".board").on("click",function(e) {
		 e.preventDefault();
            var bno = $(this).attr("href");
            actionForm.append("<input type='hidden' name='bno' value='"+bno+"'>");
            
            actionForm.attr("action","/board/read").attr("method", "get").submit();
        });
   
    // 모달
   var msg = $("#myModal");
   var result = '<c:out value="${result}"/>';
   
   checkModal(result);
   
   $(".modelClose").on("click", function(e){
		  
	   console.log("--------------------------");
	   msg.hide('slow');
	   
   });
   
   
   history.replaceState({},null,null);
   
   function checkModal(result){
	   
	   console.log("checkModal.....................");
	   
	   
	   if(result === '' || history.state){
		   console.log("........................");
		   return;
	   }
	   
	   console.log("RESULT: "+result);
	   
	   if(result === 'SUCCESS'){
		   $(".modal-body p").html("성공하였습니다.");
		   msg.show("slow");
	   }
	   
   }
   
 
   // 검색
   
   $("#searchBtn").on("click", function(e){
	  
	  var searchTypeValue = $("select[name='type'] option:selected").val();
	  console.log(searchTypeValue);
	  
	  var searchKeyword = $("input[name='keyword']").val();
	  console.log(searchKeyword);
	  
	  if(searchKeyword.trim().length == 0){
		  alert ("검색어 없음");
		  return;
	  }
	   
	actionForm.attr("action","/board/list");
	actionForm.find("input[name='type']").val(searchTypeValue);
	actionForm.find("input[name='keyword']").val(searchKeyword);
	$("#page").val(1);
	
	actionForm.submit();
   });
   
   
   
   
  });
</script>