$(document).ready(function(){
  $("#begin").click(function(){
    var id = encodeURIComponent(2);
    var params = {choice_id: id};
    var myURL = "/lake";
//    console.log(myURL);
//    console.log(id);
    $.get(myURL, params, display);
  });
});

function display(data, status){
  if (status != "success"){
    $("result").html("Error with search");
    return 1; 
  }
  console.log("Data: " + data + ". Status: " + status);
  var results = data.choices;
  var output = "";
  console.log(results[0].name);
  for (i in results){
    output += results[i].name + "<br>"; 
  }

  console.log(output);
  $("#results").html(output);
}