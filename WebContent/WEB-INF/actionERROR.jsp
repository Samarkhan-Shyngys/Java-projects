<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>Session Error</title>
    </head>
    
	<body>

        <h2>Abstract Action Class Error Message</h2>
        

        <h3 style="color:red"> ${ message } </h3>
        
        <p>
            Normally, in deployment, we would probably send back an
            error code in the HTTP response (like 404 -- Not Found)
            but to facilitate debugging, since you've probably made a
            mistake during development, we're providing the error
            message, above.
        </p>
        
        <h2>Controller Stale Session Error</h2>
                
        <p>
            You are attempting to run an action that requires you
            to be logged in.  Perhaps you were logged in, but
            inactive for so long that your session timed out.
            You will need to login again.
        </p>
        <p>
            Click <a href="login.do">here</a> to login.
        </p>

	</body>
</html>