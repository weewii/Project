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
	
<ul id="sddm">
    <li><a href="index.jsp" >Home</a></li>   
    <li><a href="member.jsp" 
        onmouseover="mopen('m1')" 
        onmouseout="mclosetime()">Member Data</a>
        <div id="m1" 
            onmouseover="mcancelclosetime()" 
            onmouseout="mclosetime()">
        <a href="member_insert.jsp">Insert Data</a>
        <a href="member_edit.jsp">Edit Data</a>
        <a href="member_delete.jsp">Delete Data</a>
        </div>
    </li>
    <li><a href="transport.jsp"
    	onmouseover="mopen('m2')" 
        onmouseout="mclosetime()">Transport Data</a>
        <div id="m2" 
            onmouseover="mcancelclosetime()" 
            onmouseout="mclosetime()">
        <a href="type_of_travel.jsp">Type of Travel</a>     	
        <a href="cost_of_travel.jsp">Cost of Travel</a>
        </div>
    </li>
    <li><a href="logout.jsp">Logout</a></li>
</ul>
<div style="clear:both"></div>

<script>

var timeout	= 500;
var closetimer	= 0;
var ddmenuitem	= 0;

// open hidden layer
function mopen(id)
{	
	// cancel close timer
	mcancelclosetime();

	// close old layer
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';

	// get new layer and show it
	ddmenuitem = document.getElementById(id);
	ddmenuitem.style.visibility = 'visible';

}
// close showed layer
function mclose()
{
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
}

// go close timer
function mclosetime()
{
	closetimer = window.setTimeout(mclose, timeout);
}

// cancel close timer
function mcancelclosetime()
{
	if(closetimer)
	{
		window.clearTimeout(closetimer);
		closetimer = null;
	}
}

// close layer when click-out
document.onclick = mclose; 

</script>

<%
	
	if(session.getAttribute("auth")==null)
	{
		//session.setMaxInactiveInterval(600); //600 secs = 10 mins
		response.sendRedirect("login.jsp");
		return;
	}
	
%>
<ul id="message">
	
</ul>

<%	
	//Authentication
	if(session.getAttribute("auth")==null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
%>

<% 
	String insert = request.getParameter("insert"),username="",password="";
	String cancel = request.getParameter("cancel");

	username = request.getParameter("username");
	password = request.getParameter("password");
	
	
	if(insert!=null && username!="" && username.charAt(0)!=' ' && password!="" && password.charAt(0)!=' ')
	{		
		username = request.getParameter("username");
		password = request.getParameter("password");
		//Class Driver
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		//Connect Database
		Connection mycon = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=IPTNS;user=sa;password=wee2534");
		//Query SQL
		Statement stmt = mycon.createStatement();
		//Insert Username and Password
		String sql = "INSERT INTO member VALUES('"+username+"','"+password+"')";
		
		stmt.executeUpdate(sql);
		
		session.setAttribute("insert","ok");
		response.sendRedirect("member.jsp");
		
		stmt.close();
		mycon.close();
	}
	else if(cancel!=null)
	{
		response.sendRedirect("member.jsp");
		//out.println("<center><font color=red>Please Insert Data </font></center>");
	}
	
	

%>
	<div id="big_container">
	<div id="container">
		<center>
		<form action="member_insert.jsp" method="post">
		<table  cellpadding=2 cellspacing=1  width=400 height=200 border=0>
		<tr id=color1><td colspan=2><center><b>Please Insert Data</b></center></td></tr>
		<tr id=color2><td><center>Username :</center></td>
				<td><center><input type=text  name="username" size=20></center></td></tr>
		<tr id=color2><td><center>Password :</center></td>
				<td><center><input type=text name="password" size=21></center></td></tr>
		<tr id=color2><td colspan=2><CENTER><input type=submit name=insert value="Insert">
				<input type="submit" name=cancel value="Cancel">
				</CENTER></td></tr>
				
		</table>
		</form>
		</center>
	</div>
	</div>	

</body>
</html>