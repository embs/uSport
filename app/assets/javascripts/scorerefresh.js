function loadXMLDocForScore()
{
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
var reloadFunc = function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    // $('#score').html(xmlhttp.responseText);
    $('#score').after(xmlhttp.responseText).remove();
    }
  }

// pega placar mais recente
xmlhttp.onreadystatechange=reloadFunc
xmlhttp.open("GET",document.URL+"score",true);
xmlhttp.send();
}