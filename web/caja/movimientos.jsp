<%-- 
    Document   : movimientos
    Created on : 20/11/2015, 01:45:35 PM
    Author     : ricesqgue

Pantalla principal de los moviminetos de caja.
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
                <h1>Movimientos de caja</h1>
            </div>
	</div>
                        
        <div class="container">  
            <div class="form-inline">
                <div class="form-group">
                    <label class="control-label">Fecha: </label>
                    <div class="input-group">
                        <input type='text' id="fecha" onchange="$('#btnBusca').removeAttr('disabled')" readonly="true" name="fecha" class="form-control" />
                        <span class="input-group-addon pointer" onclick="foco('fecha')">
                            <span class="icon-calendar"></span>
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" onchange="$('#btnBusca').removeAttr('disabled')" id="cbSalidas" checked="true" name="cbSalidas" >
                            Salidas
                        </label>
                    </div>
                </div>                        
                    <div class="form-group">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" onchange="$('#btnBusca').removeAttr('disabled')" id="cbEntradas" checked="true" name="cbEntradas" >
                            Entradas
                        </label>
                    </div>
                </div>  
                <div class="form-group">                    
                    <button disabled="disabled" id="btnBusca" class="btn btn-info" onclick="$('#btnBusca').attr('disabled','disabled'); consultaMovimientos();"><span class="icon-search"></span></button>
                </div>
                
                
            </div>
            <br>
            <div class="row">
                <div id="contenido"></div>                 
            </div>
            
        </div>
                        
        <div class="modal fade" id="modal-eliminar">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Eliminar movimiento de caja</h4>
                    </div>
                    <div class="modal-body">
                        <label>Se eliminará el movimiento seleccionado</label><br>
                        <label>Desea continuar?</label><br>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="eliminarMovimientoCaja(idMovimientoCajaEliminar)">Eliminar</button>
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
            $(function (){
                $("#fecha").datepicker();  
            });

            
            function consultaMovimientos(){
                $('#btnBusca').attr('disabled','disabled');
                var fecha = $("#fecha").val();
                if(isDate(fecha)){
                    if($("#cbEntradas").prop("checked") || $("#cbSalidas").prop("checked")){
                       var valores = fecha.split("/");
                       fecha = valores[2]+"-"+valores[0]+"-"+valores[1];
                       $.post("listaMovimientos.jsp",{fecha: fecha, cbEntrada: $("#cbEntradas").prop("checked"), cbSalida: $("#cbSalidas").prop("checked")}, function (res){
                           if(res.tabla !== undefined){
                               $("#contenido").html(res.tabla);
                               $('#tablaMovimientosCaja').DataTable({paging:false,bInfo: false,bFilter: false});
                           }
                           else if(res.error !== undefined){ 
                               $("#contenido").html(res.error);
                           }
                           
                       },"json");
                    }
                    else{
                        alert("seleccione un tipo de movimiento");
                    }
                }else{
                    alert("ingrese una fecha válida");
                }
            }
            function eliminarMovimientoCaja(id){
                $.post("eliminaMovimiento.jsp",{id: id}, function (res){
                    if(res.exito !== undefined){
                        $("#row"+id).fadeOut("slow");
                        var delay = "2000";
                        setTimeout(function (){$("#row"+id).remove();},delay);
                    }
                    else if(res.error !== undefined){
                        $("#contenido").html(res.error);
                    }
                },"json");
                
                
            }
            var idMovimientoCajaEliminar="";
        </script>
    </body>
</html>
