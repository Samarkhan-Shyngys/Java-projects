package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Action;
import controller.Controller;
import databean.UserBean;
import controller.RegisterAction;
import controller.LoginAction;
import controller.LogoutAction;
import controller.HomeAction;
import model.Model;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public void init() throws ServletException {
        Model model = new Model(getServletConfig());

        Action.add(new LoginAction(model));
        Action.add(new RegisterAction(model));
        Action.add(new LogoutAction(model));
        Action.add(new HomeAction(model));
        Action.add(new VisitorAction(model));
        Action.add(new AddPostAction(model));
        Action.add(new DeletePostAction(model));
        Action.add(new AddCommentAction(model));
        Action.add(new DeleteCommentAction(model));
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nextPage = performTheAction(request);
        sendToNextPage(nextPage, request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
   
    private String performTheAction(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String servletPath = request.getServletPath();
        UserBean user = (UserBean) session.getAttribute("user");
        String action = getActionName(servletPath);

        if (user != null) {
            
            return Action.perform(action, request);
        }
        
        if (action.equals("login.do")) {
            return Action.perform("login.do", request);
        }
        
        if (action.equals("register.do")) {
            return Action.perform("register.do", request);
        }
        
        if (action.equals("visitor.do")) {
            return Action.perform("visitor.do", request);
        }
        
      return "actionERROR.jsp";
    }

    
    private void sendToNextPage(String nextPage, HttpServletRequest request,
            HttpServletResponse response) throws IOException, ServletException {
        if (nextPage == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    request.getServletPath());
            return;
        }

        if (nextPage.endsWith(".do")) {
            response.sendRedirect(nextPage);
            return;
        }

        if (nextPage.endsWith(".jsp")) {
            RequestDispatcher d = request.getRequestDispatcher("WEB-INF/"
                    + nextPage);
            d.forward(request, response);
            return;
        }

        throw new ServletException(Controller.class.getName()
                + ".sendToNextPage(\"" + nextPage + "\"): invalid extension.");
    }

  
    private String getActionName(String path) {
        
        int slash = path.lastIndexOf('/');
        return path.substring(slash + 1);
    }

}
