<%-- 
    Document   : producto
    Created on : 4/11/2015, 05:54:42 PM
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
                            <li><a href="closeSession.jsp">Cerrar sesi�n</a></li>
                            <li><a>Usuario: <%=sesion.getAttribute("nombre")%></a></li>                            
                        </ul>
                    </div>
                </div>
            </nav>
	</header>	
	<div class="jumbotron">
            <div class="container">
                <h1>Productos</h1>
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
                                <button type="button" class="close" onclick="$('#nombreProductoModificar').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h3 class="modal-title">Modificar producto</h3>
                                
                            </div>
                            <div class="modal-body">
                                <form class="form-group" id="formModificar">
                                    <input type="hidden" name="idProductom" id="idProductom">
                                    <label for="codigom">C�digo</label>
                                    <input type="number" class="form-control" name="codigom" id="codigom">
                                    <label for="descripcionm">Descripci�n</label>
                                    <input type="text" class="form-control" name="descripcionm" id="descripcionm">
                                    <label for="categoriam">Categor�a</label>
                                    <select name="categoriam" id="categoriam" class="form-control">
                                        <option selected>--- Elegir categor�a ---</option>
                                        <%
                                        String query = "select categoria from categorias where activo = 1";
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
                                            for(int i=0;i<n;i++){
                                                %>
                                                <option><%=objConn.rs.getString(1)%></option>
                                                <%
                                                objConn.rs.next();
                                            }
                                        }
                                        %>
                                    </select>
                                    <label for="marcam">Marca</label>
                                    <select name="marcam" id="marcam" class="form-control">
                                        <option selected>--- Elegir marca ---</option>
                                        <%
                                        query = "select marca from marcas where activo = 1";
                                        objConn.Consult(query);
                                        n = 0; 
                                        if(objConn.rs != null){
                                            try{
                                                objConn.rs.last();
                                                n = objConn.rs.getRow();
                                                objConn.rs.first();
                                            }catch(Exception e){}
                                        }
                                        if(n>0){
                                            for(int i=0;i<n;i++){
                                                %>
                                                <option><%=objConn.rs.getString(1)%></option>
                                                <%
                                                objConn.rs.next();
                                            }
                                        }
                                        %>
                                    </select>
                                    <label for="proveedor">Proveedor</label>
                                    <select name="proveedorm" id="proveedorm" class="form-control">
                                        <option selected>--- Elegir proveedor ---</option>
                                        <%
                                        query = "select concat_ws(' ', nombre, apellidoPaterno,apellidoMaterno) from proveedor where activo = 1 order by nombre";
                                        objConn.Consult(query);
                                        n = 0; 
                                        if(objConn.rs != null){
                                            try{
                                                objConn.rs.last();
                                                n = objConn.rs.getRow();
                                                objConn.rs.first();
                                            }catch(Exception e){}
                                        }
                                        if(n>0){
                                            for(int i=0;i<n;i++){
                                                %>
                                                <option><%=objConn.rs.getString(1)%></option>
                                                <%
                                                objConn.rs.next();
                                            }
                                        }
                                        objConn.desConnect();
                                        %>
                                    </select>
                                    <label for="precioVentam">Precio de venta</label>
                                    <input type="number" class="form-control" min="0" step="0.01" name="precioVentam" id="precioVentam">
                                    
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" onclick="document.getElementById('formModificar').reset()" data-dismiss="modal" >Cancelar</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="modificarProducto()">Guardar cambios</button>
                            </div>
                        </div>
                    </div>  
                </div>
                
                <div class="modal fade" id="modal-agregar">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
				<button type="button" class="close" onclick="$('#nombreProducto').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Agregar producto</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-group" id="formAgregar">
                                    <label for="codigo">C�digo</label>
                                    <input type="number" class="form-control" name="codigo" id="codigo">
                                    <label for="descripcion">Descripci�n</label>
                                    <input type="text" class="form-control" name="descripcion" id="descripcion">
                                    <label for="categoria">Categor�a</label>
                                    <select name="categoria" id="categoria" class="form-control">
                                        <option selected>--- Elegir categor�a ---</option>
                                        <%
                                        query = "select categoria from categorias where activo = 1";
                                        objConn.Consult(query);
                                        n = 0;
                                        if(objConn.rs != null){
                                            try{
                                                objConn.rs.last();
                                                n = objConn.rs.getRow();
                                                objConn.rs.first();
                                            }catch(Exception e){}
                                        }
                                        if(n>0){
                                            for(int i=0;i<n;i++){
                                                %>
                                                <option><%=objConn.rs.getString(1)%></option>
                                                <%
                                                objConn.rs.next();
                                            }
                                        }
                                        %>
                                    </select>
                                    <label for="marca">Marca</label>
                                    <select name="marca" id="marca" class="form-control">
                                        <option selected>--- Elegir marca ---</option>
                                        <%
                                        query = "select marca from marcas where activo = 1";
                                        objConn.Consult(query);
                                        n = 0; 
                                        if(objConn.rs != null){
                                            try{
                                                objConn.rs.last();
                                                n = objConn.rs.getRow();
                                                objConn.rs.first();
                                            }catch(Exception e){}
                                        }
                                        if(n>0){
                                            for(int i=0;i<n;i++){
                                                %>
                                                <option><%=objConn.rs.getString(1)%></option>
                                                <%
                                                objConn.rs.next();
                                            }
                                        }
                                        %>
                                    </select>
                                    <label for="proveedor">Proveedor</label>
                                    <select name="proveedor" id="proveedor" class="form-control">
                                        <option selected>--- Elegir proveedor ---</option>
                                        <%
                                        query = "select concat_ws(' ', nombre, apellidoPaterno,apellidoMaterno) from proveedor where activo = 1 order by nombre";
                                        objConn.Consult(query);
                                        n = 0; 
                                        if(objConn.rs != null){
                                            try{
                                                objConn.rs.last();
                                                n = objConn.rs.getRow();
                                                objConn.rs.first();
                                            }catch(Exception e){}
                                        }
                                        if(n>0){
                                            for(int i=0;i<n;i++){
                                                %>
                                                <option><%=objConn.rs.getString(1)%></option>
                                                <%
                                                objConn.rs.next();
                                            }
                                        }
                                        objConn.desConnect();
                                        %>
                                    </select>
                                    <label for="precioVenta">Precio de venta</label>
                                    <input type="number" class="form-control" min="0" step="0.01" name="precioVenta" id="precioVenta">
                                    
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" onclick="document.getElementById('formAgregar').reset();" data-dismiss="modal">Cerrar</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="agregarProducto()">Guardar</button>
                            </div>
                        </div>
                    </div>
                </div>    
                
                <div class="modal fade" id="modal-eliminar">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
				<button type="button" class="close" onclick="$('#nombreProductoEliminar').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Eliminar producto</h4>
                            </div>
                            <div class="modal-body">
                                <label>Se eliminar� el producto seleccionado</label><br>
                                <label>Desea continuar?</label><br>
                                <h5>*No se podr� eliminar si hay existencia en stock.</h5>
                            </div>
                            <div class="modal-footer">
				<button type="button" class="btn btn-default" onclick="$('#nombreProductoEliminar').val('')" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="eliminarProducto(idProductoEliminar)">Eliminar</button>
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
                $.post("catalogoProductos.jsp",function(res){
                    $("#wrap").html(res.tabla);
                    $('#tablaProductos').DataTable({paging:false,bInfo: false});
                },"json");                    
            }
            
            function agregarProducto(){
                var codigo = $("#codigo").val();
                var descripcion = $("#descripcion").val();
                var categoria = $("#categoria").val();
                var marca = $("#marca").val();
                var proveedor = $("#proveedor").val();
                var precioVenta = $("#precioVenta").val();
                if(precioVenta === ""){
                    precioVenta = "0";
                }
                var error = "";
                
                descripcion = descripcion.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                if(codigo === "" || isNaN(codigo)){
                    error = "Ingrese un c�digo v�lido.";
                }
                else if (descripcion === ""){
                    error = "Ingrese una descripci�n de producto v�lida.";
                }
                else if(categoria === "--- Elegir categor�a ---"){
                    error = "Seleccione una categor�a.";
                }
                else if(marca === "--- Elegir marca ---"){
                    error = "Seleccione una marca.";
                }
                else if(proveedor === "--- Elegir proveedor ---"){
                    error = "Seleccione un proveedor.";
                }
                else if(isNaN(precioVenta)){
                    error = "Ingrese un precio de venta v�lido.";
                }        
                if(error !== ""){
                    $("#mensaje").html("<br><div class='row animated slideInLeft'> <div class='col-md-4 col-md-offset-3'>"
                        + "<div class='alert alert-danger' role='alert'>"
                        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span></button>"
                        + "<strong>Error. </strong>" + error +""
                        + "</div></div></div>");
                }else{                
                    $.post("agregaProducto.jsp",$("#formAgregar").serialize(), function(res){ 
                        document.getElementById("formAgregar").reset();
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
            
            function modificarProducto(){
                var codigo = $("#codigom").val();
                var descripcion = $("#descripcionm").val();
                var categoria = $("#categoriam").val();
                var marca = $("#marcam").val();
                var proveedor = $("#proveedorm").val();
                var precioVenta = $("#precioVentam").val();
                if(precioVenta === ""){
                    precioVenta = "0";
                }
                var error = "";
                
                descripcion = descripcion.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                if(codigo === "" || isNaN(codigo)){
                    error = "Ingrese un c�digo v�lido.";
                }
                else if (descripcion === ""){
                    error = "Ingrese una descripci�n de producto v�lida.";
                }
                else if(categoria === "--- Elegir categor�a ---"){
                    error = "Seleccione una categor�a.";
                }
                else if(marca === "--- Elegir marca ---"){
                    error = "Seleccione una marca.";
                }
                else if(proveedor === "--- Elegir proveedor ---"){
                    error = "Seleccione un proveedor.";
                }
                else if(isNaN(precioVenta)){
                    error = "Ingrese un precio de venta v�lido.";
                }        
                if(error !== ""){
                    $("#mensaje").html("<br><div class='row animated slideInLeft'> <div class='col-md-4 col-md-offset-3'>"
                        + "<div class='alert alert-danger' role='alert'>"
                        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span></button>"
                        + "<strong>Error. </strong>" + error +""
                        + "</div></div></div>");                
                }else{                 
                    $.post("modificaProducto.jsp",$("#formModificar").serialize(), function(res){
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
            
            function eliminarProducto(idProducto){
                $.post("eliminaProducto.jsp",{idProducto: idProducto},function (res){
                    if(res.exito !== undefined) {
                        catalogo();
                        $("#mensaje").html(res.exito);      
                    }
                    else{
                        $("#mensaje").html(res.error);
                    }
                },"json");
            }
            function llenaFormulario(idProducto,codigo,descripcion,proveedor,categoria,marca,precioVenta){
                $("#idProductom").val(idProducto);
                $("#codigom").val(codigo);
                $("#descripcionm").val(descripcion);
                $("#proveedorm").val(proveedor);
                $("#categoriam").val(categoria);
                $("#marcam").val(marca);
                $("#precioVentam").val(precioVenta);
            }
 
            //Llamo a la funcion catalogo para cargar la tabla.
            catalogo(); 
            var idProductoEliminar = "";
        </script>            
    </body>
</html>
