var pg = require('pg');
pg.defaults.ssl = true;

connectionString = 'postgres://iitxlielolcqnu:f4acb49cfb5293787b0ca3f79e4f5622114ec8ccdc0d9a2927af6c60946d9a7b@ec2-184-73-167-43.compute-1.amazonaws.com:5432/d59m72tguufnuc';

function getChoices(description, callback) {
  pg.connect(connectionString, function(err, client) {
    if(err) 
      return callback(err, null);
        var sql = 'SELECT * FROM choice WHERE choice_group = $1::int';
//    var sql = "SELECT c1.trigger_group_id FROM consequence c1 JOIN choice c2 ON (c1.id = c2.consequence_id) WHERE c1.id = (SELECT consequence_id FROM choice WHERE description = $1::int) LIMIT 1";
//    var params = [description];
    var params = [5];

    client.query(sql, params,function(err, result){
      if(err) 
        callback(err, null);
      if (result == null)
        callback("Empty query", null);
      callback(null, result.rows);
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