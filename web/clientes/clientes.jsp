<%-- 
    Document   : clientes
    Created on : 12/11/2015, 10:15:32 AM
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
                <h1>Clientes</h1>
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
                                <button type="button" class="close" onclick="$('#nombreClienteModificar').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h3 class="modal-title">Modificar cliente</h3>                                
                            </div>
                            <div class="modal-body" style="max-height: 400px; overflow-y: auto">                          
                                <form class="form-group" id="formModificar">
                                    <input type="hidden" name="idClientem" id="idClientem" >
                                    <label class="control-label">Nombre</label>
                                    <input type="text" name="nombrem" id="nombrem" class="form-control">
                                    <label class="control-label">Apellido paterno</label>
                                    <input type="text" name="apePatm" id="apePatm" class="form-control">                                    
                                    <label class="control-label">Apellido materno</label>
                                    <input type="text" name="apeMatm" id="apeMatm" class="form-control">
                                    <label class="control-label">Tel�fono</label>
                                    <input type="tel" name="telm" id="telm" class="form-control">
                                    <label class="control-label">Email</label>
                                    <input type="email" name="emailm" id="emailm" class="form-control">
                                    <label class="control-label">Estado</label>
                                    <select name="estadom" id="estadom" class="form-control" onchange="cambiaMunicipios()">
                                        <option selected value="--- Elegir estado ---">--- Elegir estado ---</option>
                                        <%
                                        objConn.Consult("select estado from estados;");
                                        objConn.rs.last();
                                        int num = objConn.rs.getRow();
                                        objConn.rs.first();
                                        for(int i=0;i<num;i++){
                                            %>
                                            <option value="<%=objConn.rs.getString(1)%>"><%=objConn.rs.getString(1)%></option>
                                            <%
                                            objConn.rs.next(); 
                                        }
                                        %>
                                    </select>
                                    <label class="control-label">Municipio</label>
                                    <select name="municipiom" id="municipiom" class="form-control">
                                        <option selected value="--- Elegir municipio ---">--- Elegir municipio ---</option>
                                    </select>
                                    <label class="control-label">Calle</label>
                                    <input type="text" name="callem" id="callem" class="form-control">
                                    <label class="control-label">N�mero</label>
                                    <input type="text" name="numerom" id="numerom" class="form-control">
                                    <label class="control-label">Colonia</label>
                                    <input type="text" name="coloniam" id="coloniam" class="form-control">
                                    <label class="control-label">C�digo postal</label>
                                    <input type="number" name="cpm" id="cpm" class="form-control">
                                    <label class="control-label">RFC</label>
                                    <input type="text" style="text-transform: uppercase" name="rfcm" id="rfcm" class="form-control">
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" onclick="document.getElementById('formModificar').reset()" data-dismiss="modal" >Cancelar</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="modificarCliente()">Guardar cambios</button>
                            </div>
                        </div>
                    </div>  
                </div>
                
                <div class="modal fade" id="modal-agregar">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
				<button type="button" class="close"  data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Agregar Cliente</h4>
                            </div>
                            <div class="modal-body" style="max-height: 400px; overflow-y: auto">
                                <form class="form-group" id="formAgregar">
                                    <label class="control-label">Nombre</label>
                                    <input type="text" name="nombre" id="nombre" class="form-control">
                                    <label class="control-label">Apellido paterno</label>
                                    <input type="text" name="apePat" id="apePat" class="form-control">                                    
                                    <label class="control-label">Apellido materno</label>
                                    <input type="text" name="apeMat" id="apeMat" class="form-control">
                                    <label class="control-label">Tel�fono</label>
                                    <input type="tel" name="tel" id="tel" class="form-control">
                                    <label class="control-label">Email</label>
                                    <input type="email" name="email" id="email" class="form-control">
                                    <label class="control-label">Estado</label>
                                    <select name="estado" id="estado" class="form-control" onchange="cambiaMunicipios()">
                                        <option selected value="--- Elegir estado ---">--- Elegir estado ---</option>
                                        <%
                                        objConn.Consult("select estado from estados;");
                                        objConn.rs.last();
                                        num = objConn.rs.getRow();
                                        objConn.rs.first();
                                        for(int i=0;i<num;i++){
                                            %>
                                            <option value="<%=objConn.rs.getString(1)%>"><%=objConn.rs.getString(1)%></option>
                                            <%
                                            objConn.rs.next(); 
                                        }
                                        %>
                                    </select>
                                    <label class="control-label">Municipio</label>
                                    <select name="municipio" id="municipio" class="form-control">
                                        <option selected value="--- Elegir municipio ---">--- Elegir municipio ---</option>
                                    </select>
                                    <label class="control-label">Calle</label>
                                    <input type="text" name="calle" id="calle" class="form-control">
                                    <label class="control-label">N�mero</label>
                                    <input type="text" name="numero" id="numero" class="form-control">
                                    <label class="control-label">Colonia</label>
                                    <input type="text" name="colonia" id="colonia" class="form-control">
                                    <label class="control-label">C�digo postal</label>
                                    <input type="number" name="cp" id="cp" class="form-control">
                                    <label class="control-label">RFC</label>
                                    <input type="text" style="text-transform: uppercase" name="rfc" id="rfc" class="form-control">
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" onclick="document.getElementById('formAgregar').reset();" data-dismiss="modal">Cerrar</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="agregarCliente()">Guardar</button>
                            </div>
                        </div>
                    </div>
                </div>    
                
                <div class="modal fade" id="modal-eliminar">
                    <div class="modal-dialog"> 
                        <div class="modal-content">
                            <div class="modal-header">
				<button type="button" class="close" onclick="$('#nombreClienteEliminar').val('')" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Eliminar cliente</h4>
                            </div>
                            <div class="modal-body">
                                <label>Se eliminar� el cliente seleccionado</label><br>
                                <label>Desea continuar?</label><br>
                            </div>
                            <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="eliminarCliente(idClienteEliminar)">Eliminar</button>
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
                $.post("catalogoClientes.jsp",function(res){
                    $("#wrap").html(res.tabla);
                    $('#tablaClientes').DataTable({paging:false,bInfo: false});
                },"json");                    
            }
            
            function agregarCliente(){
                var nombre = $("#nombre").val();
                nombre = nombre.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var apePat = $("#apePat").val();
                apePat = apePat.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var apeMat = $("#apeMat").val();
                apeMat = apeMat.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var tel = $("#tel").val();
                var email = $("#email").val();
                var estado = $("#estado").val();
                var municipio = $("#municipio").val();
                var calle = $("#calle").val();
                calle = calle.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var numero = $("#numero").val();
                numero = numero.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var colonia = $("#colonia").val();
                colonia = colonia.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var cp = $("#cp").val();
                var rfc = $("#rfc").val();
                rfc = rfc.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var validaTelefono = new RegExp("^[0-9]{10}$");
                var validaEmail = new RegExp("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$");
                var error = "";
                if(nombre === ""){
                    error = "Ingrese un nombre v�lido.";
                }
                else if(apePat === ""){
                    error = "Ingrese un apellido paterno v�lido.";
                }
                else if(apeMat === ""){
                    error = "Ingrese un apellido materno v�lido.";
                }
                else if(!validaTelefono.test(tel)){
                    error = "Ingrese un tel�fono v�lido. (10 d�gitos, s�lo n�meros).";
                }
                else if(!validaEmail.test(email)){
                    error = "Ingrese un email v�lido.";
                }
                else if(estado === "--- Elegir estado ---"){
                    error = "Seleccione un estado.";
                }
                else if(municipio === "--- Elegir municipio ---"){
                    error = "Seleccione un municipio.";
                }
                else if(calle === ""){
                    error = "Ingrese una calle v�lida.";
                }
                else if(numero === ""){
                    error = "Ingrese un n�mero de domicilio v�lido.";
                }
                else if(cp === "" || cp.length < 4 || cp.length > 5){
                    error = "Ingrese un c�digo postal v�lido.";
                }
                else if(rfc !== "" && (rfc.length < 12 || rfc.length > 13)){
                    error = "Ingrese un rfc v�lido.";
                }
                if(error !== ""){
                    $("#mensaje").html("<br><div class='row animated slideInLeft'> <div class='col-md-4 col-md-offset-3'>"
                        + "<div class='alert alert-danger' role='alert'>"
                        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span></button>"
                        + "<strong>Error. </strong>" + error +""
                        + "</div></div></div>");
                }else{                
                    $.post("agregaCliente.jsp",$("#formAgregar").serialize(), function(res){ 
                        
                        if(res.exito !== undefined) {
                            document.getElementById("formAgregar").reset();
                            catalogo();
                            $("#mensaje").html(res.exito);                            
                        }
                        else{
                            $("#mensaje").html(res.error);
                        }
                    },"json");
                }
                
            }
            
            function modificarCliente(){
                var nombre = $("#nombrem").val();
                nombre = nombre.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var apePat = $("#apePatm").val();
                apePat = apePat.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var apeMat = $("#apeMatm").val();
                apeMat = apeMat.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var tel = $("#telm").val();
                var email = $("#emailm").val();
                var estado = $("#estadom").val();
                var municipio = $("#municipiom").val();
                var calle = $("#callem").val();
                calle = calle.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var numero = $("#numerom").val();
                numero = numero.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var colonia = $("#coloniam").val();
                colonia = colonia.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var cp = $("#cpm").val();
                var rfc = $("#rfcm").val();
                rfc = rfc.replace(/[,;:|�!\"\'%$#/{}^+*~@]/g,'');
                var validaTelefono = new RegExp("^[0-9]{10}$");
                var validaEmail = new RegExp("^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$");
                var error = "";
                if(nombre === ""){
                    error = "Ingrese un nombre v�lido.";
                }
                else if(apePat === ""){
                    error = "Ingrese un apellido paterno v�lido.";
                }
                else if(apeMat === ""){
                    error = "Ingrese un apellido materno v�lido.";
                }
                else if(!validaTelefono.test(tel)){
                    error = "Ingrese un tel�fono v�lido. (10 d�gitos, s�lo n�meros).";
                }
                else if(!validaEmail.test(email)){
                    error = "Ingrese un email v�lido.";
                }
                else if(estado === "--- Elegir estado ---"){
                    error = "Seleccione un estado.";
                }
                else if(municipio === "--- Elegir municipio ---"){
                    error = "Seleccione un municipio.";
                }
                else if(calle === ""){
                    error = "Ingrese una calle v�lida.";
                }
                else if(numero === ""){
                    error = "Ingrese un n�mero de domicilio v�lido.";
                }
                else if(cp === "" || cp.length < 4 || cp.length > 5){
                    error = "Ingrese un c�digo postal v�lido.";
                }
                else if(rfc !== "" && (rfc.length < 12 || rfc.length > 13)){
                    error = "Ingrese un rfc v�lido.";
                }
                if(error !== ""){
                    $("#mensaje").html("<br><div class='row animated slideInLeft'> <div class='col-md-4 col-md-offset-3'>"
                        + "<div class='alert alert-danger' role='alert'>"
                        + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                        + "<span aria-hidden='true'>&times;</span></button>"
                        + "<strong>Error. </strong>" + error +""
                        + "</div></div></div>");
                }else{                 
                    $.post("modificaCliente.jsp",$("#formModificar").serialize(), function(res){
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
            
            function eliminarCliente(idCliente){
                $.post("eliminaCliente.jsp",{idCliente: idCliente},function (res){
                    if(res.exito !== undefined) {
                        catalogo();
                        $("#mensaje").html(res.exito);      
                    }
                    else{
                        $("#mensaje").html(res.error);
                    }
                },"json");
            }
            function llenaFormulario(idCliente,nombre,apePat,apeMat,telefono,email,calle,numero,colonia,municipio,estado,cp,rfc){  
                $("#idClientem").val(idCliente);
                $("#nombrem").val(nombre);
                $("#apePatm").val(apePat);
                $("#apeMatm").val(apeMat);
                $("#telm").val(telefono);
                $("#emailm").val(email);
                $("#estadom").val(estado);
                $.post("cargaMunicipios.jsp",{estado: estado}, function (res){
                    $("#municipiom").html("<option value='--- Elegir municipio ---' selected>--- Elegir municipio ---</option>" + res.opciones);
                },"json");               
                $("#callem").val(calle);
                $("#numerom").val(numero);
                $("#coloniam").val(colonia);
                $("#cpm").val(cp);
                $("#rfcm").val(rfc);
                var delay=100;   
                setTimeout(function(){                    
                    $("#municipiom").val(municipio);
                }, delay)   ; 
                
            }
            
            function cambiaMunicipios(){
                var estado = $("#estado").val();
                if(estado !== "--- Elegir estado ---"){
                    $.post("cargaMunicipios.jsp",{estado: estado}, function (res){
                        $("#municipio").html("<option value='--- Elegir municipio ---' selected>--- Elegir municipio ---</option>" + res.opciones);
                    },"json");
                }                                    
            }
 
            //Llamo a la funcion catalogo para cargar la tabla.
            catalogo(); 
            var idClienteModificar = "";
            var idClienteEliminar = "";
        </script>            
    </body>
</html>
