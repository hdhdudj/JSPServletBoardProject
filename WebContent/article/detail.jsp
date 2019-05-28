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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
<style>
.article-replies-list tr .edit-mode-visible {
    display:none;
}

.article-replies-list tr.edit-mode .edit-mode-visible {
    display:block;
}

.article-replies-list tr.edit-mode .read-mode-visible {
    display:none;
}
.replymodify>textarea {
	display: block;
}
table tr > th {
	padding:10px;
} 
table tr > td {
	padding:10px;
} 
</style>
</head>
<body>
	<h1><%=id%>번 게시물
	</h1>
<script>
function enableEditMode(el) {
    var $el = $(el);
    var $tr = $el.closest('tr');
    $tr.addClass('edit-mode');
}

function disableEditMode(el) {
    var $el = $(el);
    var $tr = $el.closest('tr');
    $tr.removeClass('edit-mode');
}	
</script>
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
		<table border="5" class="article-replies-list">
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
					<td>
						<div class="read-mode-visible">
							<%=articleReply.get("body")%>
						</div>
						<div class="edit-mode-visible">
							<form class="replymodify" action="./doModifyReply" method="POST">
								<div>
									<textarea name="body" placeholder="댓글내용"><%=articleReply.get("body")%></textarea>
								</div>
								<div>
									<input type="submit" value="댓글수정"> <input
										onclick="disableEditMode(this);" type="reset" value="수정취소">
								</div>
								<input type="hidden" name="id"
									value="<%=articleReply.get("id")%>"> <input
									type="hidden" name="articleid"
									value="<%=articleReply.get("articleId")%>">
							</form>
						</div>
					</td>
					<td><a class="read-mode-visible" href="javascript:;"
						onclick="enableEditMode(this);">수정</a> <a
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