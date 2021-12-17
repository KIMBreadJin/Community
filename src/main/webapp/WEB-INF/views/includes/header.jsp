<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
 
<html lang="en">
  
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
  	<script src="https://code.jquery.com/jquery-3.6.0.js" type="text/javascript"></script>
  	<link rel="stylesheet" type="text/css" href="/resources/css/header.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" >
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="/resources/js/ckeditor/ckeditor.js"></script>
    <script src="/resources/js/header.js"></script>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header>
<nav class="navbar navbar-light bg-light ">
	<div style="float:none; margin:0 auto">
  		<a class="navbar-brand" href="/board/list"><h1>Big Tree Community</h1></a>
  	</div>
 <div>
        <ul class="navbar-nav">
          <li class="nav-item dropdown messages-menu">
            <a
              class="nav-link dropdown-toggle"
              href="http://example.com"
              id="navbarDropdownMenuLink"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
            >            
              <i class="fa fa-envelope" aria-hidden="true"></i>
              <span class="label label-success">${cntMsg}</span>
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <ul class="dropdown-menu-over list-unstyled">
                <li class="header-ul text-center">You have ${cntMsg} messages</li>
                <li>
                  <!-- inner menu: contains the actual data -->
                  <ul class="menu list-unstyled"> 
                  <!-- start message -->
                    <c:forEach items="${mlist}" var="mlist">                
                      <li>               
                        <a id="readM" href="/message/readMsg?mid=${mlist.mid}" onclick="window.open(this.href, '_blank', 'width=700, height=510'); return false;">
                          <div class="pull-left">
                              <img src="http://via.placeholder.com/160x160" class="rounded-circle " alt="User Image">
                          </div>
                          <h4>
                            ${mlist.send_name}
                            <i class="fa fa-clock-o"></i> <small> ${mlist.creat_dt}</small>
                          </h4>
                          <p>${mlist.ms_content}</p>                
                        </a>
                        <form action="/message/deleteMsg" method="post" name="delForm">
                          <input type="hidden" name="mid" value="${mlist.mid}"/>
                          <input type="submit" id="deleteMsg" value="&#xf1f8"/>
                        </form>
                      </li>                      
                    </c:forEach>
                    <!-- end message -->
                  </ul>
                </li>
                <li class="footer-ul text-center"><a href="/message/msgList">See All Messages</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
  <div class="row">
  	<div class="col-lg-12">
		  <c:if test="${info == null}">
		  <h7 class="page-header"><a href='/member/login'>로그인하러가기</a></h7>
		  </c:if>
		  <c:if test="${info != null}">
		  <h7 class="page-header">
		 
		  ${info.user_name}님 반갑습니다 <a href='/member/logout'>로그아웃</a></h7>
		  </c:if>
		  <br>
		  <button class="navbar-toggler float-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
		  	aria-expanded="false" aria-label="Toggle navigation" style="background-color:gray;">
		    <span class="navbar-toggler-icon"></span>
		  </button>
	</div>
</div>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto  float-right">
      <li class="nav-item active">
        <a class="nav-link" href="#">나의 게시글<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" id="goChat">실시간 채팅</a>
      </li>
     <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle ${info!=null ? "": "disabled"}"" href="#" id="friend" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	친구
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item"  id="friendRequest">친구 요청</a>
          <a class="dropdown-item"  id="friendList">친구 목록</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item"  id="blockList">차단 목록</a>
        </div>
      </li> 
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle ${info!=null ? "": "disabled"}"" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	나의 정보 조회/수정
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">정보 조회</a>
          <a class="dropdown-item" href="#">정보 수정</a>
      </li> 
		<form class="navbar-form" role="search" action="#" id="searchUser">
		    <div class="form-group">
		      <input type="text" class="form-control" placeholder="유저찾기" id="searchUserName">
		    	<p id="searchResult"></p>
		    </div>
	  	</form>
    </ul>
  </div>
</nav>

         <!-- 회원목록불러오기 modal    -->
			<div class="modal fade" id="memberList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
             
                    <h4 class="modal-title" id="myModalLabel">회원목록</h4>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body">
	 				<ul class="userList">
             
            		</ul>
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                    <button class="btn btn-info" id="memberListCloseBtn" type="button">닫기</button>
                  </div>
                </div>
              </div>
            </div>
        <!-- 회원목록불러오기 modal end    -->
        
        <!-- 클릭시 나오는 회원정보 modal -->
        <div class="modal fade" id="memberInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">     
                    <h4 class="modal-title" id="myModalLabel">회원정보</h4>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body" width="300px">
                  	   <div class="form-group">
	                    <p class='text-center'>프로필 사진</p><img src="/resources/images/basicProfileIcon.png" width="100%">
	                  
	                  </div>
	                  <form class="form-horizontal" method="get" action="" name='sendMsgForm'>
	 					<div class="form-group">
	                    <label for="">아이디</label>
	                    <input type="text" class="form-control" name="user_id" id="memberId" readonly />
	                  </div>
	                  </form>
                      <div class="form-group">
                        <label for="">이름</label>
                        <input type="text" class="form-control" name="memberName" id="memberName" value=""  readonly />
                      </div>
                       <div class="form-group">
                        <label for="">작성한 게시글수 </label>
                        <input type="text" class="form-control" name="postCnt"  id="postCnt" value=""  readonly />
                      </div>
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                    <button class="btn " id="sendMsgBtn" type="submit"><img src="/resources/images/sendMsg.png" width="50px"></button>
                    &nbsp;&nbsp;&nbsp;                
                    <button class="btn " id="friendRegistBtn" type="button"><img src="/resources/images/friendRegistbtnIcon.jpg" width="50px"></button>
                    &nbsp;&nbsp;&nbsp;
                    <button class="btn btn-info" id="memberInfoCloseBtn" type="button" width="50px">닫기</button>
                  </div>
                </div>
              </div>
            </div>
         <!-- 클릭시 나오는 회원정보 modal end -->

         <div class="modal fade" id="requestList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header" style="margin:0;padding:0;">
                   <nav class="navbar " style="width:248px;margin:0;padding:0;">
					  <form class="form-inline" style="margin:0;padding:0;">
					    <button class="btn btn-outline-secondary" type="button" style="width:248.66px;" id="requestSent"><h3>보낸 요청</h3></button>
					  </form>  
					</nav>
					 <nav class="navbar" style="width:248px;margin:0;padding:0;">
					  <form class="form-inline" >
					    <button class="btn btn-outline-secondary" type="button" style="width:248.66px" id="requestReceived"><h3>받은 요청</h3></button>
					  </form>  
					</nav>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body">
	 				<ul class="requestResultList">
             			
            		</ul>
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                    <button class="btn btn-info" id="requestListCloseBtn" type="button">닫기</button>
                  </div>
                </div>
              </div>
            </div>
         
         
</header>
 <style>
	  .navbar.navbar-light.bg-light{
		  position:relative;
		  z-index:1;
	  }
	  
	  .navbar.navbar-light.bg-light:after {
	  	background-image:url('/resources/images/big_tree_header_back.jpg') !important;
	  	opacity:0.3;
	  	top:0;
	  	left:0;	 
	  	position:absolute; 	
	  	z-index:-1;
	  	content:"";
	  	width:100%;
	  	height:100%;
	  }
	a{
		font-weight:bold;
	}
	#sendMsgBtn{
		margin:0;
		padding:0;
	}
	#friendRegistBtn{
		margin:0;
		padding:0;
	}
  </style>
  
<script type="text/javascript">
var requestCnt=0;
var cnt=0;
var timer=null;
var targetId=""
var clicked={
		"rejectClicked":false,
		"acceptClicked":false,
		"blockClicked":false,
		"deleteClicked":false
		}

const rejectClicked=()=>{//친구거절 버튼클릭시 
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['rejectClicked']=true	
}
const acceptClicked=()=>{//친구수락 버튼클릭
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['acceptClicked']=true
}
const blockClicked=()=>{//차단버튼 클릭시
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['blockClicked']=true
}
const deleteClicked=()=>{//친구요청 취소버튼 클릭시
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['deleteClicked']=true
}

const resetClicked=()=>{
	for(let i in clicked){
		clicked[i]=false
	}
}

$(document).on('click','#resultNameList',function(e){//친구요청 모달에서 버튼클릭시 처리
	var getUrl="/"
		for(let key in clicked){
			if(clicked[key]){
				getUrl += key
			}	
		}
		if(getUrl=="/") return false
		$.ajax({
			type:'get',
			url:getUrl,
			data:{
				"receiver_id":getUrl=="/deleteClicked" ?  receiver_id: "${info.user_id}",
				"send_id":getUrl=="/deleteClicked" ? "${info.user_id}" :receiver_id 
			},
			success:function(data){
				alert(data)
				console.log(clicked)
				$(".requestResultList").modal('hide')
				$(".requestResultList").modal('show')
				getUrl=="/deleteClicked" ? 
						$("#requestSent").trigger('click'):
						$("#requestReceived").trigger("click")
				$(".modal-backdrop").remove()
				if(getUrl=="/acceptClicked"){
					sock.send("${info.user_id}"+","+receiver_id+","+ "친구 수락")
				}
				resetClicked()
				
			}
		})
})



$(document).ready(function(){
 	console.log()
	var userList;
	var userName= $("#searchUserName").val()
	$('#goChat').click( function (e) {
		e.preventDefault()
	    window.open('/chat/chatList',"채팅목록,","width=700,height=430")
	    window.resizeTo(700,430); 
	    return false;
	 })		 
	 $("#searchUser").submit(function(e){
		 e.preventDefault()
		 if($("#searchUserName").val().length<2){
			 alert("정확한 정보조회를 위해 두글자 이상 입력해주세요")
			 return false;
		 }
		 
		 userName= $("#searchUserName").val()
		 $.ajax({
			 type:'get',
			 url:'/searchUser',
			 data:{
				 user_name:userName
			 },
			 success: function(data){
				 if(data==0){
					 $("#searchResult").css('color','red').text("조회결과가 없습니다.")
				 }
				 else{
					 $("#searchResult").css('color','blue').text(data+'개의 조회결과가 있습니다 (결과보기)')
				 }
			 }
		 })//end ajax
	 }) 
		 $("#searchResult").click(function(e){//결과보기 눌렀을때 호출함수
			 var userName= $("#searchUserName").val()
			 var str=""
			$.ajax({
				type:'get',
				url:'/getUserList',
				data:{
					user_name:userName
				},
				success:function(list){
					 $(".userList").html('')
					 for (var i = 0, len = list.length || 0; i < len; i++) { 	
		                    str += "<li class='left clearfix' data-name='" + list[i].user_name + "' id='resultNameList' style='margin:4px' >"
		                    str += " <div><div class='header'><img src='/resources/images/basicProfileIcon.png' width='45px' /> "
		                    str += "<strong class='primary-font' >" + list[i].user_name + '</strong><p>'+list[i].user_id + '</p>'
		                    str += " </div>"
		                    str += '</div></li>'
		                  }
					 if (list == null || list.length == 0) {			              
			              return
					 }
					$(".userList").html(str)
					$("#memberList").modal('show')
				},
				error:function(data){
					console.log("에러"+data)
				}
			})//end ajax
		 })//end click
		
		 $(".requestResultList").on("click","li",function(){
			 receiver_id=$(this).find('p').text()
			$("#memberName").val($(this).data('name'))
			$("#memberId").val($(this).find('p').text())		
		 })
		 
		 $(".userList").on("click","li",function(e){
			 var send_id="${info.user_id}"
			var receiver_id=$(this).find('p').text()
			$("#memberName").val($(this).data('name'))
			$("#memberId").val($(this).find('p').text())
			$("#memberInfo").modal('show')
			
		 })
		 	 
		 
		 $("#memberListCloseBtn").click(function(e){
			$("#memberList").modal('hide')
		 })
		 $("#memberInfoCloseBtn").click(function(e){
			$("#memberInfo").modal('hide')
		 })
		 $("#requestListCloseBtn").click(function(e){
			 $("#requestList").modal('hide')
		 })

		$("#friendRegistBtn").click(function(e){
			var send_id="${info.user_id}"
			var receiver_id=$("#memberId").val()
			if( confirm("친구요청을 보내시겠습니까?\n "
					+"이름  :  "+$("#memberName").val()+
					"\n아이디: "+receiver_id		
			 )){//확인 눌렀을시
				if(${info.user_id==null}){
					alert("비회원은 이용할 수 없습니다.")
					return false;
				}
			    
				else if("${info.user_id}"==receiver_id){
					alert("본인에게는 요청할 수 없습니다")
					return false
				}
			 
				else{$.ajax({
						type:'get',
						url:'/registFriend',
						contentType: 'application/json; charset=utf-8',
						data:{
							send_id:send_id,
							receiver_id:receiver_id,
						},
						success:function(data){
							alert(data)
							if(data.includes("성공")){
								sock.send(send_id+","+receiver_id+","+ "친구 요청")
							}
						}
					})
				}
				
			}
		})	
		$("#friendRequest").click(function(e){//친구요청 클릭시 요청목록이뜨는데 trigger를 사용해 보낸요청을 클릭한것으로 시작 
			e.preventDefault();
			$("#requestList").modal('show')
			$("#requestSent").trigger("click")
		})
	
		$("#requestReceived").click(function(e){//받은요청 클릭시
			 $(".requestResultList").html('')
				$(this).attr('class','btn btn-secondary')
				$("#requestSent").attr('class','btn btn-outline-secondary')
				
				$.ajax({
					type:'get',
					url: '/requestReceived',
					data:{
						"receiver_id":"${info.user_id}"				
					},
					success:function(data){
						var str=""
						for (var i = 0, len = data['memberList'].length || 0; i < len; i++) {	
		                    str += "<li class='left clearfix' data-name='" + data['memberList'][i].user_name + "' id='resultNameList' style='margin:4px' >"
		                    str += " <div><div class='header'><img src='/resources/images/basicProfileIcon.png' width='45px' /> "
		                    str += "<strong class='primary-font' >" + data['memberList'][i].user_name +'<div class="float-right" id="btns">'
		                    str += '<button class="btn btn-primary" id="accept" onclick="acceptClicked()">수락</button>'
				            str += '<button class="btn btn-danger" id="reject"  onclick="rejectClicked()">거절</button>'
				            str +='<button class="btn btn-secondary" id="block" onclick="blockClicked()">차단</button> </div>'
		                    str +='</strong><p>'+data['memberList'][i].user_id+'</p>'
		                    str += '</div></div></li>'
		                  }
						 if (data == null ||  data['requestList'].length == 0) {       
				              return
						 }
						$(".requestResultList").append(str)
					}
				})
		})
		$("#requestSent").click(function(e){//보낸요청 클릭시
			 $(".requestResultList").html('')
				$(this).attr('class','btn btn-secondary')
				$("#requestReceived").attr('class','btn btn-outline-secondary')
				
				$.ajax({
					type:'get',
					url: '/requestSent',
					data:{
						"send_id":"${info.user_id}"				
					},
					success:function(data){
						var str=""
						for (var i = 0, len = data['memberList'].length || 0; i < len; i++) {
						 	
		                    str += "<li class='left clearfix' data-name='" + data['memberList'][i].user_name + "' id='resultNameList' style='margin:4px' >"
		                    str += " <div><div class='header'><img src='/resources/images/basicProfileIcon.png' width='45px' /> "
		                    str += "<strong class='primary-font' >" + data['memberList'][i].user_name 
		                    str +='<div id="btns"><button class="btn btn-danger float-right" id="delete" onclick="deleteClicked()">취소</button></div>'
		                    str += '</strong><p>'+data['memberList'][i].user_id + '</p>'
		                    str += " </div>"
		                    str += '</div></li>'
		                  }
						 if (data == null ||  data['requestList'].length == 0) {
				              return
						 }
						$(".requestResultList").html(str)
					}
				})	
		})
			
	 })//end document

	 $("#friendList").click(function(e){
		$(".userList").html('')
		var str=""
		$.ajax({
			type:'get',
			url:'/getFriendList',
			data:{
				user_id:"${info.user_id}"
			},
			success:function(list){
				 for (var i = 0, len = list.length || 0; i < len; i++) { 	
	                    str += "<li class='left clearfix' data-name='" + list[i].user_name + "' id='resultNameList' style='margin:4px' >"
	                    str += " <div><div class='header'><img src='/resources/images/basicProfileIcon.png' width='45px' /> "
	                    str += "<strong class='primary-font' >" + list[i].user_name + '</strong><p>'+list[i].user_id + '</p>'
	                    str += " </div>"
	                    str += '</div></li>'
	                  }
				 if (list == null || list.length == 0) {			              
		              return
				 }
				$(".userList").html(str)
				$("#memberList").modal('show')
			},
			error:function(data){
				console.log("에러"+data)
			}
		})//end ajax
	  })
	  
	  $("#blockList").click(function(e){
		$(".userList").html('')
		var str=""
		$.ajax({
			type:'get',
			url:'/getBlockList',
			data:{
				user_id:"${info.user_id}"
			},
			success:function(list){
				 for (var i = 0, len = list.length || 0; i < len; i++) { 	
	                    str += "<li class='left clearfix' data-name='" + list[i].user_name + "' id='resultNameList' style='margin:4px' >"
	                    str += " <div><div class='header'><img src='/resources/images/basicProfileIcon.png' width='45px' /> "
	                    str += "<strong class='primary-font' >" + list[i].user_name + '</strong><p>'+list[i].user_id + '</p>'
	                    str += " </div>"
	                    str += '</div></li>'
	                  }
				 if (list == null || list.length == 0) {			              
		              return
				 }
				$(".userList").html(str)
				$("#memberList").modal('show')
			},
			error:function(data){
				console.log("에러"+data)
			}
		})//end ajax
	 
		
		
		
	 
	  })
	 $(document).on("click","button.ml-2",function(){//알람 x누르면 해당 알람 삭제 
		  $(this).parent().parent().remove()
		  console.log("눌림")
	  })
	 $(document).on("click","#msgRequestFriend",function(){//친구요청 바로가기버튼클릭시
		  $("#friendRequest").trigger('click')
		  $("#requestReceived").trigger('click')
		  $(this).parent().parent().remove()
		  console.log("눌림")
	 })
	  $(document).on("click","#msgMyFriend",function(){//친구요청 바로가기버튼클릭시
		  $("#friendList").trigger('click')
		  $(this).parent().parent().remove()
		  console.log("눌림")
	 }) 
	 

</script>
<body>
<div id="msgStack"></div>
</body>
</html> 


 


