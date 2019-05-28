package sbs.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.util.DBUtil;

/**
 * Servlet implementation class ArticleDeleteServlet
 */
@WebServlet("/article/doDelete")
public class ArticleDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String sql = "DELETE FROM article WHERE id='"+id+"';";
		
		DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
		dbLink.executeQuery(sql);
		dbLink.close();
		
		response.getWriter().append("<script>alert('"+id+"번 게시물이 삭제되었습니다.');</script>");
		response.getWriter().append("<script>location.replace('./list.jsp');</script>");		
	}
}
