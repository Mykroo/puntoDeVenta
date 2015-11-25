<%-- 
    Document   : terminaVenta
    Created on : 1/06/2015, 06:56:58 PM
    Author     : Ricardo
--%>
<%
HttpSession sesion = request.getSession();
    if(sesion.getAttribute("nombre")==null){
        response.sendRedirect("index.jsp"); 
    }
    
    if(request.getParameter("numFilas")==null || request.getParameter("cantidad0")==null){
         %>
        <jsp:forward page="puntoDeVenta.jsp"></jsp:forward>
        <%
    }
%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="objConn" class="mysqlpackage.MySqlConn"></jsp:useBean>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Punto de venta</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/puntoDeVenta.css">
        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/icons.css">     
        <link rel="stylesheet" href="css/jquery-ui.min.css">
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
                                    <li><a href="altaProducto.jsp"><span class="glyphicon glyphicon-plus"></span> Agregar producto</a></li>
                                    <li class="divider"></li>
                                    <li><a href="bajaProducto.jsp"><span class="glyphicon glyphicon-minus"></span> Eliminar producto</a></li>
                                    <li class="divider"></li>
                                    <li><a href="modificarProducto.jsp"><span class="glyphicon glyphicon-pencil"></span> Modificar producto</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">Administrar proveedores <span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="altaProveedor.jsp"><span class="icon-user-plus"></span> Agregar proveedor</a></li>
                                    <li class="divider"></li>
                                    <li><a href="bajaProveedor.jsp"><span class="icon-user-minus"></span> Eliminar proveedor</a></li>
                                    <li class="divider"></li>
                                    <li><a href="modificarProveedor.jsp"><span class="icon-user"></span> Modificar proveedor</a></li>
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
      
        <form id="formulario"  method="post" action="cobrar.jsp"> 
            <div class="container">
            <%
                int numFilas = Integer.parseInt(request.getParameter("numFilas")); 
                ArrayList <String> producto = new ArrayList();
                ArrayList <String> codigo = new ArrayList();
                ArrayList <Integer> cantidad = new ArrayList();
                ArrayList <String> idProducto = new ArrayList();
                ArrayList <Float> total = new ArrayList();                
                //Leo los parametros
                for(int i = 0;i<numFilas;i++){
                    producto.add(request.getParameter("producto"+i));
                    codigo.add(request.getParameter("codigo"+i));                    
                    cantidad.add(Integer.parseInt(request.getParameter("cantidad"+i)));
                    idProducto.add(request.getParameter("idProd"+i));
                    total.add(Float.parseFloat(request.getParameter("total"+i)));
                }
                
                //Acomodo los arraylist
                for(int i = 0; i<producto.size();i++){
                    String cod = codigo.get(i);
                    int cant = cantidad.get(i);
                    float tot = total.get(i); 
                    for(int j=1+i;j<producto.size();j++){
                        if(codigo.get(j).equals(cod)){  
                            cant += cantidad.get(j);
                            tot += total.get(j);
                            producto.remove(j);
                            cantidad.remove(j);
                            codigo.remove(j);
                            idProducto.remove(j);
                            total.remove(j);
                            j--;
                        }
                    }
                    cantidad.set(i,cant);
                    total.set(i, tot);
                }
                
                //Obtengo el total de la compra
                float totalGeneral = 0;
                for(int i = 0; i<producto.size();i++){
                    totalGeneral += total.get(i);
                }
                
                //Obtengo la cantidad de productos.
                int cantidadProductos = 0;
                for(int i = 0; i<cantidad.size();i++){
                    cantidadProductos += cantidad.get(i);
                }                                  
                %>
                <div class="row">
                    <div class="col-md-12">      
                        <div class="table-responsive">
                            <table id ="filas" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr class="info">
                                        <th>Codigo</th>
                                        <th>Producto</th>
                                        <th>Cantidad</th>
                                        <th>Precio unitario</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    //Se llena la tabla con las listas ya acomodadas
                                    for(int i = 0; i<producto.size();i++){                                       
                                    %>                                 
                                        <tr>                                   
                                            <td><%= codigo.get(i)%></td>
                                            <td><%= producto.get(i)%></td>
                                            <td><%=cantidad.get(i)%></td>
                                            <td>$<%=Math.rint(total.get(i)/cantidad.get(i)*100)/100%></td>
                                            <td>$<%=total.get(i)%></td>
                                            <input type="hidden" name="idProd<%=i%>" value="<%= idProducto.get(i) %>"
                                            <input type="hidden" name="codigo<%=i%>" value="<%=codigo.get(i)%>"> 
                                            <input type="hidden" name="cantidad<%=i%>" value="<%=cantidad.get(i)%>">
                                            <input type="hidden" name="precio<%=i%>" value="<%=Math.rint(total.get(i)/cantidad.get(i)*100)/100%>">                                        
                                        </tr>
                                    <% 
                                    }
                                    %>
                                </tbody>
                            </table>	
                        </div> 
                    </div>
		</div>
                <div class="row container">
                    <div class="col-xs-10 col-sm-5">
                        <label>
                            Cantidad de productos: <%=cantidadProductos%> 
                        </label>
                    </div>
                    <div class="col-xs-2 col-sm-1">
<<<<<<< HEAD
                        <button class=" btn btn-warning" type="button" title="Regresar" value="back" onclick="history.back(-1);"><span class="icon icon-undo2"></span></button>
                    </div>
                        
                    <div class="col-xs-10 col-sm-6">
                        <%
                        objConn.Consult("select idCliente,concat_ws(' ',nombre,apellidoPaterno,apellidoMaterno) as nombre from cliente where activo = 1 order by nombre;");
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
                        <select class="form-control"  name="cliente">
                            <%
                            for(int i=0; i<n; i++){
                                if(objConn.rs.getString(1).equals(1)){
                                %>
                                <option value="<%=objConn.rs.getString(1)%>" selected><%=objConn.rs.getString(2)%></option>
                                <%
                                }
                                else{
                                    %>
                                    <option value="<%=objConn.rs.getString(1)%>"><%=objConn.rs.getString(2)%></option>
                                    <%
                                }
                                objConn.rs.next();
                            }
                            %>
                        </select>
                        <%                        
                        }
                        else{
                        %>
                        <select name="cliente">
                            <option selected value="1">Cliente General</option>
                        </select>
                        <%
                        }
                        %>
                        <br>
                    </div>
                        
                </div>
                <div class="row container">
                    <div class="form-group col-xs-10 col-sm-5">
                        <label for="descuento">Descuento $</label>
                        <input class="form-control" type="number" min="0" max="<%=totalGeneral%>" name="descuento" id="descuento" tabindex="1" onkeypress="if(enter(event.keyCode)){if($('#descuento').val()==='0'){$('#descuento').val('0');} foco('descuentoBtn')}else{desactivaTerminaVenta();}">
                     </div>
                     
                    <div class="form-group col-xs-2 col-sm-1">
                        <button class="btn btn-success btn-termVenta" title="Aplicar descuento" type="button" id="descuentoBtn" onclick="foco('cantidadRecibida'); descuenta(<%=totalGeneral%>); " tabindex="2"><span class="icon icon-arrow-right2"></span></button>
                    </div>
                    
                    <div class="form-group col-xs-12 col-sm-6">
                        <label for="total" >Total $</label>
                        <input class="form-control" type="text" name="total" id="total" value="<%=totalGeneral%>" readonly>
                    </div>
                </div>
                <div class="row container">    
                    <div class="form-group col-xs-10 col-sm-5">
                        <label for="cantidadRecibida" >Cantidad recibida $</label>
                        <input class="form-control" type="number" name="cantidadRecibida" id="cantidadRecibida" tabindex="3" min="<%=totalGeneral%>" onkeypress="if(enter(event.keyCode)){if(checaCambio()){foco('btnTermina');}}else{desactivaTerminaVenta();}">
                    </div>
                    
                    
                    <div class="form-group col-xs-2 col-sm-1" >
                        <button class="btn btn-success btn-termVenta" title="Obtener cambio" type="button" id="cambioBtn" onclick="checaCambio()"  tabindex="4"><span class="icon icon-arrow-right2"></span></button>
                    </div>
                    
                    <div class="form-group col-xs-12 col-sm-6" >
                        <label for="cambio" >Cambio $</label>
                        <input class="form-control" type="text" name="cambio" id="cambio" readonly>
                    </div>      
                </div>               
            </div>          
            <input type="hidden" name="numFilas" value="<%=producto.size()%>">
            <input type="hidden" name="tarjeta" id="tarjeta" value="0">
            <input type="hidden" name="totalGeneral" value="<%=totalGeneral%>">
        </form>
        <div class="container">
            <div class="container">
                <button class="btn btn-info" id="btnTarjeta" disabled data-toggle="modal" href='#modal-tarjeta' onclick="pagoTarjeta();" type="button"><span class="icon-credit-card"></span></button>
                <button class="btn btn-success" title="Terminar venta" onclick="cobrar()" id="btnTermina" disabled  tabindex="5" ><span class="glyphicon glyphicon-usd"></span> Cobrar</button>
            </div>
        </div>
        
        <div class="modal fade" id="modal-tarjeta">
            <div class="modal-dialog">
		<div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <center><h2 class="modal-title">Pago con tarjeta <span class="icon-credit-card"></span></h2></center>
                    </div>
                    <div class="modal-body">
                        <div id="infoModalTarjeta"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="cobrar();">Continuar</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="modal-exito">
            <div class="modal-dialog">
		<div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Mensaje</h4>
                    </div>
                    <div class="modal-body">
                        <center><h3>Venta realizada con éxito</h3></center>                            
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" id="btnFin" data-dismiss="modal" onclick="window.location.href='puntoDeVenta.jsp'">Cerrar</button>
                    </div>
		</div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-xs-12 col-sm-6 col-sm-offset-2 col-md-4 col-md-offset-3">
                <div id="msj"></div>
            </div>
        </div>
        
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src ="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/puntoDeVenta.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        
        <script type="text/javascript">

            foco("descuento");
            $("#descuento").val("0");
            $("#descuento").select();
	</script>
        
        <script>
            function pagoTarjeta(){
                var total = $("#total").val();
                var efectivo = $("#cantidadRecibida").val();
                var tarjeta;
                if(efectivo === ""){
                    efectivo = 0;
                    $("#cantidadRecibida").val(efectivo);
                }
                if(efectivo>=total){
                    tarjeta = 0;
                    efectivo = efectivo - (efectivo-total)
                }
                else{
                   tarjeta = total - efectivo;
                }
=======
                        <button class=" btn btn-warning" type="button" title="Regresar" value="back" onclick="history.back();"><span class="icon icon-undo2"></span></button>
                    </div>
                        
                    <div class="col-xs-10 col-sm-6">
                        <%
                        objConn.Consult("select idCliente,concat_ws(' ',nombre,apellidoPaterno,apellidoMaterno) as nombre from cliente where activo = 1 order by nombre;");
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
                        <select class="form-control"  name="cliente">
                            <%
                            for(int i=0; i<n; i++){
                                if(objConn.rs.getString(1).equals(1)){
                                %>
                                <option value="<%=objConn.rs.getString(1)%>" selected><%=objConn.rs.getString(2)%></option>
                                <%
                                }
                                else{
                                    %>
                                    <option value="<%=objConn.rs.getString(1)%>"><%=objConn.rs.getString(2)%></option>
                                    <%
                                }
                                objConn.rs.next();
                            }
                            %>
                        </select>
                        <%                        
                        }
                        else{
                        %>
                        <select name="cliente">
                            <option selected value="1">Cliente General</option>
                        </select>
                        <%
                        }
                        %>
                        <br>
                    </div>
                        
                </div>
                <div class="row container">
                    <div class="form-group col-xs-10 col-sm-5">
                        <label for="descuento">Descuento $</label>
                        <input class="form-control" type="number" min="0" max="<%=totalGeneral%>" name="descuento" id="descuento" tabindex="1" onkeypress="if(enter(event.keyCode)){if($('#descuento').val()===''){$('#descuento').val('0'); foco('cantidadRecibida');}if($('#descuento').val()!=='0'){foco('descuentoBtn');}else{foco('cantidadRecibida');}}else{desactivaTerminaVenta();}">
                     </div>
                     
                    <div class="form-group col-xs-2 col-sm-1">
                        <button class="btn btn-success btn-termVenta" title="Aplicar descuento" type="button" id="descuentoBtn" onclick="descuenta(<%=totalGeneral%>); foco('cantidadRecibida')" tabindex="2"><span class="icon icon-arrow-right2"></span></button>
                    </div>
                    
                    <div class="form-group col-xs-12 col-sm-6">
                        <label for="total" >Total $</label>
                        <input class="form-control" type="text" name="total" id="total" value="<%=totalGeneral%>" readonly>
                    </div>
                </div>
                <div class="row container">    
                    <div class="form-group col-xs-10 col-sm-5">
                        <label for="cantidadRecibida" >Cantidad recibida $</label>
                        <input class="form-control" type="number" name="cantidadRecibida" id="cantidadRecibida" tabindex="3" min="<%=totalGeneral%>" onkeypress="if(enter(event.keyCode)){if(checaCambio()){foco('btnTermina');}}else{desactivaTerminaVenta();}">
                    </div>
                    
                    
                    <div class="form-group col-xs-2 col-sm-1" >
                        <button class="btn btn-success btn-termVenta" title="Obtener cambio" type="button" id="cambioBtn" onclick="checaCambio()"  tabindex="4"><span class="icon icon-arrow-right2"></span></button>
                    </div>
                    
                    <div class="form-group col-xs-12 col-sm-6" >
                        <label for="cambio" >Cambio $</label>
                        <input class="form-control" type="text" name="cambio" id="cambio" readonly>
                    </div>      
                </div>               
            </div>          
            <input type="hidden" name="numFilas" value="<%=producto.size()%>">
            <input type="hidden" name="tarjeta" id="tarjeta" value="0">
            <input type="hidden" name="totalGeneral" value="<%=totalGeneral%>">
        </form>
        <div class="container">
            <div class="container">
                <button class="btn btn-info" id="btnTarjeta" data-toggle="modal" href='#modal-tarjeta' onclick="pagoTarjeta();" type="button"><span class="icon-credit-card"></span></button>
                <button class="btn btn-success" title="Terminar venta" onclick="cobrar()" id="btnTermina" disabled  tabindex="5" ><span class="glyphicon glyphicon-usd"></span> Cobrar</button>
            </div>
        </div>
        
        <div class="modal fade" id="modal-tarjeta">
            <div class="modal-dialog">
		<div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <center><h2 class="modal-title">Pago con tarjeta <span class="icon-credit-card"></span></h2></center>
                    </div>
                    <div class="modal-body">
                        <div id="infoModalTarjeta"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="cobrar();">Continuar</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="modal-exito">
            <div class="modal-dialog">
		<div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Mensaje</h4>
                    </div>
                    <div class="modal-body">
                        <center><h3>Venta realizada con éxito</h3></center>                            
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" id="btnFin" data-dismiss="modal" onclick="window.location.href='puntoDeVenta.jsp'">Cerrar</button>
                    </div>
		</div>
            </div>
        </div>
        
        <div id="msj"></div>
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src ="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/puntoDeVenta.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        
        <script type="text/javascript">

            foco("descuento");
            $("#descuento").val("0");
            $("#descuento").select();
	</script>
        
        <script>
            function pagoTarjeta(){
                var total = $("#total").val();
                var efectivo = $("#cantidadRecibida").val();
                var tarjeta;
                if(efectivo === ""){
                    efectivo = 0;
                    $("#cantidadRecibida").val(efectivo);
                }
                tarjeta = total - efectivo;
>>>>>>> origin/master
                $("#tarjeta").val(tarjeta);
                $("#infoModalTarjeta").html("<h3>Total: $"+total+" </h3><h3>Pago en efectivo: $"+efectivo+"</h3><h3>Pago con tarjeta: $"+tarjeta+"</h3>");
            }
            
            function cobrar(){
                var cambio = $("#cambio").val();
                if(cambio===""){
                    cambio = 0;
                }                
                $("#btnTermina").attr("disabled","disabled");
                $("#btnTarjeta").attr("disabled","disabled");
                $("#cantidadRecibida").val($("#cantidadRecibida").val()-cambio);
                $.post("cobrar.jsp",$("#formulario").serialize(),function(res){
                    if(res.exito !== undefined){
                        $("#modal-exito").modal("show");
                        foco("btnFin");
                        var delay=4000;   
                        setTimeout(function(){                    
                            window.location.href='puntoDeVenta.jsp';
                        }, delay); 
                    }
                    else if(res.error){
                        var mensaje = "<div id='mensaje' class='col-md-12 animated slideInRight'> "
                            + "<div class='alert alert-danger' role='alert'>"
                            + "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"
                            + "<span aria-hidden='true'> &times;</span></button>"
                            + res.error
                            + "</div></div>";
                            $("#msj").html(mensaje);
                            showMsj('msj');
                            $("#btnTermina").removeAttr("disabled");
                            $("#btnTarjeta").removeAttr("disabled");
                    }
                    
                },"json");
            }
        </script>
    </body>
</html>


    
