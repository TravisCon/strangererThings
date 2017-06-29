var db = require('../models/database.js');

function handleChoice(request, response) {
  console.log("Returning the results of choice");
  var id = request.params.choice_id;
  db.getChoices(function(error, result) {
    response.json(result);
  });
}

function handleReset(request, response) {
  var id = request.params.id;
  var result = db.getBook(id);
  response.json(result);
}

module.exports = {
  handleChoice: handleChoice,
  handleReset: handleReset
};