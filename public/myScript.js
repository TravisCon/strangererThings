$(document).ready(function(){
  $("button").click(function(){
    var buttonName = encodeURIComponent($(this).val());
    var params = {description: buttonName};
    var myURL = "/lake";
    //    console.log(myURL);
    $.get(myURL, params, display);
  });
});

function display(data, status){
  if (status != "success"){
    $("result").html("Error with search");
    return 1;
  } else {
    console.log("Data: " + data + ". Status: " + status);
    var output = "";
    //    console.log(data[0].description);
    for (i in data){
      newButtons += data[i].description + "<br>"; 
    }

    console.log(newButtons);
    $("#choices").html(newButtons);
    //$("#results").html();
  }
}