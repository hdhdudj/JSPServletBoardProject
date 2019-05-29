// DBUtil.java의 기능이 제대로 작동하는지 확인하는 테스트 서블릿
package sbs.demo;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sbs.demo.util.DBUtil;

@WebServlet("/test/testDbLink")
public class testDbLink extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    DBUtil.DBLink dbLink = DBUtil.getNewDbLink();

    List<Map<String, Object>> articles = dbLink.getRows("SELECT * FROM article");
    System.out.println(articles);

    articles = dbLink.getRows("SELECT * FROM article LIMIT 2");
    System.out.println(articles);

    Map<String, Object> article = dbLink.getRow("SELECT * FROM article LIMIT 1");
    System.out.println(article);

    int count = dbLink.getRowIntValue("SELECT COUNT(*) FROM article LIMIT 1");
    System.out.println("COUNT : " + count);

    String title = dbLink.getRowStringValue("SELECT title FROM article LIMIT 1");
    System.out.println("title : " + title);

    dbLink.executeQuery("INSERT INTO article SET regDate = NOW(), title = 'test 제목', body = 'test 내용';");
    int id = dbLink.getLastInsertId();
    System.out.println(dbLink.getLastInsertId() + "번 글 추가됨");

    dbLink.executeQuery("DELETE FROM article WHERE id="+id+";");
    System.out.println(id + "번 글 삭제됨");
    
    dbLink.close();
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    // TODO Auto-generated method stub
    doGet(request, response);
  }

}