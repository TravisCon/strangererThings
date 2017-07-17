$(document).ready(function(){
  $("#choices").on('click', "button",function(){
    console.log("button clicked");
    var buttonID = encodeURIComponent($(this).attr("id"));
    var params = {id: buttonID};
    var myURL = "/lake";
    console.log(myURL);
    $.get(myURL, params, display);
  });
});

function display(data, status){
  if (status != "success"){
    $("consequences").html("Error with query");
    return 1;
  } else {
    //    console.log("Data: " + data + ". Status: " + status);
    var newButtons = "";
    for (i in data){
      newButtons += createButton(data[i]);
    }

    changeBackground(data[0].photo_url)
    $("#consequences").html(data[0].consequence_description);
    $("#choices").html(newButtons);
  }
}

function createButton (row) {
  var open = "<button class='btn btn-default' id='";
  var middle = "'>";
  var close = "</button>";
  return open + row.consequence_id + middle + row.choice_description + close;
}

function changeBackground(newPhoto) {
  var oldPhoto = $("body").css('background-image');
  oldPhoto = oldPhoto.replace('url(\"','').replace('\")','');
  oldPhoto = oldPhoto.split('/').pop();
  console.log(oldPhoto);
  if (newPhoto != oldPhoto){
    $("body").css('background-image', ('url(photos/' + newPhoto + ')'));
  }
}