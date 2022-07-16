<%@page import="javax.swing.JOptionPane"%> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <%@ include file="head.jsp" %>

  <body class="container my-3">
    <h3 class="text-center">Tambah Data</h3>
    <form action="" method="post" >
    <div class="mb-3">
        <label for="nama" class="form-label">Nama</label>
        <input type="text" class="form-control" id="nama" name="nama">
    </div>
    <div class="mb-3">
        <label for="alamat" class="form-label">Alamat</label>
        <input type="text" class="form-control" id="alamat" name="alamat">
    </div>
    <div class="mb-3">
        <label for="no_hp" class="form-label">No HP</label>
        <input type="text" class="form-control" id="no_hp" name="no_hp">
    </div>
    <div class="mb-3">
        <label for="no_rekening" class="form-label">No Rekening</label>
        <input type="text" class="form-control" id="no_rekening" name="no_rekening">
    </div>
    <div class="mb-3">
        <label for="jumlah_pinjaman" class="form-label">Jumlah Pinjaman</label>
        <input type="text" class="form-control" id="jumlah_pinjaman" name="jumlah_pinjaman">
    </div>
    <button type="submit" name="submit" class="btn btn-primary">Submit</button>
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
            String query="INSERT INTO nasabah VALUES(?,?,?,?,?)";
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