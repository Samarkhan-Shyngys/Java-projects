<%@ page import="databean.UserBean" %>
<%@ page import="databean.PostBean" %>
<%@ page import="databean.CommentBean" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Visitor</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="styles/mycss.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    
</head>
<body>


<%
		UserBean user = (UserBean) session.getAttribute("user");
		String userName = null;
		String loggedEmail = null;
		if (user != null) {
			userName = user.getFirstName();
			loggedEmail = user.getEmail();
			
		}
		UserBean currentUser = (UserBean) request.getAttribute("currentUser");
		String currentUserName = currentUser.getFirstName();
		UserBean[] users = (UserBean[]) request.getAttribute("users");
%>		
	

<header class="blog-header py-3 bg-secondary">
    	<div class="row flex-nowrap justify-content-between align-items-center">
    	      
      		<c:choose>
                <c:when test="${ sessionScope.user != null }">
                	<div class="col-4 pt-1">
                		<a href="home.do" class="btn">Home</a>
    				</div>
    				<div class="col-4 text-center">
      					<h2 class="blog-header-logo text-white">BLOG</h2>
      				</div>
    				<div class="col-4 d-flex justify-content-end align-items-center">
    					<form class="form-inline my-2 my-lg-0" action="logout.do" method="post">
           					 <button class="btn  my-2 my-sm-0" type="submit">Logout</button>
        				</form>
      					
      				</div>
                    
                    
                </c:when>
                <c:otherwise>
                	<div class="col-4 pt-1">
                		<a href="index.jsp" class="btn">Login</a>
    				</div>
    				<div class="col-4 text-center">
      					<h2 class="blog-header-logo text-white">BLOG</h2>
      				</div>
    				<div class="col-4 d-flex justify-content-end align-items-center">
      					<a href="register.do" class="btn">Register</a>
      				</div>
                </c:otherwise>
            </c:choose>
            
    	</div>
</header>

<div class="mt-50">
	<div class="row flex-nowrap justify-content-between align-items-center">
      <div class="col-3 pt-1 ol-3 align-self-start border border-light">
        
		<div class="p-4 align-self-start">
        <h4 class="fst-italic">Users</h4>
        <ol class="list-unstyled mb-0">
        
        	
			<c:if test="${!(empty users)}">
	            		<c:forEach var="otherUser" items="${users}">
						<form method="POST" action="visitor.do">
							<button class="dropdown-item" type="submit">${ otherUser.firstName }</button>
							<input type="hidden" name="email" value="${ otherUser.email }">
						</form>
	                </c:forEach>
        	</c:if>
         
        </ol>
      </div>
      </div>
      
      <div class="col-10 align-self-start mt-50">
      	<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
        
        			
        <c:if test="${!(empty errors)}">
	            		<c:forEach var="error" items="${errors}">
						<h3 class="error setMargin myPage"> ${ error } </h3>
	                </c:forEach>
        			</c:if>

        
            	<div class="col-md-6">
            		<h1 class="setMargin myPage"> <%=currentUserName %>'s posts </h1>
       		    </div>
        </div>
        <div class="col-md-3"></div>
    </div>
    
    <div class="row"> 
        <div class="col-md-2"></div>
        <div class="col-md-8">
        	<div class="col-10 align-self-start mt-50">
        		<%
        				PostBean[] posts = (PostBean[]) request.getAttribute("posts");
			        for (int i = 0; i < posts.length; i++) {
			            PostBean post = posts[i];
			            String content = post.getContent();
			            Date date = post.getDate();
			            int id = post.getId();
			%>
			
						<textarea class="post" rows="5" cols="55" readonly><%=content %></textarea>
						<p>Post by <a href="#"><%=currentUserName %></a> <%=date %></p>			
			        
			            
			            
			<%
						CommentBean[] comments = (CommentBean[]) request.getAttribute("comments");
						if (comments != null) {
							for (CommentBean comment : comments) {
								if (comment.getPostId() == id) {
									String commentContent = comment.getContent();
									Date commentDate = comment.getDate();
									String commentEmail = comment.getEmail();
									
									int commentId = comment.getId();
			%>
			
					<div class="row comment">
    					<div class="col-md-2"></div>
    						<div class="col-md-10">
        						<textarea class="post" rows="2" cols="40" readonly><%=commentContent %></textarea>
        						<p>Comment by <a href="#"><%=commentEmail %></a> <%=commentDate %></p>
        

								
      							<%
									if (commentEmail.equals(loggedEmail)) {
								%>
									<form method="POST" action="deleteComment.do">
									<button type="submit" class="btn btn-primary a-btn-slide-text deleteBtn setMargin">
									<span><strong>Delete</strong></span>
									</button>
									<input type="hidden" name="id" value="<%= commentId %>">
									</form>
<%
		}
%>
		
		
    					 </div>
					</div>
			<%
								}
							}
						}%>
						<form class="form-signin" method="POST" action="addComment.do">
							<div class="row comment">
	    						<div class="col-md-2"></div>
	    							<div class="col-md-10">
	       							 <textarea class="post" rows="2" cols="40" name="comment"></textarea>
	        							<div class="setMargin">
	    									<button id="CommentButton" class="btn btn-outline-success my-2 my-sm-0" type="submit" name="button" value="commentButton">Comment</button>
										</div>
	    							</div>
							</div>
							<input type="hidden" name="id" value="<%=id %>">
						</form>
						
						
						
			<% 			
			        }
			%>
			
			
			
        </div>

        		
        		

        		
        		
        	</div>
        
    	</div>
	</div>
      	
      	
		
        
		
      </div>
     
    </div>  
	
</div>




<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</body>
</html>