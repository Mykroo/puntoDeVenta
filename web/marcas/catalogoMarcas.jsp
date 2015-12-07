<%--    
    Document   : catalogoMarcas
    Created on : 4/11/2015, 06:00:10 PM
    Author     : ricesqgue
--%>

<%@page import="org.json.simple.JSONObject" %>
<jsp:useBean id="objConn" class="mysqlpackage.MySqlConn"></jsp:useBean>    
<%     
    JSONObject json = new JSONObject();
    String query = "select idMarca, marca from marcas where activo = 1;";
    System.out.print("Query 1: Catalogo Marcas: " + query);
    objConn.Consult(query);
    int n = 0;
    String salida = "";
    try {
        if(objConn.rs != null){
            objConn.rs.last();
            n = objConn.rs.getRow();
            objConn.rs.first();
        }
    } catch (Exception e) {}
    if(n>0){        
        salida  +="<div class='table-responsive datagrid'>" 
                    +"<table id='tablaMarcas' class='table table-striped table-bordered table-hover'>"
                        +"<thead>"
                           +"<tr class='info' >"
                                +"<th>No. Marca</th>"
                                +"<th>Marca</th>"
                                +"<th></th>"
                                +"<th></th>"                                
                            +"</tr>"                       
                        +"</thead>"
                        +"<tbody>";
                            
                            for(int i=0;i< n;i++){                                
                                salida += "<tr>";                                
                                for(int j=1; j<3; j++){                                        
                                    salida += "<td>"+objConn.rs.getString(j)+"</td>";
                                }
                                salida += "<td><span class='icon-pencil pointer' onclick='idMarcaModificar = \""+objConn.rs.getString(1)+"\";' data-toggle=\"modal\" href=\'#modal-modificar\'></span></td>"
                                        + "<td><span class='icon-cross pointer' onclick='idMarcaEliminar = \""+objConn.rs.getString(1)+"\";' data-toggle=\"modal\" href=\'#modal-eliminar\'></span></td>";
                                salida+="</tr>";                                   
                                objConn.rs.next(); 
                            }                           
                        salida+="</tbody>"
                    +"</table>"
                +"</div>";                
                json.put("tabla", salida);                                    
            }else{            
               salida += " <h3>No hay marcas registradas</h3>";                    
               json.put("tabla", salida);            
            }       
            objConn.desConnect();
            out.print(json);
            out.flush();        
%>

