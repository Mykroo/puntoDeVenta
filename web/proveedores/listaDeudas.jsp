<%-- 
    Document   : listaDeudas
    Created on : 24/11/2015, 12:24:27 PM
    Author     : ricesqgue
--%>

<jsp:useBean id="objConn" class="mysqlpackage.MySqlConn"/>
<%@page import="org.json.simple.JSONObject"%>

<%
JSONObject json = new JSONObject();
String proveedor = request.getParameter("proveedor");
String query = "select * from deuda where idProveedor = " + proveedor + ";";
objConn.Consult(query);
int n = 0;
if(objConn.rs != null){
    try{
        objConn.rs.last();
        n = objConn.rs.getRow();
        objConn.rs.first();
    }
    catch(Exception e){}    
}
if(n>0){
       String tabla ="<div class='table-responsive datagrid animated slideInRight'>" 
                    +"<table id='tablaDeudas' class='table table-striped table-bordered' >"
                        +"<thead>"
                           +"<tr class='info' >"
                                +"<th>Folio de compra</th>"
                                +"<th>Fecha</th>"
                                +"<th>Folio de nota</th>"
                                +"<th>Costo</th>"
                                + "<th>Abono</th>"
                                + "<th>Deuda</th>"
                                + "<th>Detalle</th>"                           
                            +"</tr>"                       
                        +"</thead>"
                        +"<tbody >";                            
                            for(int i=0;i< n;i++){                                
                                tabla += "<tr id='row"+objConn.rs.getString(1)+"'>";                                
                                for(int j=1; j<4; j++){                                        
                                    tabla += "<td>"+objConn.rs.getString(j)+"</td>";
                                }
                                tabla += "<td>$"+objConn.rs.getString(4)+"</td>";
                                tabla += "<td>$"+objConn.rs.getString(5)+"</td>";
                                tabla += "<td>$"+objConn.rs.getString(6)+"</td>";
                                tabla += "<td><span class=\'icon-eye pointer\' onclick='detalleCompra(\""+objConn.rs.getString(1)+"\");'></span></td>";
                                tabla+="</tr>";                                   
                                objConn.rs.next(); 
                            }                           
                        tabla+="</tbody>"
                    +"</table>"
                +"</div>";
                              
    json.put("tabla", tabla);
    
}else{
    json.put("error", "<div id='mensaje' class='col-sm-4 col-sm-offset-4 animated slideInRight'> "
        + "<div class='alert alert-warning' role='alert'>"
        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
        + "<span aria-hidden='true'> &times;</span></button>"
        + "<strong>No se encontraron resultados.</strong>"
        + "</div></div>");
}
objConn.desConnect();
out.print(json);
out.flush();

%>

