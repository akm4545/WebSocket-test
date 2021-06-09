<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
	<!-- 소켓 라이브러리 추가 script 부분에서 socket 관련 함수 사용 -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
	<input type="text" id="message" />
	<input type="button" id="sendBtn" value="submit"/>
	<div id="messageArea"></div>
</body>
<script>
	$("#sendBtn").click(function(){
		sendMessage();
		$('#message').val('')
	});
	
	/* 통신을 위한 대상 url로 생성 핸들러 매핑 주소 */
	let sock = new SockJS("http://localhost:9090/test/echo/");
	/* 메세지를 받을때 호출할 함수 */
	sock.onmessage = onMessage;
	/* 연결이 끊길 때 호출할 함수 */
	sock.onclose = onClose;
	
	/* 메세지 보내기 */
	function sendMessage(){
		sock.send($("#message").val());
	}
	/* 메세지 받기 */
	function onMessage(msg){
		var data = msg.data;
		$("#messageArea").append(data + "<br/>");
	}
	/* 서버와 연결 끊기 */
	function onClose(evt){
		$("#messageArea").append("연결 끊김");
	}
</script>
</html>
