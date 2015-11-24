<%-- 
    Document   : abonoProveedor
    Created on : 24/11/2015, 11:30:26 AM
    Author     : ricesqgue
--%>

<%
  
HttpSession sesion = request.getSession();
    if(sesion.getAttribute("nombre")==null){
        response.sendRedirect("index.jsp"); 
    }
%>
<jsp:useBean id="objConn" class="mysqlpackage.MySqlConn"/>
<!DOCTYPE html>
<html lang="es">
    <head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<link rel="stylesheet" href="../css/puntoDeVenta.css">
	<link rel="stylesheet" href="../css/icons.css">
        <link rel="stylesheet" href="../css/animate.css">
        <link rel="stylesheet" href="../css/jquery-ui.min.css">

       
        <title>Punto de venta</title>
    </head>
    <body>
	<header>
            <nav class="navbar navbar-inverse navbar-static-top" role="navigation">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navegacion1">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="puntoDeVenta.jsp" class="navbar-brand">Punto de venta</a>
                    </div>				
                    <!--Inicia Menu-->
                    <div class="collapse navbar-collapse" id="navegacion1">
                        <ul class="nav navbar-nav">
                            <li><a href="puntoDeVenta.jsp">Venta</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">Administrar productos <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="productos/altaProducto.jsp"><span class="glyphicon glyphicon-plus"></span> Agregar producto</a></li>
                                    <li class="divider"></li>
                                    <li><a href="productos/bajaProducto.jsp"><span class="glyphicon glyphicon-minus"></span> Eliminar producto</a></li>
                                    <li class="divider"></li>
                                    <li><a href="productos/modificarProducto.jsp"><span class="glyphicon glyphicon-pencil"></span> Modificar producto</a></li>
                                    <li class="divider"></li>
                                    <li><a href="productos/catalogoProducto.jsp"><span class="icon-list2"></span> Lista de productos</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">Administrar proveedores <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="proveedores/altaProveedor.jsp"><span class="icon-user-plus"></span> Agregar proveedor</a></li>
                                    <li class="divider"></li>
                                    <li><a href="proveedores/bajaProveedor.jsp"><span class="icon-user-minus"></span> Eliminar proveedor</a></li>
                                    <li class="divider"></li>
                                    <li><a href="proveedores/modificarProveedor.jsp"><span class="icon-user"></span> Modificar proveedor</a></li>
                                    <li class="divider"></li>
                                    <li><a href="proveedores/catalogoProveedor.jsp"><span class="icon-list2"></span> Lista de proveedores</a></li>                            
                                </ul>
                            </li>
                            <li ><a href="#">Reportes</a></li>
                            <li><a href="closeSession.jsp">Cerrar sesión</a></li>
                            <li><a>Usuario: <%=sesion.getAttribute("nombre")%></a></li>                            
                        </ul>
                    </div>
                </div>
            </nav>
	</header>	
	<div class="jumbotron">
            <div class="container">
                <h1>Pago a proveedores</h1>
            </div>
	</div>
                        
        <div class="container">  
            <div class="form-inline">
                <div class="form-group">
                    <label class="control-label" for="proveedor">Proveedor </label>
                        <%
                        objConn.Consult("select idProveedor,concat_ws(' ',nombre,apellidoPaterno,apellidoMaterno) as nombre from proveedor where activo = 1 order by nombre;");
                        int n = 0;
                        if(objConn.rs != null){
                            try{
                                objConn.rs.last();
                                n = objConn.rs.getRow();
                                objConn.rs.first();
                            }catch(Exception e){}
                        }
                        if(n>0){                            
                        
                        %>
                        <select class="form-control" id="proveedor"  name="proveedor" onchange="activaBtnBusca();">
                            <option value="--- Elegir proveedor ---" selected>--- Elegir proveedor ---</option>
                            <%
                            for(int i=0; i<n; i++){
                            %>
                                <option value="<%=objConn.rs.getString(1)%>"><%=objConn.rs.getString(2)%></option>
                            <%                                
                                objConn.rs.next();
                            }
                            %>
                        </select>
                        <%                        
                        }
                        else{
                        %>
                        <select name="proveedor" id="proveedor">
                            <option value="--- Elegir proveedor ---" selected>--- Elegir proveedor ---</option>
                        </select>
                        <%
                        }
                        %>
                </div>                       

                <div class="form-group">                    
                    <button disabled="disabled" id="btnBusca" class="btn btn-info" onclick="$('#btnBusca').attr('disabled','disabled'); consultaDeudas();"><span class="icon-search"></span></button>
                </div>                                
            </div>
            <br>
            <div class="row" id="contenido">
                
            </div>
            <div class="row" id="msj">
                
            </div>
            
        </div>
              
        <div class="modal fade" id="modal-detalle">
            <div class="modal-dialog">
		<div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3 class="modal-title">Detalle de compra</h3>
                    </div>
                    <div class="modal-body" id="detalle">
	    		
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                    </div>
		</div>
            </div>
        </div>
                
        
        
        <script type="text/javascript" src="../js/jquery.js"></script>
        <script type="text/javascript" src ="../js/bootstrap.min.js"></script>
        <script type="text/javascript" src ="../js/jquery.validate.min.js"></script>
        <script type="text/javascript" src = "../js/puntoDeVenta.js"></script>
        <script type="text/javascript" src ="../js/filtroTabla.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
        <script type="text/javascript">                       
            function activaBtnBusca(){         
                var proveedor = $("#proveedor").val();
                if(proveedor !== "--- Elegir proveedor ---"){
                    $("#btnBusca").removeAttr('disabled');
                }else{
                    $("#btnBusca").attr('disabled','disabled');
                }
            }
            
            function consultaDeudas(){
                var proveedor = $("#proveedor").val();
                if(proveedor !== "--- Elegir proveedor ---"){
                    $.post("listaDeudas.jsp",{proveedor: proveedor}, function(res){
                        if(res.tabla !== undefined){
                            $("#contenido").html(res.tabla);
                            $('#tablaDeudas').DataTable({paging:false,bInfo: false,bFilter: false,sScrollY :"300px", sScrollX : "100%",
                                bScrollCollapse: true});
                            
                        }
                        else if(res.error !== undefined){
                            $("#msj").html(res.error);
                        }
                    },"json");
                    
                }else{
                    $("#msj").html("<div id='mensaje' class='col-sm-4 col-sm-offset-4 animated slideInRight'> "
                        + "<div class='alert alert-danger' role='alert'>"
                        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'> &times;</span></button>"
                        + "<strong>Error.</strong> Introduce un proveedor válido."
                        + "</div></div>");
                }
            }
            
            function detalleCompra(id){
                $.post("detalleCompra.jsp",{id: id}, function(res){
                    if(res.exito !== undefined){
                        $("#detalle").html(res.exito);
                        $("#modal-detalle").modal("toggle");
                    }
                    else if(res.error !== undefined){
                        $("#detalle").html(res.error);
                        $("#modal-detalle").modal("toggle");
                    }
                },"json");
            }
        </script>
    </body>
</html>
