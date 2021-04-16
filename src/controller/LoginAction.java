package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.genericdao.RollbackException;

import databean.UserBean;
import formbean.LoginForm;
import model.Model;
import model.UserDAO;

public class LoginAction extends Action {
	private UserDAO userDAO;
	
    public LoginAction(Model model) {
        userDAO = model.getUserDAO();
    }
    
    public String getName() {
        return "login.do";
    }
    
    public String performGet(HttpServletRequest request) {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            return "home.do";
        }
        
        
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors", errors);
        try {
            request.setAttribute("users", userDAO.getUsers());
            return "login.jsp";
        } catch (RollbackException e) {
            errors.add(e.getMessage());
            return "error.jsp";
        }
        
    }
    
    public String performPost(HttpServletRequest request) {
       
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            return "home.do";
        }
        
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors", errors);
        
        try {
            LoginForm form = new LoginForm(request);
            request.setAttribute("form", form);
            
            request.setAttribute("users", userDAO.getUsers());
            
            errors.addAll(form.getValidationErrors());
            
            if (errors.size() != 0) {
            		return "login.jsp";
            }
            
            if (form.getButton().equals("Register")) {
                return "register.do";
            }
           
            UserBean user = userDAO.read(form.getEmail()); 
            if (user == null) {
                errors.add("Please register first");
                return "login.jsp";
            }

            if (!form.getPassword().equals(user.getPassword())) {
                errors.add(" password is incorrect!!!");
                return "login.jsp";
            }
           
            session.setAttribute("user", user);
            return "home.do";

        } catch (RollbackException e) {
            errors.add(e.getMessage());
            return "error.jsp";
        }
    }
}
