package sbs.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.util.DBUtil;

/**
 * Servlet implementation class ArticleAddReplyServlet
 */
@WebServlet("/article/doAddReply")
public class ArticleAddReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
		
		String articleid = request.getParameter("id");
		String body = request.getParameter("body");
		
		String sql = "INSERT INTO articleReply SET regDate=NOW(), body='"+body+"', articleId='"+articleid+"';";
		
		DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
		dbLink.executeQuery(sql);
		
		
		dbLink.close();
		
		response.getWriter().append("<script>alert('댓글이 작성되었습니다.');</script>");
		response.getWriter().append("<script>location.replace('./detail.jsp?id="+articleid+"');</script>");
	}
}
