<%-- 
    Document   : categorias
    Created on : 4/11/2015, 05:54:42 PM
    Author     : ricesqgue
--%>

<%
HttpSession sesion = request.getSession();
    if(sesion.getAttribute("nombre")==null){
        response.sendRedirect("index.jsp"); 
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<link rel="stylesheet" href="../css/puntoDeVenta.css">
	<link rel="stylesheet" href="../css/icons.css">
        <link rel="stylesheet" href="../css/animate.css">
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
                        <a href="/puntoDeVenta/puntoDeVenta.jsp" class="navbar-brand">Punto de venta</a>
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
                            <li><a href="closeSession.jsp">Cerrar sesi�n</a></li>
                            <li><a>Usuario: <%=sesion.getAttribute("nombre")%></a></li>                            
                        </ul>
                    </div>
                </div>
            </nav>
	</header>	
	<div class="jumbotron">
            <div class="container">
                <h1>Categor�as</h1>
            </div>
	</div>
        <div class="container">
            <div id="wrap" ></div>
            <div><button class="btn btn-success glyphicon glyphicon-plus-sign" data-toggle="modal" href="#modal-agregar"></button></div>
            <div id='mensaje'></div>
        </div>
        <div class="container">
                <br>
                <div class="modal fade" id="modal-modificar">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" onclick="$('#nombreCategoriaModificar').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h3 class="modal-title">Modificar categor�a</h3>
                                
                            </div>
                            <div class="modal-body">
                                <label>Ingrese el nuevo nombre de la categor�a: </label>
                                <input type="text" id="nombreCategoriaModificar" name="nombreCategoriaModificar" class="form-control" >
                                <h5>*Se modificar� la categor�a en los productos registrados.</h5>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" onclick="$('#nombreCategoriaModificar').val('')" data-dismiss="modal" >Cancelar</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="modificarCategoria(idCategoriaModificar,$('#nombreCategoriaModificar').val())">Guardar cambios</button>
                            </div>
                        </div>
                    </div>  
                </div>
                
                <div class="modal fade" id="modal-agregar">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
				<button type="button" class="close" onclick="$('#nombreCategoria').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Agregar categor�a</h4>
                            </div>
                            <div class="modal-body">
                                <label>Ingrese el nombre de la categor�a:</label>
                                <input type="text" id="nombreCategoria" name="nombreCategoria" class="form-control" >
                            </div>
                            <div class="modal-footer">
				<button type="button" class="btn btn-default" onclick="$('#nombreCategoria').val('')" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="agregarCategoria($('#nombreCategoria').val())">Agregar</button>
                            </div>
                        </div>
                    </div>
                </div>    
                
                <div class="modal fade" id="modal-eliminar">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
				<button type="button" class="close" onclick="$('#nombreCategoriaEliminar').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Eliminar categor�a</h4>
                            </div>
                            <div class="modal-body">
                                <label>Se eliminar� la categor�a seleccionada.</label><br>
                                <label>Desea continuar?</label><br>
                                <h5>*No se podr� eliminar si existen productos relacionados en existencia.</h5>
                            </div>
                            <div class="modal-footer">
				<button type="button" class="btn btn-default" onclick="$('#nombreCategoriaEliminar').val('')" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="eliminarCategoria(idCategoriaEliminar)">Eliminar</button>
                            </div>
                        </div>
                    </div>
                </div>  
            </div>
                        
        <div id="footer" style="margin-top: 100px;">
            
        </div>
        
        <script type="text/javascript" src="../js/jquery.js"></script>
        <script type="text/javascript" src ="../js/bootstrap.min.js"></script>
        <script type="text/javascript" src ="../js/jquery.validate.min.js"></script>
        <script type="text/javascript" src = "../js/puntoDeVenta.js"></script>
        <script type="text/javascript" src ="../js/filtroTabla.js"></script>
        <script type="text/javascript">
            function catalogo(){
                $.post("catalogoCategorias.jsp",function(res){
                    $("#wrap").html(res.tabla);
                    $('#tablaCategorias').DataTable({paging:false,bInfo: false});
                },"json");                    
            }
            
            function agregarCategoria(nombreCategoria){
                $('#nombreCategoria').val('');
                nombreCategoria = nombreCategoria.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');                    
                if(nombreCategoria === ""){
                    $("#mensaje").html("<br><div class='row animated slideInLeft'> <div class='col-md-4 col-md-offset-3'>"
                        + "<div class='alert alert-danger' role='alert'>"
                        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span></button>"
                        + "<strong>Error. </strong> Ingrese un nombre de categor�a v�lido."
                        + "</div></div></div>");
                }else{
                
                    $.post("agregaCategoria.jsp",{nombreCategoria: nombreCategoria}, function(res){                
                        if(res.exito !== undefined) {
                            catalogo();
                            $("#mensaje").html(res.exito);                            
                        }
                        else{
                            $("#mensaje").html(res.error);
                        }
                    },"json");
                }
                
            }
            
            function modificarCategoria(idCategoria,nombreCategoria){
                $('#nombreCategoriaModificar').val('');
                nombreCategoria = nombreCategoria.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                if(nombreCategoria === ""){
                    $("#mensaje").html("<br><div class='row animated slideInLeft'> <div class='col-md-4 col-md-offset-3'>"
                        + "<div class='alert alert-danger' role='alert'>"
                        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span></button>"
                        + "<strong>Error. </strong> Ingrese un nombre de categor�a v�lido."
                        + "</div></div></div>");
                }else{                 
                    $.post("modificaCategoria.jsp",{idCategoria: idCategoria, nombreCategoria: nombreCategoria}, function(res){
                        if(res.exito !== undefined) {
                            catalogo();
                           $("#mensaje").html(res.exito);      
                        }
                        else{
                            $("#mensaje").html(res.error);
                        }
                    },"json");
                }
                
            }
            
            function eliminarCategoria(idCategoria){
                $.post("eliminaCategoria.jsp",{idCategoria: idCategoria},function (res){
                    if(res.exito !== undefined) {
                        catalogo();
                        $("#mensaje").html(res.exito);      
                    }
                    else{
                        $("#mensaje").html(res.error);
                    }
                },"json");
            }
 
            //Llamo a la funcion catalogo para cargar la tabla.
            catalogo(); 
            var idCategoriaModificar = "";
            var idCategoriaEliminar = "";
        </script>            
    </body>
</html>
