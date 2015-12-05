<%-- 
    Document   : reporteProductosVendidos
    Created on : 4/12/2015, 07:31:57 PM
    Author     : ricesqgue
--%>


<jsp:useBean id="objConn" class="mysqlpackage.MySqlConn"/>
<%@page import="org.json.simple.JSONObject"%>
<%
String fechaInicial = request.getParameter("fechaInicial");
String fechaFinal = request.getParameter("fechaFinal");
JSONObject json = new JSONObject();
String query = " select p.codigo,p.descripcion, m.marca,c.categoria, concat_ws(' ',pr.nombre,pr.apellidoPaterno,pr.apellidoMaterno) as proveedor, sum(vp.cantidad) as cantidad from ventaproducto vp natural join producto p natural join marcas m natural join categorias c natural join ventatotal vt natural join proveedor pr where date(vt.fecha) between '"+fechaInicial+"' and '"+fechaFinal+"' and p.activo=1 group by p.idProducto;";
objConn.Consult(query);
int n = 0;
if(objConn.rs != null){
    try{
        objConn.rs.last();
        n = objConn.rs.getRow();
        objConn.rs.first();
    }catch(Exception e){}
}

if(n>0){
    String tabla = "";
    tabla  +="<div class='table-responsive datagrid animated slideInRight'>" 
                +"<table id='tablaReporte' class='table table-striped table-bordered table-hover'>"
                        +"<thead>"
                           +"<tr class='info' >"
                                +"<th>C�digo</th>"  
                                +"<th>Producto</th>"
                                +"<th>Marca</th>"
                                +"<th>Categor�a</th>"
                                +"<th>Proveedor</th>"
                                +"<th>Cantidad</th>"                               
                            +"</tr>"                       
                        +"</thead>"
                        +"<tbody>";                            
                            for(int i=0;i< n;i++){                                
                                tabla += "<tr>";                                                    
                                    for(int j=1; j<7; j++){                                         
                                        tabla += "<td>"+objConn.rs.getString(j)+"</td>";
                                    } 
                                objConn.rs.next(); 
                            }   
                        tabla+="</tbody>"
                    +"</table>"
                +"</div>";    
    json.put("tabla", tabla);
   
}else{
    json.put("error", "<br><div class='row animated slideInLeft'> <div class='col-md-4 col-md-offset-3'>"
        + "<div class='alert alert-warning' role='alert'>"
        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
        + "<span aria-hidden='true'>&times;</span></button>"
        + "<strong>No se encontraron resultados.</stong>"
        + "</div></div></div>" );  
    }
    
objConn.desConnect(); 
out.print(json);
out.flush();
%>


