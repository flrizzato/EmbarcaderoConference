object wmPrincipal: TwmPrincipal
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      Producer = ppPrincipal
      OnAction = WebModule1DefaultHandlerAction
    end>
  Height = 230
  Width = 415
  object ppPrincipal: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3' +
        '.org/TR/html4/strict.dtd">'
      ''
      '<html lang="pt-br">'
      '<head>'
      '    <title>Nivo Slider Demo</title>'
      
        '    <link rel="stylesheet" href="css/default/default.css" type="' +
        'text/css" media="screen" />'
      
        '    <link rel="stylesheet" href="css/nivo-slider.css" type="text' +
        '/css" media="screen" />'
      
        '    <link rel="stylesheet" href="css/style.css" type="text/css" ' +
        'media="screen" />'
      ''
      
        '    <meta http-equiv="Content-Type" content="text/html; charset=' +
        'utf-8">'
      '</head>'
      '<body>'
      '    <div id="wrapper">'
      ''
      '        <div class="slider-wrapper theme-default">'
      '            <div id="slider" class="nivoSlider">'
      
        '                <img src="img/Bl01.jpg" data-thumb="img/Bl01.jpg' +
        '" alt="" title="Imagem 1"/>'
      
        '                <img src="img/Bl02.jpg" data-thumb="img/Bl02.jpg' +
        '" alt="" title="Imagem 2" />'
      
        '                <img src="img/Bl03.jpg" data-thumb="img/Bl03.jpg' +
        '" alt="" title="Imagem 3" data-transition="slideInLeft" />'
      
        '                <img src="img/Bl04.jpg" data-thumb="img/Bl04.jpg' +
        '" alt="" title="Imagem 4" />'
      '            </div>'
      ''
      '        </div>'
      ''
      '    </div>'
      
        '    <script type="text/javascript" src="js/jquery-1.7.1.min.js">' +
        '</script>'
      
        '    <script type="text/javascript" src="js/jquery.slider.js"></s' +
        'cript>'
      '    <script type="text/javascript">'
      '    $(window).load(function() {'
      '        $('#39'#slider'#39').nivoSlider();'
      '    });'
      '    </script>'
      '</body>'
      '</html>')
    Left = 192
    Top = 96
  end
end
