var db = require('../models/database.js');

function handleChoice(request, response) {
  var id = request.params.choice_id;
  console.log("Entering handleChoice with id: " + request.params[0]);
  db.getChoices(id, function(error, result) {
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