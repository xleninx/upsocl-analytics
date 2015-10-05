  function show_country(url_id){
    var data = {};
    $.get('/analytics/country/'+url_id, function(info){
      $.each(info, function(index, item){
        i = item.table;
        data[i.countryIsoCode] = i.pageviews;
        $('.table-country').append('<tr><td>'+i.country+'</td><td class="text-center"><span class="label label-primary">'+i.pageviews+'</span></td></tr>');
      });

      $('#world-map').vectorMap({
          map: 'world_mill_en',
          backgroundColor: "transparent",
          regionStyle: {
              initial: {
                  fill: '#e4e4e4',
                  "fill-opacity": 0.9,
                  stroke: 'none',
                  "stroke-width": 0,
                  "stroke-opacity": 0
              }
          },

          series: {
              regions: [{
                  values: data,
                  scale: ["#1ab394", "#22d6b1"],
                  normalizeFunction: 'polynomial'
              }]
          },
      });
    });

  }
