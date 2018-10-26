object frmWebMaps: TfrmWebMaps
  Left = 0
  Top = 0
  Caption = 'frmWebMaps'
  ClientHeight = 632
  ClientWidth = 937
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 468
    Top = 137
    Height = 341
    Align = alRight
    ResizeStyle = rsUpdate
    ExplicitLeft = 16
    ExplicitTop = 107
    ExplicitHeight = 539
  end
  object Splitter3: TSplitter
    Left = 0
    Top = 478
    Width = 937
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsUpdate
    ExplicitLeft = -129
    ExplicitTop = 410
    ExplicitWidth = 1066
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 937
    Height = 96
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    object memPontos: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 929
      Height = 88
      Align = alClient
      Lines.Strings = (
        'Av. Mariland,1231,Porto Alegre,RS'
        'R. Pedro Ivo, 100, Porto Alegre,RS'
        'R. Silva Jardim, 100, Porto Alegre,RS')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 937
    Height = 41
    Align = alTop
    TabOrder = 1
    object btnLocalizarPontos: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 121
      Height = 33
      Align = alLeft
      Caption = 'Localizar Pontos'
      TabOrder = 0
      OnClick = btnLocalizarPontosClick
    end
    object btnAtualizar: TButton
      AlignWithMargins = True
      Left = 863
      Top = 4
      Width = 70
      Height = 33
      Align = alRight
      Caption = 'Atualizar'
      TabOrder = 1
      OnClick = btnAtualizarClick
    end
    object btnCalcularRota: TButton
      AlignWithMargins = True
      Left = 131
      Top = 4
      Width = 102
      Height = 33
      Align = alLeft
      Caption = 'Tra'#231'ar Rota'
      TabOrder = 2
      OnClick = btnCalcularRotaClick
    end
    object btnInfo: TButton
      AlignWithMargins = True
      Left = 239
      Top = 4
      Width = 119
      Height = 33
      Align = alLeft
      Caption = 'Obter Informa'#231#245'es'
      TabOrder = 3
      OnClick = btnInfoClick
    end
    object btnLimpaMarkers: TButton
      AlignWithMargins = True
      Left = 364
      Top = 4
      Width = 117
      Height = 33
      Align = alLeft
      Caption = 'Limpar Marcadores'
      TabOrder = 4
      OnClick = btnLimpaMarkersClick
    end
  end
  object Panel3: TPanel
    Left = 471
    Top = 137
    Width = 466
    Height = 341
    Align = alRight
    Caption = 'Panel1'
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 1
      Top = 92
      Width = 464
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsUpdate
      ExplicitLeft = 524
      ExplicitTop = 1
      ExplicitWidth = 292
    end
    object memRetorno: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 458
      Height = 85
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object memJson: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 98
      Width = 458
      Height = 239
      Align = alBottom
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object pnlInstrucoes: TPanel
    Left = 0
    Top = 481
    Width = 937
    Height = 132
    Align = alBottom
    Caption = 'pnlInstrucoes'
    TabOrder = 3
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 929
      Height = 13
      Align = alTop
      Caption = 'Instru'#231#245'es:'
      ExplicitWidth = 55
    end
    object lbxInstrucoes: TListBox
      Left = 1
      Top = 20
      Width = 935
      Height = 111
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 613
    Width = 937
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object WebMapa: TWebBrowser
    Left = 0
    Top = 137
    Width = 468
    Height = 341
    Align = alClient
    TabOrder = 5
    ExplicitLeft = 1
    ExplicitTop = 138
    ControlData = {
      4C0000005F3000003E2300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object pgpHtml: TPageProducer
    HTMLDoc.Strings = (
      '<!DOCTYPE html>'
      '<html>'
      '  <head>'
      
        '    <meta name="viewport" content="initial-scale=1.0, user-scala' +
        'ble=yes" />'
      '    <meta charset="utf-8">'
      '    <style>'
      '      html, body, #map {'
      '        margin: 0;'
      '        padding: 0;'
      '        height: 100%;'
      '      }'
      '    </style>'
      '  </head>'
      '  <body onload="initialize()">'
      
        '    <input type="hidden" name="edtRotas" id="edtRotas" value="Te' +
        'ste"/>'
      '    <div id="map"></div>'
      '  </body>'
      ''
      
        '  <script type="text/javascript" src="http://maps.googleapis.com' +
        '/maps/api/js?key=AIzaSyB_BAA-bOQfiFBgfDm6gCpcGWJDHKW3z4U&sensor=' +
        'false&language=pt-BR"></script>'
      
        '  <script type="text/javascript" src="http://ajax.googleapis.com' +
        '/ajax/libs/jquery/1.6.4/jquery.min.js"></script>'
      '  <script type="text/javascript">'
      ''
      '        var rendererOptions = {draggable: true};'
      
        '        var directionsDisplay = new google.maps.DirectionsRender' +
        'er(rendererOptions);'
      
        '        var directionsService = new google.maps.DirectionsServic' +
        'e();'
      '        var map;'
      '        var rotas;'
      '        var geocoder;'
      '        var markersArray = new Array();'
      ''
      '        function initialize() {'
      '             //var nome = window.navigator.userAgent;'
      '             //window.alert("O nome do browser '#233': " + nome);'
      ''
      '             geocoder = new google.maps.Geocoder();'
      '             infowindow = new google.maps.InfoWindow();'
      
        '             var latlng = new google.maps.LatLng(-30.02262580000' +
        '0007, -51.19057180000004);'
      
        '             var myOptions = { zoom: 18, center: latlng, mapType' +
        'Id: google.maps.MapTypeId.ROADMAP};'
      
        '             map = new google.maps.Map(document.getElementById("' +
        'map"), myOptions);'
      '             trafficLayer = new google.maps.TrafficLayer();'
      '             bikeLayer = new google.maps.BicyclingLayer();'
      '             map.set("streetViewControl", false);'
      ''
      '             directionsDisplay.setMap(map);'
      
        '             google.maps.event.addListener(directionsDisplay, '#39'd' +
        'irections_changed'#39', function () {'
      
        '                  OnDirectionsChanged(directionsDisplay.directio' +
        'ns);'
      '          });'
      '         }'
      ''
      '        function MarkerClick() {'
      '            var marker = this;'
      '            var latLng = marker.getPosition();'
      
        '            infowindow.setContent('#39'<b>'#39' + marker.getTitle() + '#39'<' +
        '/b>'#39' +'
      
        '                                  '#39'<br/> Latitude:'#39' + marker.get' +
        'Position().lat()+'
      
        '                                  '#39'<br/> Longitude:'#39' + marker.ge' +
        'tPosition().lng());'
      '            infowindow.open(map, marker);'
      '        }'
      ''
      '        function AdicionarMarker(lat, lng, title) {'
      '             var latlng = new google.maps.LatLng(lat, lng);'
      '             var marker = new google.maps.Marker({'
      '                  position: latlng,'
      '                  map: map,'
      '                  title: title,'
      '                  draggable: true'
      '             });'
      '             markersArray.push(marker);'
      
        '             google.maps.event.addListener(marker, '#39'click'#39', Mark' +
        'erClick);'
      '             return marker;'
      '        }'
      ''
      '        function LimparMarkers() {'
      '             if (markersArray) {'
      
        '                  for (i in markersArray) {markersArray[i].setMa' +
        'p(null); }'
      '             }'
      '             markersArray = new Array();'
      '        }'
      ''
      '        function LocalizarEndereco(address) {'
      '             if (geocoder) {'
      
        '                  geocoder.geocode({ address: address }, functio' +
        'n (results, status) {'
      
        '                       if (status == google.maps.GeocoderStatus.' +
        'OK) {'
      
        '                            map.setCenter(results[0].geometry.lo' +
        'cation);'
      
        '                            AdicionarMarker(results[0].geometry.' +
        'location.lat(),'
      
        '                                  results[0].geometry.location.l' +
        'ng(),'
      '                                  address);'
      '                       }'
      '                  });'
      '             }'
      '        }'
      ''
      '        function CalcularRota() {'
      '           var waypts = [];'
      '           for (var i = 1; i <= markersArray.length - 2; i++) {'
      '                waypts.push({'
      '                     location: markersArray[i].getPosition(),'
      '                     stopover: true'
      '                });'
      '           }'
      ''
      '           var request = {'
      '               origin: markersArray[0].getPosition(),'
      
        '               destination: markersArray[markersArray.length - 1' +
        '].getPosition(),'
      '               waypoints: waypts,'
      '               travelMode: google.maps.TravelMode.DRIVING'
      '            };'
      
        '            directionsService.route(request, function (response,' +
        ' status) {'
      
        '                 if (status == google.maps.DirectionsStatus.OK) ' +
        '{'
      '                      directionsDisplay.setDirections(response);'
      '                 }'
      '            });'
      '        }'
      ''
      '        function OnDirectionsChanged(result) {'
      '             rotas = result;'
      '             //alert(JSON.stringify(rotas));'
      '             $("#edtRotas").val(JSON.stringify(rotas));'
      '             $("#edtRotas").click();'
      '        }'
      ''
      '    </script>'
      '</html>'
      '')
    Left = 440
    Top = 65
  end
end
