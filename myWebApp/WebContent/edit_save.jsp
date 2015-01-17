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

<link rel="stylesheet" href="member.css" />

</head>
<body>
<%	
	//Authentication
	if(session.getAttribute("auth")==null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
%>

<%
	String strUserID = request.getParameter("UserID");
	String strUsername = request.getParameter("txtUsername");
	String strPassword = request.getParameter("txtPassword");
	
	//Class Driver
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	//Connect Database
	Connection mycon = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=IPTNS;user=sa;password=wee2534");
	//Query SQL
	Statement stmt = mycon.createStatement();
	
	String sql = "UPDATE member SET username = '"+ strUsername + "' " + ", password = '"+ strPassword + "' "+" WHERE username = '" + strUserID + "' ";
    
	stmt.execute(sql);
	
	response.sendRedirect("member.jsp");
	
	
%>

</body>
</html>