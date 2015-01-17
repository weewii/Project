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
	//String confirm = request.getParameter("confirm");
	String strUsername = request.getParameter("username");
	//if(confirm!=null)
	//{
	//Class Driver
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	//Connect Database
	Connection mycon = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=IPTNS;user=sa;password=wee2534");
	//Query SQL
	Statement stmt = mycon.createStatement();
		
	String sql = "DELETE FROM member " + " WHERE username = '" + strUsername + "' ";
		stmt.executeUpdate(sql);
		response.sendRedirect("member_delete.jsp");

	//}
%>	

<div id="big_container">
	<div id="container">
		<center>
		<form action="delete.jsp" method="post">
		<table  cellpadding=2 cellspacing=1  width=400 height=200 border=0>
		<tr id=color1><td colspan=2><center><b>Confirm to Delete</b></center></td></tr>
		<tr id=color2><td colspan=2><CENTER><input type=submit name=confirm value="Confirm">
				</CENTER></td></tr>
		</table>
		</form>
		</center>
	</div>
</div>	

</body>
</html>