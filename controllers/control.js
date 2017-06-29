var db = require('../models/database.js');

function handleChoice(request, response) {
  var description = request.query.description;
  db.getChoices(description, function(error, result) {
    if(error != null){
      response.json(result);
    }
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