<%-- 
    Document   : puntoDeVenr
    Created on : 23/05/2015, 06:14:24 PM
    Author     : Ricardo
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
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/puntoDeVenta.css">
	<link rel="stylesheet" href="css/icons.css">
        <link rel="stylesheet" href="css/animate.css">
        <title>Punto de venta</title>
        <script type="text/javascript">
            var numFilas = 0;
        </script>
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
                <h1>Venta de mostrador</h1>
            </div>
	</div>
	
	<div class="container" id="wrap">
            <div class="bordeado">
                <p><strong>Introduzca los datos de la venta</strong></p>
                <div class="row">
                    <br>
                    <form class="form-inline" id="formulario">
                        <div class="form-group">
                            <label for="codigo">C&oacute;digo</label>
                            <input  id="codigo" type="number" name="codigo" title="Introduce un codigo" class="form-control" placeholder="C&oacute;digo" required tabindex="1" 
                                   min="0" onkeypress="if(enter(event.keyCode) && $('#codigo').val()=== ''){foco('terminaVentaBtn');}else if(enter(event.keyCode) && $('#codigo').val() !== ''){foco('cantidad'); $('#cantidad').val(1).select();}">
                        </div>
                        <div class="form-group" >
                            <label for="cantidad">Cantidad</label>
                            <input type="number" title="Introduce una cantidad" class="form-control" id="cantidad" name="cantidad" placeholder="Cantidad" required tabindex="2" 
                                   onkeypress="if(enter(event.keyCode)){$('#formulario').submit();}">
                        </div>
                        <div class="form-group">
                             <button type="button" title="Agregar a la venta" onclick="$('#formulario').submit()" id = "agregaProductoBtn" class="btn btn-default" tabindex="3" ><span class="glyphicon glyphicon-ok"></span></button>                             
                        </div>
                        <div class="form-group" id="msj">
                            
                        </div>
                        
                        <input id="inputFilas" type="hidden" name="numFilas" value="">
                        <script>
                            document.getElementById("inputFilas").value = numFilas;
                        </script>
                    </form>				                                          
                </div>          
            </div>
            <br><br>
            <div class="row">
                <div class="col-md-12">
                    <form id="formularioTabla" action="terminaVenta.jsp" method="post">
                        <div class="table-responsive">
                            <table id ="filas" class="table table-striped table-bordered table-hover">
                                <tr class="info">
                                    <th>Codigo</th>
                                    <th>Producto</th>
                                    <th>Marca</th>
                                    <th>Categoría</th>
                                    <th>Cantidad</th>
                                    <th>Precio unitario</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                            </table>	
                        </div>
                        <input id="inputFilas2" type="hidden" name="numFilas" value="0">
                      </form>
                </div>
            </div>
            <button class="btn btn-success" id = "terminaVentaBtn" disabled="disabled" onclick="$('#formularioTabla').submit()">
                Realizar compra 
                <span class="glyphicon glyphicon-check"></span>
            </button> 
        </div>
      
        
        <div id="footer">
            <div class="container">
                <br>
               
            </div>
        </div>
        
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src ="js/bootstrap.min.js"></script>
        <script type="text/javascript" src ="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src = "js/puntoDeVenta.js"></script>
        <script type="text/javascript">
            $(document).ready(function() { 	
                $("#formulario").validate({ 
                    submitHandler: function(form) {
                        $.post("llenaTabla.jsp",$(form).serialize(),function(res){
                            if(res.exito !== undefined){
                                foco('codigo');
                                hideMsj();
                                numFilas = numFilas + 1;
                                document.getElementById("inputFilas2").value = numFilas; 
                                document.getElementById("inputFilas").value = numFilas;
                                document.getElementById("filas").innerHTML += res.exito; 
                                document.forms[0].reset();
                                $("#terminaVentaBtn").removeAttr("disabled");
                            }
                            else if(res.error !== undefined){                                
                                //No hay producto...
                                if(res.error === "No se completa la cantidad de productos."){
                                   var mensaje = "<div id='mensaje' class='col-md-12 animated slideInRight'> "
                                    + "<div class='alert alert-danger' role='alert'>"
                                    + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                                    + "<span aria-hidden='true'> &times;</span></button>"
                                    + res.error
                                    + "</div></div>";
                                    $("#msj").html(mensaje);
                                    showMsj('msj');
                                    foco('cantidad');
                                    $("#cantidad").select();                                                            
                                }                           
                            }
                        },"json");
                    },                
                    rules: {  
                        codigo:  {required: true, digits: true, remote: {url: "validaciones/checaCodigo2.jsp", type: "get"}},  
                        cantidad: {required: true, digits: true}
                    },  
                    messages: {  
                        codigo:   {           
                            remote:   "El codigo no existe" 
                        }
                        
                    }  
                });  
            });
        </script>
        <script type="text/javascript">
            function renombraFilas(){
                var filas = $("#filas").find("tr");
                var btnEliminar = $(".glyphicon-remove");
                for(var i=1;i<filas.length;i++){
                    var input = filas.eq(i).find("input");
                    input.eq(0).attr("name","cantidad"+(i-1));                    
                    input.eq(1).attr("name","total"+(i-1));/////                   
                    input.eq(2).attr("name","codigo"+(i-1));
                    input.eq(3).attr("name","producto"+(i-1));//
                    input.eq(4).attr("name","idProd"+(i-1));                                                            
                    filas.eq(i).attr("id","f"+(i-1));
                    btnEliminar.eq(i-1).attr("onclick","$(\"#f"+(i-1)+"\").remove(); renombraFilas();");           
                }
                numFilas = filas.length-1;
                $("#inputFilas2").val(numFilas);
                $("#inputFilas").val(numFilas);
                if(numFilas === 0){
                    $("#terminaVentaBtn").attr("disabled","disabled");
                }
            }  
        </script>
    </body>
</html>