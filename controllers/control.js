var db = require('../models/database.js');

function handleChoice(request, response) {
  var id = request.query.id;
  db.getChoices(id, function(error, result) {
    if(error == null){
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