/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */ 


function foco (id){
    document.getElementById(id).focus();
}

function enter (tecla){
    if(tecla === 13){
        return true;
    }
    return false;
}

function checaCambio(){
    var total = $("#total").val();
    var recibida = $("#cantidadRecibida").val();
    recibida = parseFloat(recibida); 
    if($.isNumeric(recibida)){
        if(recibida>=total){
            var cambio = recibida-total;
            $("#cambio").val(cambio);
             document.getElementById("btnTermina").disabled = false;
             return true;
        }
        else{
            document.getElementById("btnTermina").disabled = true;
            return false;
        }
    }
    else{
        document.getElementById("btnTermina").disabled = true;
        return false;
    }
}

function desactivaTerminaVenta(){
    document.getElementById("btnTermina").disabled = true;
}
            
function descuenta (total){
    var totalFinal = total - $("#descuento").val();
    $("#total").val(totalFinal);
    $("#cantidadRecibida").attr("min", totalFinal);
}

function catalogoModificarProducto(codigo){
    $("#codigo").attr("value",codigo);
    $("#formulario").submit();
} 

function catalogoModificarProveedor(proveedor){
    $("#proveedor").attr("value",proveedor);
    $("#formulario").submit();
} 

//Funciones para mostrar y ocultar el mensaje de producto sin existencias.
function showMsj (){
    $("#msj").show("");
    
 }
 
 function hideMsj (){
     $("#msj").hide("slow");

 }
 
 jQuery.fn.reset = function () {
  $(this).each (function() { this.reset(); });
}


    