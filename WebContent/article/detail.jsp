<%@page import="sbs.demo.util.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String sql = "SELECT * FROM article ORDER BY id DESC";
    DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
    List<Map<String, Object>> articles = dbLink.getRows(sql);
    int replynumber = 0;
%>
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<head>
<style>
.titlelink div {
    display:inline-block;
}
.titlelink  {
    text-decoration:none;
}
table td {
    padding:20px;
}
.chat-box{
    border:2px solid black; 
    display: block;
    width:350px;
    height:400px;
    overflow-y:scroll;
    scroll-behavior:smooth;
    display:block;
}
.chat-messages {
    padding:10px;
}
.chat-form>form>div {
    padding: 2px 0;
}

.chat-form>form>div>span {
    margin-right:10px;
}

.part1 {
    float: left;
    width: 70%;
}
.part1 table {
    margin:0 15%;
}
.part1 h1 {
    margin:0 15%;
}
.part1 > .jaksung a{
    margin:0 15%;
    text-decoration:none;
    font-size:1.4rem;
    font-family:D2coding;
    color:inherit;
}
.part1 > .jaksung a:hover{
    color:white;
    background-color:black;
}
.part2 {
    float: right;
    width: 30%
}


.a1 {
    font-size: 3rem;
    font-family: Yj INITIALPOSITIVE;
    color: red;
}

.a2 {
    font-size:2rem;
    font-family:"굴림체";
    font-weight:bold;
    color: orange;
}

.a3 {
    font-size: 4rem;
    font-family: "바탕체";
    font-weight: bold;
    color: gold;
}

.a4 {
    font-size: 3rem;
    font-family: D2coding;
    font-weight: bold;
    color: green;
}

.a5 {
    font-size: 5rem;
    font-family: Yj WADAG;
    font-weight: bold;
    color: blue;
}

.a6 {
    font-size: 2rem;
    font-family: "궁서체";
    font-weight: bold;
    color: purple;
}
</style>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<script>
    var objDiv = document.getElementById("chatbox"); 
    objDiv.scrollTop = objDiv.scrollHeight;
    
    function sendChatMessage(form) {
        // 양옆 공백제거
        // trim => 공백제거 함수
        form.writer.value = form.writer.value.trim();

        if (form.writer.value.length == 0) {
            alert('이름을 입력해주세요.');
            form.writer.focus();

            return;
        }

        // 양옆 공백제거
        // trim => 공백제거 함수
        form.body.value = form.body.value.trim();

        if (form.body.value.length == 0) {
            alert('내용을 입력해주세요.');
            form.body.focus();

            return;
        }

        var writer = form.writer.value;
        var body = form.body.value;

        form.body.value = '';
        form.body.focus();

        $('.chat-messages').append('<div>' + writer + ' : ' + body + '</div>');
        // $('.chat-messages').prepend('<div>' + writer + ' : ' + body + '</div>''); // 위와 같다.
    }
</script>
<body>
    <div class="part1">
        <h1>
            <a class="titlelink" href="./list.jsp">
                <div class="a1">게</div>
                <div class="a2">시</div>
                <div class="a3">물</div>
                &nbsp;
                <div class="a4">리</div>
                <div class="a5">스</div>
                <div class="a6">트</div>
            </a>
        </h1>

        <div class="jaksung">
            <a href="./add.jsp">작성하기</a>
        </div>
        <br>
        <%
            ArrayList<Integer> arr = new ArrayList<>();
        %>
        <form action="./doAdd">
            <table border="5">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>날짜</th>
                        <th>제목</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < articles.size(); i++) {
                            Map<String, Object> article = articles.get(i);
                            sql = "SELECT count(*) FROM articleReply WHERE articleId =" + article.get("id");
                            replynumber = dbLink.getRowIntValue(sql);
                            dbLink.close();
                    %>
                    <tr>
                        <td><%=article.get("id")%><input type="hidden" name="id"
                            value="<%=article.get("id")%>"></td>
                        <td><%=article.get("regDate").toString().substring(0,19)%></td>
                        <td><a href="./detail.jsp?id=<%=article.get("id")%>"><%=article.get("title")%>(<%=replynumber%>)</a></td>
                        <td><a href="./doDelete?id=<%=article.get("id")%>">삭제</a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </form>
    </div>
    <div class="part2">
        <h1>랜덤 채팅(서버 연결 안돼있어서 형태만 있음^^;)</h1>
        <div class="chat-box" id="chat-box" style="overflow:auto">
            <div class="chat-messages"></div>
        </div>
        <br>
        <div class="chat-form">
            <form onsubmit="sendChatMessage(this); return false;">
                <!-- div*3>span+input -->
                <div>
                    <span>이름</span><input type="text" name="writer"
                        placeholder="이름을 입력해주세요.">
                </div>
                <div>
                    <span>내용</span><input type="text" name="body"
                        placeholder="내용을 입력해주세요.">
                </div>
                <div>
                    <span>입력</span><input type="submit" value="입력">
                </div>
            </form>
        </div>
    </div>
</body>

</html>