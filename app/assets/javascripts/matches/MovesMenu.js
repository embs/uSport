$(function(){
	//Get our elements for faster access and set overlay width
	var div = $('div.sc_menu'),
		ul = $('ul.sc_menu'),
		ulPadding = 15;

	//Get menu width
	var divWidth = div.width();

	//Updates div size when window is resized
	$(window).resize(function() {
		divWidth = div.width();
	});

	//Remove scrollbars
	div.css({overflow: 'hidden'});

	//Find last image container
	var lastLi = ul.find('li:last-child');

	//When user move mouse over menu
	div.mousemove(function(e){
		//As images are loaded ul width increases,
		//so we recalculate it each time
		var ulWidth = lastLi[0].offsetLeft + lastLi.outerWidth() + ulPadding;
		var left = (e.pageX - div.offset().left) * (ulWidth-divWidth) / divWidth;
		div.scrollLeft(left);
	});

	//Changes modal title when a move is clicked
	$('.linkModal').click(function(){
		//Changes kind value attribute
		var kind = $(this).attr('value');
		$('#kind').attr('value', kind);

		//Sets the title of the modal
		var title = $(this).attr('title');
		$('#modalTitle').html(title);

		// Adiciona seletor de tipo de touchdown quando o tipo é touchdown
		if(kind == 'touchdown') {
			var move_kind = $('#touchdown_kind').val();
			$('#kind').attr('value', move_kind);
			$('#touchdown-kind').show();
			$('#team').show();
			$('#player').show();
			$('#player input').attr('required', 'required');
			$('#yards').show();
			$('#description').show();
			$('#move_description').attr('placeholder',
				'Você pode descrever esse lance aqui');
			$('#submit').val('Criar Jogada');
			$('#game-over').hide();
		}
		else if (kind == 'end') {
			$('#touchdown-kind').hide();
			$('#team').hide();
			$('#player').hide();
			$('#player input').removeAttr('required');
			$('#yards').hide();
			$('#description').show();
			$('#move_description').attr('placeholder',
				'Se quiser, comente o fim da partida aqui');
			$('#submit').val('Encerrar Partida');
			$('#game-over').show();
		}
		else if (kind == 'comment') {
			$('#touchdown-kind').hide();
			$('#team').hide();
			$('#player').hide();
			$('#player input').removeAttr('required');
			$('#yards').hide();
			$('#description').show();
			$('#move_description').attr('placeholder',
				'Você pode descrever esse lance aqui');
			$('#submit').val('Criar Comentário');
			$('#game-over').hide();
		}
		else {
			$('#touchdown-kind').hide();
			$('#team').show();
			$('#player').show();
			$('#player input').attr('required', 'required');
			$('#yards').show();
			$('#description').show();
			$('#move_description').attr('placeholder',
				'Você pode descrever esse lance aqui');
			$('#submit').val('Criar Jogada');
			$('#game-over').hide();
		}
	});

	// Altera o tipo da jogada quando a jogada é um touchdown (tipos específicos)
	$('#touchdown-kind').change(function() {
		var move_kind = $('#touchdown_kind').val();
		$('#kind').attr('value', move_kind);
	});

	$('#submit').click(function(e){
		e.preventDefault();
		if(($('#player input').attr('required') == 'required') & ($('#player input').val().length == 0)) {
			$('#player input').focus();
		}
		$('#NewMoveForm form').submit();
	});
});

//Enables thypeahead
$('.typeahead.player').typeahead({
  source: function(query, process) {
  	$.get('/players.json', { team_id: $('#move_team').val() }, function(data) {
      console.log(data);
      process(data);
    });
  },
  items:4
});
