function getChoices(callback) {
  var result = {
    status:"success",
    choices: [{id:1, name:"The Holy Bible"},
              {id:2, name:"The Book of Mormon"},
              {id:3, name:"The Pearl of Great Price"},
              {id:4, name:"The Doctrine and Covenants"}]
  };
  callback(null, result);
}

function getResult(id) {
  var result = {id: id, name: "The Holy Bible"};
  return result;
}

module.exports = {
  getChoices: getChoices,
  getResult: getResult,
};