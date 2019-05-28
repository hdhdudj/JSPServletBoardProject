package sbs.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.util.DBUtil;

/**
 * Servlet implementation class ArticleModifyReplyServlet
 */
@WebServlet("/article/doModifyReply")
public class ArticleModifyReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String articleid = request.getParameter("articleid");
        String id = request.getParameter("id");
        String body = request.getParameter("body");
        
        if (body == null) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
            return;
		}

		body = body.trim();

		if (body.length() == 0) {
			response.getWriter().append("<script> alert('내용을 입력해주세요.'); history.back(); </script>");
            return;
		}

		body = body.replaceAll("\'", "\\\\'");
        
        DBUtil.DBLink dbLink = DBUtil.getNewDbLink();
        String sql = "UPDATE articleReply SET body = '"+body+"' WHERE id='"+id+"';";
        dbLink.executeQuery(sql);
        
        response.getWriter().append("<script>alert('댓글이 수정되었습니다.')</script>");
        response.getWriter().append("<script>location.replace('./detail.jsp?id="+articleid+"')</script>");
	}

}
