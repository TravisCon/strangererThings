var pg = require('pg');
pg.defaults.ssl = true;

connectionString = 'postgres://iitxlielolcqnu:f4acb49cfb5293787b0ca3f79e4f5622114ec8ccdc0d9a2927af6c60946d9a7b@ec2-184-73-167-43.compute-1.amazonaws.com:5432/d59m72tguufnuc';

function getChoices(id, callback) {
  pg.connect(connectionString, function(err, client) {
    if(err) 
      return callback(err, null);

    var sql = "SELECT s.photo_url, c1.description as consequence_description, c2.description as choice_description, c2.consequence_id, c2.id as choice_id FROM consequence c1   JOIN choice_group cg  ON cg.id = c1.trigger_group_id JOIN choice c2 ON cg.id = c2.group_id JOIN setting s ON s.id = cg.setting_id WHERE c1.id = $1::int";
    var params = [id];

    client.query(sql, params,function(err, result){
      if(err) 
        callback(err, null);
      if (result == null)
        callback("Empty query", null);
      console.log(JSON.stringify(result.rows));
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