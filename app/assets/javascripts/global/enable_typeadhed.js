$(function (){
  // single dataset
  $('.typeahead.search').typeahead({
    items:4,
    source: ['edmatheus', 'timtrueman', 'JakeHarding', 'vskarich']
  });

  // single dataset
  $('.typeahead.player').typeahead({
    source: function(query, process) {
      $.get('/players.json', { team_id: $('#move_team').val() }, function(data) {
        console.log(data);
        process(data);
      });
    },
    items:4
  });
});
