<%@page import="javax.swing.JOptionPane"%> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <%@ include file="head.jsp" %>
<body class="container my-3">
    <h1 class="text-center">Update</h1>
    <form action="" method="post" >
        <%
            try {
                String Host = "jdbc:mysql://localhost:3306/koperasi";
                Connection conn = null;
                Statement st = null;
                ResultSet rs = null;

                Class.forName("com.mysql.jdbc.Driver");

                conn = DriverManager.getConnection(Host, "root", "");
                st = conn.createStatement();

                String no_rekening = request.getParameter("u");

                String query = "SELECT * FROM nasabah WHERE no_rekening='"+no_rekening+"'";

                rs = st.executeQuery(query);

                while (rs.next()) {
                %>
                <div class="mb-3">
                  <label for="nama" class="form-label">Nama</label>
                  <input type="text" class="form-control" id="nama" name="nama" value='<%=rs.getString("nama")%>' >
                </div>
                <div class="mb-3">
                    <label for="alamat" class="form-label">Alamat</label>
                    <input type="text" class="form-control" id="alamat" name="alamat" value='<%=rs.getString("alamat")%>'>
                </div>
                <div class="mb-3">
                    <label for="no_hp" class="form-label">No HP</label>
                    <input type="text" class="form-control" id="no_hp" name="no_hp" value='<%=rs.getString("no_hp")%>'>
                </div>
                <div class="mb-3">
                    <label for="no_rekening" class="form-label">No Rekening</label>
                    <input type="text" class="form-control" id="no_rekening" name="no_rekening" value='<%=rs.getString("no_rekening")%>' readonly>
                </div>
                <div class="mb-3">
                    <label for="jumlah_pinjaman" class="form-label">Jumlah Pinjaman</label>
                    <input type="text" class="form-control" id="jumlah_pinjaman" name="jumlah_pinjaman" value='<%=rs.getString("jumlah_pinjaman")%>'>
                </div>
                <button type="submit" name="submit" class="btn btn-primary">Submit</button>
            <% }
                rs.close();
                st.close();
                conn.close();
            } catch (Exception e) {
                out.print("Error: "+e);
                e.printStackTrace();
            }
            %>
      </form>
</body>
</html>

<% 
String nama=request.getParameter("nama");
String alamat=request.getParameter("alamat"); 
String no_hp=request.getParameter("no_hp");
String no_rekening=request.getParameter("no_rekening");
String jumlah_pinjaman=request.getParameter("jumlah_pinjaman"); 

String Host="jdbc:mysql://localhost:3306/koperasi";

Connection conn=null;
PreparedStatement ps=null; 
Class.forName("com.mysql.jdbc.Driver").newInstance();
int updateQuery=0; 

// validasi
if (nama!=null && alamat!=null && no_hp!=null && no_rekening!=null && jumlah_pinjaman!=null) {
    if (nama!="" && alamat!="" && no_hp!="" && no_rekening!="" && jumlah_pinjaman!="") {
        try {
            conn=DriverManager.getConnection(Host,"root","");
            String query="UPDATE nasabah SET nama=?,alamat=?,no_hp=?,no_rekening=?,jumlah_pinjaman=? WHERE no_rekening='"+no_rekening+"'";
            ps=conn.prepareStatement(query);
            ps.setString(1,nama);
            ps.setString(2,alamat);
            ps.setString(3,no_hp);
            ps.setString(4,no_rekening);
            ps.setString(5,jumlah_pinjaman);
            updateQuery=ps.executeUpdate();
            if (updateQuery!=0) {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            out.print("Error: "+e);
            e.printStackTrace();
        } finally {
            ps.close();
            conn.close();
        }
    }
}
%>