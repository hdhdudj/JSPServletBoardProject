<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="sbs.demo.util.DBUtil"%>
<!DOCTYPE html>
<%
	String id = request.getParameter("id");
	DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
	String sql = "SELECT id, title, body FROM article WHERE id='"+id+"';";
	Map<String, Object> article = dbLink.getRow(sql);
%>
<html>
<title>게시물 수정</title>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="./doModify" method="POST">
			<input type="hidden" name="id" value="<%=article.get("id")%>">
        	<div><input value="<%=article.get("title")%>" type="text" name="title" placeholder="제목"></div>
        	<div><textarea name="body" placeholder="내용"><%=article.get("body")%></textarea></div>
        	<div>
            <input type="submit" value="수정">
            <input type="button" value="취소" onclick="location.href = './detail.jsp?id=<%=id%>';">
        </div>
		</form>
	</div>
</body>
</html>