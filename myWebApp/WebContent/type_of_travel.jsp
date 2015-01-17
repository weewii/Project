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

<link rel="stylesheet" href="index.css" />

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

<% 
		// Class Driver
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		// Connect Database
		Connection mycon = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=IPTNS;user=sa;password=wee2534");
		// Query SQL
		Statement stmt = mycon.createStatement();
		// Check link_trans_type
		String sql = "SELECT trans_type_name FROM trans_type ORDER BY trans_type_name";
		ResultSet rs = stmt.executeQuery(sql);
%>

<ul id="message">
		Type of Travel : &nbsp;
		<select>
		<%while((rs!=null) && (rs.next())) { %>
				  <tr id=color2>
				    <td><option><%=rs.getString("trans_type_name")%></option></td>		
				  </tr>
	    <%}%>
		</select>

	


</ul>

</body>
</html>