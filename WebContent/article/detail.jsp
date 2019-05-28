<%@page import="sbs.demo.util.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	String sql = "SELECT * from article WHERE id='" + id + "';";

	DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
	Map<String, Object> article = dbLink.getRow(sql);
	dbLink.executeQuery(sql);

	sql = "SELECT * from articleReply WHERE articleId='" + id + "';";
	List<Map<String, Object>> articles = dbLink.getRows(sql);
	dbLink.executeQuery(sql);
	dbLink.close();
%>
<html>
<title><%=id%>번 게시물</title>
<head>
</head>
<body>
	<h1><%=id%>번 게시물
	</h1>
	<div>
		<a href="./list.jsp">글 목록</a> <a href="./modify.jsp?id=<%=id%>">글
			수정</a> <a href="./doDelete?id=<%=id%>">글 삭제</a>
	</div>
	<br>
	<div>
		<table border="5">
			<tbody>
				<tr>
					<th>번호</th>
					<td><%=article.get("id")%></td>
				</tr>
				<tr>
					<th>날짜</th>
					<td><%=article.get("regDate")%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><%=article.get("title")%></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><%=article.get("body")%></td>
				</tr>
			</tbody>
		</table>
	</div>
	<h2>댓글</h2>
	<div>
		<%
			if (articles.size() > 0) {
		%>
		<table border="5">
			<thead>
				<tr>
					<td>번호</td>
					<td>날짜</td>
					<td>내용</td>
					<td>비고</td>
				</tr>
			</thead>
			<tbody>
				<%
					for (int i = 0; i < articles.size(); i++) {
							Map<String, Object> articleReply = articles.get(i);
				%>

				<tr>
					<td><%=articleReply.get("id")%></td>
					<td><%=articleReply.get("regDate")%></td>
					<td><%=articleReply.get("body")%></td>
					<td><a
						href="./doDeleteReply?id=<%=articleReply.get("id")%>">삭제</a></td>
				</tr>
				<%
					}
					} else {
				%>
				댓글이 없습니다.
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<br>
	<h3>댓글 작성</h3>
	<form action="./doAddReply" method="POST">
		<div>
			<textarea type="text" name="body" placeholder="댓글 내용을 입력하세요"></textarea>
		</div>
		<div>
			<input type="hidden" name="id" value="<%=article.get("id")%>">
		</div>
		<button type="submit">제출</button>
		<button type="reset">리셋</button>
	</form>
</body>
</html>