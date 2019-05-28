package sbs.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.util.DBUtil;

/**
 * Servlet implementation class ArticleDeleteReplyServlet
 */
@WebServlet("/article/doDeleteReply")
public class ArticleDeleteReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String replyid = request.getParameter("id");
        DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
        String sql = "SELECT articleId from articleReply WHERE id='"+replyid+"';";
        dbLink.executeQuery(sql);
        int articleid = dbLink.getRowIntValue(sql);
        
        sql = "DELETE FROM articleReply WHERE id='"+replyid+"';";
        dbLink.executeQuery(sql);

        dbLink.close();
        
        response.getWriter().append("<script>alert('댓글이 삭제되었습니다.')</script>");
        response.getWriter().append("<script>location.replace('./detail.jsp?id="+articleid+"')</script>");
	}

}
