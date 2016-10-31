var options = {
  mode: 'view'
};

function setJson(json){
  var container = $('#jsoneditor')[0];

  var editor = new JSONEditor(container, options, json);
}

var url = 'http://127.0.0.1:9090/';


function requestJSON(){
  $.ajax({
    type: 'GET',
    url: url,
    dataType: 'json',
    beforeSend: function(xhr){
      xhr.setRequestHeader('Access-Control-Allow-Headers: Content-Type, Content-Range, Content-Disposition, Content-Description');
      xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
      xhr.setRequestHeader("Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS");
    },
    success: successo,
    error: erro,
  });

}

function erro(data){ // if error occured
  alert("Erro na Chamada!\n\n Dados meramente ilustrativos.");
  var json = {
    'array': [1, 2, 3],
    'boolean': true,
    'null': null,
    'number': 123,
    'object': {'a': 'b', 'c': 'd'},
    'string': 'Hello World'
  };
  setJson(json);
}

function successo(data){
  console.log('sucesso');
  setJson(data);
}
