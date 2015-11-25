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
    float totalDeuda = 0;
    //Tabla de informacion
       String tabla ="<div class='table-responsive datagrid animated slideInRight'>" 
                    +"<table id='tablaDeudas' class='table table-striped table-bordered' >"
                        +"<thead>"
                           +"<tr class='info' >"
                                +"<th>Folio</th>"
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
                                totalDeuda += objConn.rs.getFloat(6);
                                tabla += "<td><span class=\'icon-eye pointer\' onclick='detalleCompra(\""+objConn.rs.getString(1)+"\");'></span></td>";
                                tabla+="</tr>";                                   
                                objConn.rs.next(); 
                            }                           
                        tabla+="</tbody>"
                    +"</table>"                    
                +"</div>"
                + "<br><center><h3>Deuda total: $<span id='totalDeuda'>"+totalDeuda+"</span></h3></center>";
                        
    objConn.rs.first();
    
    //Tabla para abonar
    String tabla2 = "<div class='table-responsive datagrid animated slideInLeft'>"
            + "<form id='formTablaAbonar'>" 
                    +"<table id='tablaAbonos' class='table table-striped table-bordered' >"
                        +"<thead>"
                           +"<tr class='info' >"
                                +"<th>Folio</th>"
                                +"<th>Fecha</th>"
                                +"<th>Folio de nota</th>"
                                +"<th>Costo</th>"
                                + "<th>Abono</th>"
                                + "<th>Deuda</th>"
                                + "<th>Abonar</th>"
                                + "<th> </th>"                           
                            +"</tr>"                       
                        +"</thead>"
                        +"<tbody >";                            
                            for(int i=0;i< n;i++){                                
                                tabla2 += "<tr id='row"+objConn.rs.getString(1)+"'>";                                
                                for(int j=1; j<4; j++){                                        
                                    tabla2 += "<td>"+objConn.rs.getString(j)+"</td>";
                                }
                                tabla2 += "<td>$"+objConn.rs.getString(4)+"</td>";
                                tabla2 += "<td>$"+objConn.rs.getString(5)+"</td>";
                                tabla2 += "<td>$<span id='d"+i+"'>"+objConn.rs.getString(6)+"</span></td>";
                                tabla2 += "<td><input type='number' name='a"+i+"' name='a"+i+"' onfocus='borraCantidad(\""+i+"\")' onblur='checaCantidad(\""+i+"\")' value='0' ></td>";
                                tabla2 +=  "<td><input type='checkbox' id='c"+i+"' onchange='abona(\""+i+"\")'></td>";
                                tabla2+="</tr>";                                   
                                objConn.rs.next(); 
                            }                           
                        tabla2+="</tbody>"
                    +"</table>"
                + "</form>"
            +"</div>"
            + "<br><center><h3>Cantidad a abonar: $<span id='abono'></span></h3></center>";
                              
    json.put("tabla", tabla);
    json.put("form","<div class='form-inline'>"
                    +"<form id='formAbonar'>"
                    +"<div class='form-group'>"
                    +"<label class='control-label' for='cantidad'>Abonar </label>"
                    +" <input type='text' placeholder='Cantidad' name='cantidad' id='cantidad' class='form-control'>"
                    +"</div> "                        
                    +" <div class='form-group'>"
                    +"      <button id='btnAbonar' type='button' onclick='cantidadAbonar()' class='btn btn-success'> <span class='glyphicon glyphicon-hand-right'> </span> <span class='glyphicon glyphicon-usd'> </span></button>"
                    +"</div>"                                             
                    +"</form>"           
                    +"</div>");
    json.put("tablaAbonar",tabla2);
    
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

