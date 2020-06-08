<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
	.outer {width: 1000px; height: auto; margin-left: auto; margin-right: auto; margin-bottom: 50px; padding-bottom: 50px;}
	#detailContent {width: 900px; height: 95px;}
	.detailTable{margin: auto; text-align: center; border-collapse: collapse;}
  	.detailTable th{border-bottom: 1px solid lightgray; width:70px;}
 	.detailTable td{border-bottom: 1px solid lightgray; text-align: left;}
 	.detailTable_comment{margin: auto; border-bottom: 1px solid lightgray; height: 50px; background-color: lightgray; width: 800px;}
 	.detailTable_title{margin-left: 10px; font-size: 18px; padding-bottom: 10px; color:rgb(81, 143, 187);}
	.img {filter: brightness(70%); width: 100%; height: 400px;}	

/* 글내용 */
	.board_content{width: 800px;    height: auto;    margin-left: 100px;    margin-top: 40px;    margin-bottom: 40px;}

 /*수정삭제  */
	.pop{padding:5px 0px; cursor: pointer;}
 	.pop:hover label{background-color: lightgray;}
 	#popup{width: 100px; height: 65px; position: absolute; top: 80px; right: 18px; background-color: white; text-align: center;
			    border: 1px solid #d5d5d5; border-radius: 3px; box-shadow: rgba(0,0,0,.1) 0 1px 1px 0; display: none;}
	.fa-ellipsis-v{font-size:25px; display:inline; float: right; margin-top: 15px; margin-right: 20px; background-color: white;
				border: none; cursor: pointer;}
 	
/* 목록으로 가기 버튼 */
	.go_list_box{text-align: right;padding-right: 50px;}
	.go_list{width:70px; height:25px; background-color:lightgray; border:0; outline:0; border-radius:0.34em; cursor: pointer;}		

/* 댓글작성 */
	.reply1_box{width: 800px; height: auto; margin-left: 100px; padding-left: 10px; padding-right: 10px; padding-top: 10px; padding-bottom: 10px;border: dotted; border-color: rgb(201, 232, 255);}
	.comment2-1img{width: 38px; height: 38px; border-radius: 100%; margin-top: 5px; margin-left: 10px; margin-bottom: 5px; margin-right: 10px; vertical-align: middle;}
	.dong{line-height: 50px; display: inline; margin-left: 10px; margin-right: 10px;}
	.reply1_btn{float:right; width:70px; height:25px; background-color:lightgray; color:white; border:0; outline:0; border-radius:0.34em; cursor: pointer; margin-top: 10px;}
	.reply_TEXT{border-radius:0.34em; border-color: lightgrey; resize:none;}

/* 원댓글  */	
	.reply2_box{width: 800px; height: auto; margin-left: 100px; margin-top: 8px; padding-left: 10px; padding-right: 10px; padding-top: 10px; padding-bottom: 10px;border: solid; border-color: rgb(201, 232, 255);}
	.reply2_box_btn{cursor: pointer; float: right; margin-top: 15px; margin-right: 15px; border:0;}
	.reply2_box_btn2{cursor: pointer;margin-left: 10px; margin-top: 10px; margin-bottom: 10px;  border:0; outline:0;}
	.fa-thumbs-up{cursor: pointer; float: right; margin-top: 10px; margin-right: 10px;}
	 
/* 대댓글  */	
	.reply3_box{width: 763px; height: auto; margin-left: 140px; background-color: rgb(201, 232, 255); padding-left: 10px; padding-right: 10px; padding-top: 10px; padding-bottom: 10px; margin-top: 8px;}
 	
</style>
</head>
<body>
<img class="img" src="resources/images/noticeImage.jpg">
<jsp:include page="../common/menubar.jsp"/>
	<div class="outer">
		<form>
			<!-- 게시글 상단부 시작  -->	
			<br>
			<h2 style="margin-left: 15px;">공지사항 상세보기</h2>
			<hr>
			<br>
			<div id="detailContent" class="detailTable" style="text-align: left; position: relative;">
				<div class="detailTable_title">
					<b>${ notice.nTitle }</b>
				</div>
				<div id="cdt_profile" style="float:left;display:inline;">
						<img class="comment2-1img" src="<%= request.getContextPath() %>/css/화단사진.jpg">
					</div>
					<div class="dong">${ notice.userId }</div>
					<div style="display:inline;"><i class="far fa-clock"></i>${ notice.nCreateDate }</div>
					<div style="display:inline;"><i class="far fa-eye"></i>${ notice.nCount }</div>
				<!--수정 /삭제 선택 -->	
				<i class="fas fa-ellipsis-v"></i>
				<div id="popup">
						<c:url var="nlist" value="noticeUpdateView.no">
							<c:param name="page" value="${ page }"/>
							<c:param name="nNo" value="${ notice.nNo }"/>
						</c:url>
					<div class="pop" onclick="location.href='${ nlist }'"><label>수정</label></div>
					<div class="pop" onclick="location.href='noticeDelete.no'"><label>삭제</label></div>
				</div>
				<hr>
			</div>
		<!-- 게시글 상단부 끝  -->	
		<!-- 게시글 내용  -->
			<% pageContext.setAttribute("newLineChar", "\r\n"); %>
			<div class="board_content">${ fn:replace( notice.nContent, newLineChar, "<br>") }</div>
		<!-- 게시글 내용 끝 -->	
			<br>
			<hr style="width: 900px;">
			<div class="go_list_box">
				<input type="button" class="go_list" value="목록" onclick="location.href='noticeList.no'">
			</div>
			<br>
			<!--댓글 작성  -->
			<div class="reply1_box">
				<div id="cdt_profile" style="float: left; display: inline;">
					<img class="comment2-1img" src="<%=request.getContextPath()%>/css/화단사진.jpg">
				</div>
				<div class="dong">라랄라(202동)</div>
					<input type="button" class="reply1_btn" value="댓글등록">
				<div style="margin-left: 10px; margin-top: 12px;">
					<textarea class="reply_TEXT" name="reply_TEXT" cols="105" rows="4" placeholder="댓글을 입력해주세요. 비방, 홍보글, 도배글 등은 예고없이 삭제될 수 있습니다."></textarea>
				<div style="color:#aaa; float: right; margin-top: 45px;" id="counter">(0/200자)</div>
				</div>
			</div>
			<!--원 댓글  -->
			<div class="reply2_box">
				<div id="cdt_profile" style="float: left; display: inline;">
					<img class="comment2-1img" src="<%=request.getContextPath()%>/css/화단사진.jpg">
				</div>
				<div class="dong">라랄라(202동)</div>
					<input type="button" value="삭제" class="reply2_box_btn">
					<input type="button" value="수정" class="reply2_box_btn">
				<div style="margin-left: 10px;">와! 이런식으로 어쩌구 저쩌구한 투표결과를 보니 좋네요!</div>
				<div style="margin-left: 10px; color: gray;">2020.2.29. 19:16</div>
				<input type="button" value="답글" class="reply2_box_btn2">
				<i class="far fa-thumbs-up">0</i>
				</div>
			
			<!-- 대 댓글 -->
			<div class="reply3_box">
				<div id="cdt_profile" style="float: left; display: inline;">
					<img class="comment2-1img"src="<%=request.getContextPath()%>/css/화단사진.jpg">
				</div>
				<div class="dong">뾰로롱(201동)</div>
					<input type="button" value="삭제" class="reply2_box_btn">
					<input type="button" value="수정" class="reply2_box_btn">
				<div style="margin-left: 10px;">와! 이런식으로 어쩌구 저쩌구한 투표결과를 보니 좋네요!</div>
				<div style="margin-left: 10px; color: gray;">2020.2.29. 19:16</div>
				<input type="button" value="답글" class="reply2_box_btn2">
				<i class="fas fa-thumbs-up">1</i>
			</div>
		</form>
	</div>
	
	<script>
	
	// textarea 체크
	$('.reply_TEXT').keyup(function (e){
	    var content = $(this).val();
	    $('#counter').html("("+content.length+"/200자)");//글자수 실시간 카운팅

	    if (content.length > 200){
	        alert("최대 200자까지 입력 가능합니다.");
	        $(this).val(content.substring(0, 200));
	        $('#counter').html("(200/200자)");
	    }
	});
	
	/* 수정 삭제 보이기 */
	$(".fa-ellipsis-v").click(function(){
           var submenu = $(this).next();
              // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
              console.log(submenu);
                  
               if(submenu.css("display") == "none"){
               	submenu.show();
      	        }else{
      	        	submenu.hide();
      	        }
     });
	</script>
	<jsp:include page="../common/Footer.jsp"/>
</body>
</html>