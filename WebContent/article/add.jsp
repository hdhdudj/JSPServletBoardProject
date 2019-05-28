<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 생성</title>
<style>
	h1 {
		font-family:"궁서체";
		color:red;
	}
	.title > input {
		width:300px;
	}
	.textarea > textarea{
		width:300px;
		height:150px;
	}
</style>
</head>
<body>
	<h1>게시물 생성</h1>
	<form action="./doAdd" method="POST">
		<div class="title">
			<label for="title"></label> 
			<input type="text" name="title" placeholder="제목을 입력해주세요.">
		</div>
		<div class="textarea">
			<textarea name="body" placeholder="내용을 입력해주세요." style="overflow:auto"
			></textarea>
		</div>
		<div class="button">
			<button type="submit">작성</button>
			<input type="button" value="취소" onClick="location.replace('./list.jsp')">
		</div>
 	</form>
</body>
</html>