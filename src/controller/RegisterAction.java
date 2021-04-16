package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.genericdao.DuplicateKeyException;
import org.genericdao.RollbackException;

import databean.UserBean;
import formbean.RegisterForm;
import model.Model;
import model.UserDAO;

public class RegisterAction extends Action {
	private UserDAO userDAO;
	
    public RegisterAction(Model model) {
        userDAO = model.getUserDAO();
    }
    
    public String getName() {
        return "register.do";
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
            return "Register.jsp";
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
            RegisterForm form = new RegisterForm(request);
            request.setAttribute("form", form);
            
            request.setAttribute("users", userDAO.getUsers());
            
            errors.addAll(form.getValidationErrors());
            
            if (errors.size() != 0) {
                return "Register.jsp";
            }
            
            UserBean user = new UserBean();
            user.setEmail(form.getEmail());
            user.setPassword(form.getPassword1());
            user.setFirstName(form.getFirstName());
            user.setLastName(form.getLastName());
            try {
                userDAO.create(user);
                session.setAttribute("user", user);
                return ("home.do");
            } catch (DuplicateKeyException e) {
                errors.add("Email already exists!!!");
                return "Register.jsp";
            }

        } catch (RollbackException e) {
            errors.add(e.getMessage());
            return "error.jsp";
        }
    }
}
