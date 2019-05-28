<%@page import="sbs.demo.util.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = request.getParameter("id");
	String sql = "SELECT * from article WHERE id='"+id+"';";

	DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
	Map<String, Object> article = dbLink.getRow(sql);	
	dbLink.executeQuery(sql);
%>
<html>
<head>
</head>
<body>
	<h1><%=id %>번 게시물</h1>
		<div>
			<a href="./list.jsp">글 목록</a>
			<a href="./doModify.jsp?id=<%=id %>">글 수정</a>
			<a href="./doDelete?id=<%=id %>">글 삭제</a>
		</div>
		<br>
		<div>
			<table border="5">
				<tbody>
					<tr>
						<th>번호</th>
						<td><%=article.get("id") %></td>
					</tr>
					<tr>
						<th>날짜</th>
						<td><%=article.get("regDate") %></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><%=article.get("title") %></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><%=article.get("body") %></td>
					</tr>
				</tbody>
			</table>
		</div>
</body>
</html>