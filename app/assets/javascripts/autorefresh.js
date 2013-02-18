function loadXMLDoc()
{
var xmlhttp;
// var xmlhttp2;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  // xmlhttp2=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  // xmlhttp2=new ActiveXObject("Microsoft.XMLHTTP");
  }
var reloadFunc = function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    $('#moves').prepend(xmlhttp.responseText);
    }

  // if (xmlhttp2.readyState==4 && xmlhttp2.status==200)
  //   {
  //   $('#score').html(xmlhttp2.responseText);
  //   }
  }
// pega jogadas mais recentes
xmlhttp.onreadystatechange=reloadFunc
xmlhttp.open("GET",document.URL+"moves/"+ $('.move')[0].id,true);
xmlhttp.send();

// pega placar mais recente
// xmlhttp2.onreadystatechange=reloadFunc
// xmlhttp2.open("GET",document.URL+"score",true);
// xmlhttp2.send();
}