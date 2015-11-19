<%-- 
    Document   : index
    Created on : 3/06/2015, 11:20:41 AM
    Author     : Ricardo
--%>

<%
   HttpSession sesion = request.getSession();
    if(sesion.getAttribute("nombre")!=null){
        response.sendRedirect("puntoDeVenta.jsp"); 
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Punto de venta</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/puntoDeVenta.css">
        <link rel="stylesheet" href="css/animate.css">      
    </head>
    <body>
        <header>
            <nav class="navbar navbar-inverse navbar-static-top" role="navigation"> 
                <div class="container"> 
                    <div class="navbar-header">
                        <span class="navbar-brand">Punto de venta</span>
                    </div>
                    <!--Inicia Menu-->
                </div>
            </nav>
        </header>	
        <br><br><br>
        <div class="container" id="wrap">
            <div class="row">
                <form class="form-group" id="formulario" method="post" autocomplete="off"> 
                    <div class="col-md-6 col-md-offset-3 bordeado">
                        <div class="jumbotron titleInicioSesion">                           
                            <h3>Inicio de sesión</h3>                           
                        </div>
                        <label for="usuario">Usuario</label>
                        <input class="form-control" type="text" name="usuario" id="usuario"><br>
                        <label for="password">Contraseña</label>
                        <input class ="form-control" type="password" id="password" name="password"><br>
                        <button class="btn btn-success" type="button" onclick="enviaFormulario()" id="boton">Entrar</button>
                    </div>
                </form>
            </div>
            <div id="mensaje"></div>
        </div>        
        <div id="footer">
            <div class="container">
                <p class="text-muted credit"> </p>
            </div>
        </div>




        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src ="js/bootstrap.min.js"></script>
        <script type="text/javascript">
            function enviaFormulario(){                
                $.post("checkLogin.jsp",$("#formulario").serialize(),function(res){                    
                if(res.respuesta === "1"){
                    window.location.href="puntoDeVenta.jsp";
                }
                else{
                    document.getElementById("mensaje").innerHTML = res.respuesta;
                }
                },"json");
            }                   
        </script>
    </body>
</html>