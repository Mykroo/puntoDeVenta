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
                            <li><a href="puntoDeVenta.jsp">1</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">Productos <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="productos/productos.jsp">Productos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="categorias/categorias.jsp">Categor�as</a></li>
                                    <li class="divider"></li>
                                    <li><a href="marcas/marcas.jsp">Marcas</a></li>
                                    <li class="divider"></li>
                                    <li><a href="productos/productosFallados.jsp">Productos fallados</a></li>                                   
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">Proveedores <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="proveedores/proveedores.jsp"><span class="icon-users"></span> Proveedores</a></li>
                                    <li class="divider"></li>
                                    <li><a href="proveedores/abonoProveedor.jsp"><span class="icon-coin-dollar"></span> Pago a proveedores</a></li>                                   
                                </ul>
                            </li>                  
                            <li><a href="clientes/clientes.jsp">Clientes</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">Caja <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="caja/fondoDeCaja.jsp"><span class="icon-drawer"></span> Fondo de caja</a></li>
                                    <li class="divider"></li>
                                    <li><a href="caja/corteDia.jsp"><span class="icon-scissors"></span> Corte</a></li>
                                    <li class="divider"></li>
                                    <li><a href="caja/movimientos.jsp"><span class="icon-tab"></span> Movimientos de caja</a></li>
                                </ul>
                            </li>                            
                            <li ><a href="#">Reportes</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"> <%=sesion.getAttribute("nombre")%> <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">                                    
                                    <li><a href="closeSession.jsp">Cerrar sesi�n</a></li>                                  
                                </ul>
                            </li>
                           
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
                                    <th>Categor�a</th>
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
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-10">
                    <button class="btn btn-info" id = "terminaVentaBtn" disabled="disabled" onclick="$('#formularioTabla').submit()">
                        Realizar compra 
                        <span class="glyphicon glyphicon-check"></span>
                    </button>
                </div>
                
                <div class="col-xs-2 col-sm-1 col-md-1">
                    <br>
                    <button class="btn btn-warning" data-toggle="modal" href='#modal-salidaCaja' onclick="setTimeout(function(){ foco('cantidadSalida'); },500);" title="Salida de caja"><span class="icon-arrow-left"></span> $</button>
                </div>
                
                <div class="col-xs-2 col-sm-1 col-md-1">
                    <br>
                    <button class="btn btn-success" title="Entrada de caja" data-toggle="modal" href='#modal-entradaCaja' onclick="setTimeout(function(){ foco('cantidadEntrada'); },500);"><span class="icon-arrow-right"></span> $</button>
                </div>
            </div>
        </div>
      
        <div class="modal fade" id="modal-salidaCaja">
            <div class="modal-dialog">
		<div class="modal-content">
                    <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Salida de caja</h4>
                    </div>
                    <div class="modal-body">
                        <form id="form-salidaCaja">
                            <div class="form-group">
                                <label class="control-label" for="cantidad1">Cantidad</label>
                                <input type="number" step="0.1" min="0" onkeypress="if(enter(event.keyCode)){foco('conceptoSalida');}" title="Cantidad de salida $" class="form-control" id="cantidadSalida" name="cantidad1">
                                <br>
                                <label class="control-label" for="concepto1">Concepto</label>
                                <textarea class="form-control" name="concepto1" id="conceptoSalida"></textarea>
                                <input type="hidden" name="movimiento" value="1">
                            </div> 
                            <div id="msjSalida"></div>
                        </form>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" onclick="$('#msjSalida').hide()" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="$('#btnGuardarSalida').attr('disabled','disabled'); salidaCaja();" id="btnGuardarSalida">Guardar salida</button>
                    </div>
		</div>
            </div>
        </div>                  
        
        <div class="modal fade" id="modal-entradaCaja">
            <div class="modal-dialog">
		<div class="modal-content">
                    <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Entrada de caja</h4>
                    </div>
                    <div class="modal-body">
	    		<form id="form-entradaCaja">
                            <div class="form-group">
                                <label class="control-label" for="cantidad2">Cantidad</label>
                                <input type="number" step="0.1" onkeypress="if(enter(event.keyCode)){foco('conceptoEntrada');}" min="0" title="Cantidad de entrada $" class="form-control" id="cantidadEntrada" name="cantidad2">
                                <br>
                                <label class="control-label" for="concepto2">Concepto</label>
                                <textarea class="form-control"  name="concepto2" id="conceptoEntrada"></textarea>
                                <input type="hidden" name="movimiento" value="2">
                            </div>
                            <div id="msjEntrada"></div>
                        </form>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" onclick="$('#msEntrada').hide()" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="$('#btnGuardarEntrada').attr('disabled','disabled'); entradaCaja();" id="btnGuardarEntrada">Guardar entrada</button>
                    </div>
		</div>
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
            
            function salidaCaja(){
                if(isNaN($("#cantidadSalida").val()) || $("#cantidadSalida").val()===""){
                    var mensaje = "<div id='mensaje' class='col-md-12 animated slideInRight'> "
                    + "<div class='alert alert-danger' role='alert'>"
                    + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'> &times;</span></button><strong>Error. </strong>"
                    + "Ingrese una cantidad v�lida."
                    + "</div></div>";
                     $("#msjSalida").html(mensaje);
                }
                else{                                   
                    $.post("caja/movimientosCaja.jsp",$("#form-salidaCaja").serialize(), function(res){
                        $("#msjSalida").html(res.msj);
                        if(res.tipo==="exito"){
                            document.getElementById("form-salidaCaja").reset();
                        }
                    },"json");
                }
                $("#btnGuardarSalid").removeAttr('disabled');
            }
            function entradaCaja(){
                 if(isNaN($("#cantidadEntrada").val()) || $("#cantidadEntrada").val()===""){
                    var mensaje = "<div id='mensaje' class='col-md-12 animated slideInRight'> "
                    + "<div class='alert alert-danger' role='alert'>"
                    + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                    + "<span aria-hidden='true'> &times;</span></button><strong>Error. </strong>"
                    + "Ingrese una cantidad v�lida."
                    + "</div></div>";
                     $("#msjEntrada").html(mensaje);
                }
                else{
                    $.post("caja/movimientosCaja.jsp",$("#form-entradaCaja").serialize(), function(res){
                        $("#msjEntrada").html(res.msj);
                        if(res.tipo==="exito"){
                           document.getElementById("form-entradaCaja").reset();
                        }
                    },"json");
                }
                $("#btnGuardarEntrada").removeAttr('disabled');
            }
            
            bloqueaForm("form-salidaCaja");
            bloqueaForm("form-entradaCaja");
        </script>
    </body>
</html>