var pg = require('pg');
pg.defaults.ssl = true;

pgConn = 'postgres://iitxlielolcqnu:f4acb49cfb5293787b0ca3f79e4f5622114ec8ccdc0d9a2927af6c60946d9a7b@ec2-184-73-167-43.compute-1.amazonaws.com:5432/d59m72tguufnuc';

function getChoices(id, callback) {
  //  var result = {
  //    status:"success",
  //    choices: [{id:1, name:"The Holy Bible"},
  //              {id:2, name:"The Book of Mormon"},
  //              {id:3, name:"The Pearl of Great Price"},
  //              {id:4, name:"The Doctrine and Covenants"}]
  //  };
  var resultRows = [{'name' : 'test'}];
  
  console.log("Entering PGconnect with id: " + id);
  pg.connect(pgConn, function(err, client, done) {
    if(err) 
      return callback(err, null);
    client.query('SELECT * FROM choice WHERE id = ' + id, function(err, result) {
      done();
      if(err) 
        return callback(err, null);
      resultRows = result.rows;
      console.log("Row 0: " + resultRows[0]);
      return callback(null, resultRows);
    });
  });
}

function getResult(id) {
  var result = {id: id, name: "The Holy Bible"};
  return result;
}

module.exports = {
  getChoices: getChoices,
  getResult: getResult,
};