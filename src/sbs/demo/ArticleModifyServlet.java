package sbs.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.util.*;

/**
 * Servlet implementation class ArticleModifyServlet
 */
@WebServlet("/article/doModify")
public class ArticleModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		String sql = "UPDATE article SET title='"+title+"', body = '"+body+"' WHERE id='"+id+"';";
		
		DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
		dbLink.executeQuery(sql);
		
		response.getWriter().append("<script>alert('"+id+"번 글이 수정되었습니다.')</script>");
		response.getWriter().append("<script>location.replace('./detail.jsp?id="+id+"')</script>");
	}

}
