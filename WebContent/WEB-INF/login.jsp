<%@ page import="databean.UserBean" %>
<%@ page import="java.util.List" %>
<%@ page import="formbean.LoginForm" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>login</title>
    <!-- Bootstrap CSS --> 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="styles/mycss.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    
</head>
<body>


<%
	UserBean[] users = (UserBean[]) request.getAttribute("users");
%>

<header class="blog-header py-3 bg-secondary">
    	<div class="row flex-nowrap justify-content-between align-items-center">
    	      
      		
                	<div class="col-4 pt-1">
                		<a href="login.do" class="btn">Login</a>
    				</div>
    				<div class="col-4 text-center">
      					<h2 class="blog-header-logo text-white">BLOG</h2>
      				</div>
    				<div class="col-4 d-flex justify-content-end align-items-center">
      					<a href="register.do" class="btn">Register</a>
      				</div>
              
    	</div>
	</header>







<% 		
		LoginForm form = (LoginForm) request.getAttribute("form");
		String email = null;
		if (form != null) {
			email = form.getEmail();
		}
%>


      
      <div class="col-3">
      	 <form class="form-signin" action="login.do" method="post">
                    <h2 class="form-signin-heading setMargin">Sign in</h2>
                    <!-- <label for="inputEmail" class="sr-only">Email address</label> -->
					
				
                    <input type="email" class="form-control setMargin" placeholder="Email address" name="email"   required autofocus>
                    
                    
                    <input type="password" class="form-control setMargin" placeholder="Password" name="password" required>
                    
                    <div class="setMargin">
                        <button class="btn btn-primary btn-sm" type="submit" name="button" value="Login">Login
                        </button>
                    </div>

                  
                </form>
		
        
		
      </div>
      <div class="col-4">
      <%
		List<String> errors = (List<String>) request.getAttribute("errors");
		if (errors != null) {
			for (String error : errors) {
%>		
				<p style="color:red"> <%= error %> </p>
<%
			}
		}
%>

      </div>
    



<footer class="footer fixed-bottom py-3 bg-light" >
    
</footer>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
</body>
</html>