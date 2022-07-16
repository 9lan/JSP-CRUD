<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<%@ include file="head.jsp" %>

  <body class="container my-3">
    <h1 class="text-center">CRUD JSP</h1>
    
    <div class="d-flex justify-content-end">
        <a class="btn btn-primary mb-3" href="tambah.jsp">Tambah</a>
    </div>

    <% try {
        String Host = "jdbc:mysql://localhost:3306/koperasi";
        Connection conn = null;
        
        Statement st = null;
        ResultSet rs = null;
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(Host, "root", "");
        st = conn.createStatement(); String Data = "SELECT * FROM nasabah";

        rs = st.executeQuery(Data);

    %>

    <table class="table table-success table-striped">
        <thead>
          <tr>
            <th scope="col">Nama</th>
            <th scope="col">Alamat</th>
            <th scope="col">No HP</th>
            <th scope="col">No Rekening</th>
            <th scope="col">Jumlah Pinjaman</th>
            <th scope="col">Aksi</th>
          </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
        %>
          <tr>
            <td><%=rs.getString("nama")%></td>
            <td><%=rs.getString("alamat")%></td>
            <td><%=rs.getString("no_hp")%></td>
            <td><%=rs.getString("no_rekening")%></td>
            <td><%=rs.getString("jumlah_pinjaman")%></td>
            <td>
                <a class="btn btn-primary" href="update.jsp?u=<%=rs.getString("no_rekening")%>">EDIT</a>
                |
                <a class="btn btn-danger" href="delete.jsp?d=<%=rs.getString("no_rekening")%>" onclick="return confirm('Apakah anda yakin akan menghapus <%=rs.getString("nama")%>?')">HAPUS</a>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
      <%
        rs.close();
        st.close();
        conn.close();
      } catch (Exception ex) {
      out.println("Can't connect to database.");
      }
      %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
  </body>
</html>
