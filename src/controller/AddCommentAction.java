package controller;

import model.Model;
import model.PostDAO;

import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.genericdao.RollbackException;

import databean.PostBean;
import databean.UserBean;
import databean.CommentBean;
import formbean.CommentForm;
import formbean.PostForm;
import model.CommentDAO;
import model.UserDAO;

public class AddCommentAction extends Action {
    private PostDAO postDAO;
    private CommentDAO commentDAO;
    private UserDAO userDAO;

    public AddCommentAction(Model model) {
    		postDAO = model.getPostDAO();
    		commentDAO = model.getCommentDAO();
    		userDAO = model.getUserDAO();
    }

    public String getName() {
        return "addComment.do";
    }
    
    public String performPost(HttpServletRequest request) {
        List<String> errors = new ArrayList<String>();
        request.setAttribute("errors", errors);

        try {
            
            request.setAttribute("comments", commentDAO.getComments(request));
            request.setAttribute("posts", postDAO.getPosts(request));

            CommentForm form = new CommentForm(request);
            request.setAttribute("form", form);

            errors.addAll(form.getValidationErrors());
            if (errors.size() > 0) {
                return "HomePage.jsp";
            }

            CommentBean bean = new CommentBean();
            bean.setContent(form.getContent());
            java.util.Date now = new java.util.Date();
            bean.setDate(new Date(now.getTime()));
            bean.setEmail(((UserBean) request.getSession().getAttribute("user")).getEmail());
            bean.setPostId(Integer.parseInt(form.getPostId()));

            commentDAO.create(bean);

          
            request.setAttribute("posts", postDAO.getPosts(request));
    			request.setAttribute("comments", commentDAO.getComments(request));
            request.setAttribute("users", userDAO.getUsers());
            

            return "HomePage.jsp";

        } catch (RollbackException e) {
            errors.add(e.getMessage());
            return "error.jsp";
        }
    }
}
