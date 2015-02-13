<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Weekly Meetings</title>
</head>

<body>


    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="classes_menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    // Load PostGreSQL Driver class file
                    Class.forName("org.postgresql.Driver");
    
                    // Make a connection to the datasource "cse132b"
                    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "postgres", "hardylou");
            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO WeeklyMeeting VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
 
                        pstmt.setInt(
                                1, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(2, request.getParameter("TYPE"));
                        pstmt.setString(3, request.getParameter("BUILDING"));
                        pstmt.setString(4, request.getParameter("ROOM"));
                        pstmt.setString(5, request.getParameter("START_TIME"));
                        pstmt.setString(6, request.getParameter("END_TIME"));
                        pstmt.setString(7, request.getParameter("ATTENDANCE"));
                        pstmt.setString(8, request.getParameter("START_DATE"));
                        pstmt.setString(9, request.getParameter("END_DATE"));
                        pstmt.setString(10, request.getParameter("MONDAY"));
                        pstmt.setString(11, request.getParameter("TUESDAY"));
                        pstmt.setString(12, request.getParameter("WEDNESDAY"));
                        pstmt.setString(13, request.getParameter("THURSDAY"));
                        pstmt.setString(14, request.getParameter("FRIDAY"));
                        pstmt.setString(15, request.getParameter("SATURDAY"));
                        pstmt.setString(16, request.getParameter("SUNDAY"));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE WeeklyMeeting SET TYPE = ?, BUILDING = ?, ROOM = ?, " + 
                            "START_TIME = ?, END_TIME = ?, ATTENDANCE = ?, START_DATE = ?, END_DATE = ?, " +
                            "MONDAY = ?, TUESDAY = ?, WEDNESDAY = ?, THURSDAY = ?, FRIDAY = ?, " +
                            "SATURDAY = ?, SUNDAY = ? WHERE ID = ?");

                        pstmt.setString(1, request.getParameter("TYPE"));
                        pstmt.setString(2, request.getParameter("BUILDING"));
                        pstmt.setString(3, request.getParameter("ROOM"));
                        pstmt.setString(4, request.getParameter("START_TIME"));
                        pstmt.setString(5, request.getParameter("END_TIME"));
                        pstmt.setString(6, request.getParameter("ATTENDANCE"));
                        pstmt.setString(7, request.getParameter("START_DATE"));
                        pstmt.setString(8, request.getParameter("END_DATE"));
                        pstmt.setString(9, request.getParameter("MONDAY"));
                        pstmt.setString(10, request.getParameter("TUESDAY"));
                        pstmt.setString(11, request.getParameter("WEDNESDAY"));
                        pstmt.setString(12, request.getParameter("THURSDAY"));
                        pstmt.setString(13, request.getParameter("FRIDAY"));
                        pstmt.setString(14, request.getParameter("SATURDAY"));
                        pstmt.setString(15, request.getParameter("SUNDAY"));
                        pstmt.setInt(
                                16, Integer.parseInt(request.getParameter("ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM WeeklyMeeting WHERE ID = ?");

                        pstmt.setInt(
                                1, Integer.parseInt(request.getParameter("ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM WeeklyMeeting");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Meeting ID</th>
                        <th>Type</th>
                        <th>Building</th>
                        <th>Room</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Attendance</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Mon</th>
                        <th>Tue</th>
                        <th>Wed</th>
                        <th>Thu</th>
                        <th>Fri</th>
                        <th>Sat</th>
                        <th>Sun</th>
                    </tr>
                    <tr>
                        <form action="weeklymeetings.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ID" size="10"></th>
                            <th><input value="" name="TYPE" size="5"></th>
                            <th><input value="" name="BUILDING" size="5"></th>
                            <th><input value="" name="ROOM" size="5"></th>
                            <th><input value="" name="START_TIME" size="10"></th>
                            <th><input value="" name="END_TIME" size="10"></th>
                            <th><input value="" name="ATTENDANCE" size="10"></th>
                            <th><input value="" name="START_DATE" size="10"></th>
                            <th><input value="" name="END_DATE" size="10"></th>
                            <th><input value="" name="MONDAY" size="5"></th>
                            <th><input value="" name="TUESDAY" size="5"></th>
                            <th><input value="" name="WEDNESDAY" size="5"></th>
                            <th><input value="" name="THURSDAY" size="5"></th>
                            <th><input value="" name="FRIDAY" size="5"></th>
                            <th><input value="" name="SATURDAY" size="5"></th>
                            <th><input value="" name="SUNDAY" size="5"></th>

                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="weeklymeetings.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("ID") %>" 
                                    name="ID" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("TYPE") %>" 
                                    name="TYPE" size="5">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("BUILDING") %>" 
                                    name="BUILDING" size="5">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("ROOM") %>" 
                                    name="ROOM" size="5">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("START_TIME") %>" 
                                    name="START_TIME" size="10">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("END_TIME") %>" 
                                    name="END_TIME" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("ATTENDANCE") %>" 
                                    name="ATTENDANCE" size="10">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("START_DATE") %>" 
                                    name="START_DATE" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("END_DATE") %>" 
                                    name="END_DATE" size="10">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("MONDAY") %>" 
                                    name="MONDAY" size="5">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("TUESDAY") %>" 
                                    name="TUESDAY" size="5">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("WEDNESDAY") %>" 
                                    name="WEDNESDAY" size="5">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("THURSDAY") %>" 
                                    name="THURSDAY" size="5">
                            </td>
                            
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("FRIDAY") %>" 
                                    name="FRIDAY" size="5">
                            </td>
                            
                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("SATURDAY") %>" 
                                    name="SATURDAY" size="5">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("SUNDAY") %>" 
                                    name="SUNDAY" size="5">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="weeklymeetings.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("ID") %>" name="ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>




</body>

</html>