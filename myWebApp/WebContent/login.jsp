<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Integrated Public Transport Navigation System</title>

<link rel="stylesheet" href="login.css" />

</head>
<body>
	<%
	String login = request.getParameter("login"),username="",password="";
	int error=0;
	
	// Click login
	if(login!=null)
	{
		username = request.getParameter("username");
		password = request.getParameter("password");
		
		// Class Driver
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		// Connect Database
		Connection mycon = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=IPTNS;user=sa;password=wee2534");
		// Query SQL
		Statement stmt = mycon.createStatement();
		// Check Username and Password
		String sql = "SELECT COUNT(*) AS num FROM member WHERE username = '"+username+"' AND password ='"+password+"' ";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next())
		{
			
			// Correct
			if(rs.getInt("num")==1 && username!="" && username.charAt(0)!=' ')
			{
				session.setMaxInactiveInterval(600); //600 secs = 10 mins
				session.setAttribute("auth",username);
				response.sendRedirect("index.jsp");
			}
			// Incorrect
			else
			{
				error = 1;
				out.println("<center><font color=red>Username or Password Incorrect</font></center>");
			}
		}
		rs.close();
		stmt.close();
		mycon.close();		
	}
	// Click login or Login incorrect
	if(login==null || error==1)
	{
%>
	<div id="big_container">
	<div id="container">
		<center>
		<form action="login.jsp" method="post">
		<table  cellpadding=2 cellspacing=1  width=400 height=200 border=0>
		<tr id=color1><td colspan=2><center><b>Please Login to Administrator System</b></center></td></tr>
		<tr id=color2><td><center>Username :</center></td>
				<td><center><input type=text  name="username" size=20></center></td></tr>
		<tr id=color2><td><center>Password :</center></td>
				<td><center><input type=password name="password" size=21></center></td></tr>
		<tr id=color2><td colspan=2><CENTER><input type=submit name=login value="Login">
				</CENTER></td></tr>
		</table>
		</form>
		</center>
	</div>
	</div>	
<%
	}
%>
</body>
</html>