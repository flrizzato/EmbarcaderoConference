object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  Caption = 
    'Embarcadero Conference 2015 | Nova Infraestrutura JSON: System.J' +
    'SON na pr'#225'tica '
  ClientHeight = 588
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 725
    Height = 541
    Align = alClient
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 2
      Top = 2
      Width = 721
      Height = 537
      ActivePage = TabSheet1
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Style = tsFlatButtons
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'JSON V'#225'lido'
        object mJSON: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 79
          Width = 707
          Height = 424
          Align = alClient
          Color = clBlack
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Consolas'
          Font.Style = []
          Lines.Strings = (
            '{} /* Escreva um JSON v'#225'lido aqui */')
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 707
          Height = 70
          Align = alTop
          BevelInner = bvLowered
          Caption = 'Panel2'
          ShowCaption = False
          TabOrder = 1
          object Button1: TButton
            Left = 11
            Top = 16
            Width = 198
            Height = 41
            Caption = '&Avaliar JSON'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = Button1Click
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Funcionalidades Diversas'
        ImageIndex = 2
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 214
          Height = 500
          Align = alLeft
          BevelInner = bvLowered
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 0
          object Button4: TButton
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 204
            Height = 76
            Align = alTop
            Caption = 'TJsonObjectWriter'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = Button4Click
          end
          object Button5: TButton
            AlignWithMargins = True
            Left = 5
            Top = 87
            Width = 204
            Height = 76
            Align = alTop
            Caption = 'TJsonTextReader'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = Button5Click
          end
          object Button6: TButton
            AlignWithMargins = True
            Left = 5
            Top = 169
            Width = 204
            Height = 76
            Align = alTop
            Caption = 'TBsonWriter'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = Button6Click
          end
          object Button8: TButton
            AlignWithMargins = True
            Left = 5
            Top = 333
            Width = 204
            Height = 76
            Align = alTop
            Caption = 'Serializar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = Button8Click
          end
          object Button9: TButton
            AlignWithMargins = True
            Left = 5
            Top = 415
            Width = 204
            Height = 76
            Align = alTop
            Caption = 'Deserializar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = Button9Click
          end
          object Button7: TButton
            AlignWithMargins = True
            Left = 5
            Top = 251
            Width = 204
            Height = 76
            Align = alTop
            Caption = 'TBsonReader'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = Button7Click
          end
        end
        object Panel6: TPanel
          AlignWithMargins = True
          Left = 223
          Top = 3
          Width = 487
          Height = 500
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel6'
          ShowCaption = False
          TabOrder = 1
          object Splitter1: TSplitter
            Left = 0
            Top = 418
            Width = 487
            Height = 3
            Cursor = crVSplit
            Align = alBottom
            ExplicitTop = 0
            ExplicitWidth = 405
          end
          object mLog: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 424
            Width = 481
            Height = 73
            Align = alBottom
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Consolas'
            Font.Style = []
            Lines.Strings = (
              'mLog')
            ParentFont = False
            TabOrder = 0
          end
          object Memo2: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 481
            Height = 412
            Align = alClient
            Color = -1
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -21
            Font.Name = 'Consolas'
            Font.Style = []
            Lines.Strings = (
              'Memo2')
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Instagram'
        ImageIndex = 1
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 707
          Height = 94
          Align = alTop
          BevelInner = bvLowered
          Caption = 'Panel3'
          ShowCaption = False
          TabOrder = 0
          object Label4: TLabel
            Left = 327
            Top = 34
            Width = 26
            Height = 13
            Caption = 'TAG:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Image1: TImage
            Left = 636
            Top = 22
            Width = 53
            Height = 49
            Picture.Data = {
              0A544A504547496D616765781B0000FFD8FFE000104A46494600010100000100
              010000FFDB008400090607141312151412141415151417171515141418171514
              181C15171D1714141717181C2820181C251C171721312125292B2E2E2E171F33
              38332C37282D2E2B010A0A0A0E0D0E1810101A2C1C1C242C2C2C2C2C2C2C2C2C
              2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C
              2C2C2C2C2C2C2C2C2CFFC000110800E100E103012200021101031101FFC4001C
              0000020203010100000000000000000000040603050002070108FFC400491000
              01030202060605070A0504030000000100020304112131050612415161132271
              8191B10732A1C1F014234272D1D2E1153352535462829293A2243443A3B21644
              B3F12573D3FFC4001B0100030101010101000000000000000000000102030406
              0507FFC4002D1100020201010605030501000000000000000102110321040512
              3141C113345181B132617122243391D114FFDA000C03010002110311003F00EE
              2B162E39E91B5F0CC5D4F4CFD9841D97C8DC0C841B100EE67FCBB334DD1518B9
              3D069D67F4950404B29DBD3C82E0906D1348FDECDDFC3E2906AB5D2B6A6FB733
              982F6D887E6DA395C1DA3DE52B3A2270C864132EAF68A0E6036BE2571ED79F83
              1D9F5D6C4A10B68065DB20B88249B5DCEC49DD9ADE1321C535CBA286C65C3CD6
              45A3FB38AC763CAF2636FEE7C0DE993832A8AF4FF44B6CF20399C0F12B7ABA87
              82D3BCB7C89CFD8AEA5A5009C379F341E968318F0DCEF30BDA6F4843FE3BAD74
              393776572DA52FCFC152DAA7E3C7E2EA46D5BF713ED3C94E29F97C5FEC521A4E
              CC3BFB7CECBC95A3D2D108AE938EF52B6AE4CBE3F0530A4C70DDF65BDDEC53B6
              9F1EFDD7B29B4140E6B9FC7FF4B66D63C6F3BEE022A3A3CEFC3B85B729194D86
              5F03FF006958B401F964806271BAC7D64837FB7DB7BAB1F938F6DEFD8A23070B
              1F679A2C5A15CFAC7F13E27728CD5C99DF11CC956469B0E2467860A37D2E780B
              E76FC13B19566B1FCCFC70513EA9E3336EF5652530C40232160867D38B72E3F6
              269A0A007563C71EE2541F2B78199F6A2AA6CD049200E277F76F5592E918DB71
              71DF61EC2568B5225A7524F963F8FB978DAE75C1BE22C45B304646FB90CED251
              71F0B7DAB435F1F1F1B7DAAA88E2FB8D3A235E6B21236277903E8C84C8CECB3E
              E47710BA2EAE7A528A4B36ADBD13BF58CBBA23DA3D667B570C75747C7DA3ED53
              415395BF0549B44B519733EB08DE1C016904117041B820E4411985B2E17A85AF
              0EA4708E42E753B8F59B998EFF004D9CB8B77EEC73EE30CAD7B439A439AE01CD
              70C410710415A27673CE0E2CDD62C5899021FA5BD62F93D30858E2249EE09198
              8C7AFD9B570DEF3C170F88ED38768C3BD307A4DD2E6A3484F8F5633D0B7908F0
              778BF68F7AA2A318B7B479AC64F53B30C790C229F14EDAA94C3A1187D2779A56
              2DC53AEAAFF971F59DE6BE3EF59560F75DCF59B7E251C0BF2BB8755C4033BC20
              AC8FADF57BC79AAEBFC155BA1FEDDFE5F63F3CDF1E63D9772827189ED3E683D2
              8318F2C9D8E56C5153BB13DA50BA50DFA3DF83BCC2F77BD7C97F5D8E4DD5E6A3
              EFF0C1DADC3893DB971B7052EC0BE58903760061BB8E2A007870C787B392D9A4
              600122F6BFC78F82F207AC0A681638587B4FC5D48D3C3E2DE6A16BF0C3B2FCBB
              FB16E1DCF2F7E3F6F824493B73CF8AD9AD19676ECF7F65D401F973DC3C2CA407
              971E3EEED28B15121038EEC800B2D801ECB66BC6B8EEE36BF6AC2FE68B151A38
              7136F77D8A278189B03CF3ECF8ED5EDC6385F05A39FDC7E38E582074412B7779
              0DE50CFDFB879EEB1EF44B9DC3BF772E362A07904F13F1CD3452423EB5579DAD
              969231205B701991CC94BD144ADB595BF3BDEFFF0092AE06D966700BBF1AA89F
              3B337C4C9B61A06361DAB66063B005A4F05A4400E6789CFF00053B5A1D9807B5
              5D9928590CF4CA1A494C6E1FA24D88EDDE137C7A262929DAD8369F28B926DD60
              7E931E49B06FE8E37C30BE295AA29D125EA28CB52F0388DDE2BAF7A18D63DB0F
              A491C4968E921BF0BFCE3076120F795C8EA45B71446AB69734B570CC0D831E0B
              BEA936907F2972E78B3BB22B547D4CB147D3378858B638CF93DD317BDCE7759C
              E3B45C73249B93DE7147D27ACDED1E6AAA1389BF1569467ACDED1E617333E963
              E686D9333DA9CB558FF871F59DE692E4CCA72D563F303EB3BCD7C8DEBFC1EEBB
              9EAF797F02FCAEE59579EA2AA7B959578EA1ED1E6AAC955BA7CBBFCBEC7E6FBE
              7CC7B2EE51CC7AC7B4F9A0B4ABB18F760EF308A9CF58F69F355FA61DF9BEC779
              85EFB7AAFD97F5F28E5DD5E6A3EFF0C85873CD4F0B8EEC86FE1D88106DF187C6
              0110C777586EF8ED5E419EB4309DC7D99F92DF6F1C10EC7F8638E1BF22B66BB7
              E56F7FC7B148A824496E7C3B82F4380BE58150176E18DB7E3DF92C3DB9029134
              4E0FC7773EE5ABA4E38FB143B76B7C77DD78643F19A61448E75F7658E76EC5A1
              7EFF008FB7BB92881F8C3D8BC270EDFC10146CE713F1EF50126E377E077AF5C6
              FC395FCD42F7F0DD87C704D0C49D633F3A2FFBFF00F255A4623B0F98567AD2DB
              48DFE3F30AA1C3223767D9BD77C3E847CCCCBF5B3603156F2C60EC8634B7AA09
              DACC93C392AA8D87307DEAE68DB23B02EF60FB15C6AE9827482E8A4922693138
              B4BB66F6B63D616CC61F8A0F4947626F89BE3BD102225E1A4DC32CF7F016C58D
              3CC9B1B70084D23262B4C95D0E76EE45857B6C7E2CAAE538F1573A5F07F3B054
              93AE147D49F32F3FEA9ADFDAA5F16FD8B1516D76AC57665C28961762AD690E2D
              DD88F354D13D1F4B28DA6FD61E6164CE9C7CD0EB21C4A70D5677CC0FACEF3481
              515ED6938DEDC131EAF6B2C2C8435CEB1BB8E6C199E6E5F2B794253C35157AAE
              E7A9DE5931F84A3C4AED0DB5EEEA1ED0AA8BF2CD075BAD1039960EBE237B78FD
              655A75822E67F97EF2ADD709C3054956AFB1F9DEF88B96D171D552EE6931EB1E
              D2ABF4D3FF0037964EF343C9A4DBB47078049C6CA0D29581C23B1BE0EBDBB42F
              7FBD1C65B0BA77F4FCA39776C251DA636BD7E19BB5F8F2CD4A1FEFCF33C4AA96
              D4295B50BC7B47A9E22D43F0C6DD8325B893B46F3F6F7E1E0B6D07A0EA2AB189
              9D518195E7658395F7F636E53BE8DD4681836A77BA63990098E216FEE3E21547
              1B6673CD1888DD30E36DF8F9296225D886B9C33B86920F804F536B468AA3C3A4
              A58DC3746D0F7F796827C5087D2F506E9277736C4FF785A2C1F739DED5E884F9
              0B8025C1C37DDC1CD1ED0A36CB7FA439F72746FA5EA0BE2F9DBCDD13EDEC08A8
              759345561B6DD2C8E3B9ED11C9E2407043C1F71ADA7D51CFF6F72F1CFE39279D
              25A8F0BC5E9E47447735DF391771F5876DCA4BD33A167A5C65659A4D848DEBC6
              EE41C323C8D8F259CB1B46D0CD190339F751BDFF00010E6750BE7528D1B2935B
              A98F564190241FE2B107E38854D4CF4E7D2B5C0875B11620E44702AB5DABB113
              7697B7934823B89057463CA92A67265C0E4EE255474C33692DECC5BE07DC8DA5
              8CFD290DBF71A1A7C4DFD88C1A0983E9CBE2DFBAB7FC8ACFD6C9E2DFBAAFC581
              8BD9B210CF56D633658035B9DB324EF7127124F154B1B4CD2B58DDE71E407ACE
              EE0AF64D0311CE497C5BF754F0082981D8CCE78DDE7802770F049E555A0F1EC8
              E2FF00511E9C70E90F60F8F6AA398A26A2A368971CCE28199EB38A3A26EF537B
              AC50ED2C546765AD36AED63FD4A771FE38C79B91926ABD7C6DE924A62C8DB62F
              7992336171B81B9DD804F9ABE72C55D6B4445D4520DC361C7B1AF05C7B85CF72
              3407292E4C51D51D538ABA29A492A2489D0759EC6C7B4D0C2D243AFBCF55F80B
              9C0710A9A9B55EA9FB263A79DCD906D46761C369B9876380C08F14F1A9D3D3D3
              4350D96A228DD50DE8C35C72018E1B7CC5E4FED2AC6874FD3B22A267CB5A3A02
              0C8D0F702E058E01AF17F55A1D91C06CF20AD3546326DB6DEACE6F49ABD50F2F
              0C865718EE240D63AEC2330EE0703866AE28751AA9F1CB26C39BD15BA8E6BFA4
              792010D6B40C7020E7BD393358E943E7FF00194EE64F30718DE5CD0008D9B4F1
              2B0DD87AA7122D703104A1C6B1D33DB5D1B6B7A3E94B3A29E695CC07E6C35E63
              7DC1B0D9B5C626DBF340AC52A7D53AA31F4A219362D70E00E5C6D9916DF655F5
              7A06798B053B3A494923A30E6B36C664DDD85C5BBD748D0BAD1430884B6A606B
              3A10D22491E6A03858ECBDA4DA36000E600BD837038A9EABD4ED69482389E246
              F4C487B3D52D60739CE1CAC2C953E57A3E652975F428A5D4CD2AD692EA170005
              C933C0001BFE926BD50D47C1B2D734826C5B4E1C093C0C85B90FDD189E591E85
              A42BFA437CE307E6DBB9E41C6570DED07D51BF3E0B917A49F484E0E75352BC87
              0244D3038DF7B1878F13DC8E088FC59D6AC6AD70F48D0510E8A202595A2C2265
              9B1C7C0388C0760C5720D3DAE359587E7657061CA367518395867DF7540C6171
              B9C4A3E92949200173C02DA31309482B46D0DF209B34668473AD6087D17436B6
              D380E4DFB4A6BD1AD60E27B5C7DCBBA0E305F738E736F915559ABAE0324ABA57
              44819B4782E9F55B36DE3BCFE29734952ED7AAEBF277DA129648CD6A446528BE
              627E88D6CACA270E8657167EAA4EBB3C0E5DCBABEA87A4382B4743286C52B858
              C5259D14BC436F81EC38AE49A5A8ECEB1163F197154B3425B8F85B92E3944EE8
              4ED1DAB5B352080E9689A5D6B9753ED58B7898DC731FBA711BAFB9522D50D28F
              6873285CE0EC4384F0106F91C1C8DF473E909DB4DA6AB79388114CE38DF731E7
              C9DDC5755A7ACE81DB630889F9D60C9849FCF346E693EB0EFE2B0708FA1D0B2C
              EB4671C3A8DA5BF607FF005A0FBCB5FF00A174B7EC0FFEB41F797D1F1BC1170B
              D29F0445E34FD4F9B4EA1E95FD85FF00D683EF2D0EA0E95FD85FFD683EF2FA48
              851B825C283C59FA9F371D41D2BFB13FFAD07DE5A1D42D29FB1BBFAD0FDF5F46
              BC216608A41E24BD4F9D64D46D2433A477F561FBCABEA7562B59EBD391FC719F
              272FA1ABB248DAC6734B42936FA9CA3F24547EA8FF00333ED589AF697A98C68D
              5FDC9DA8DA08B100822C41C8DF021246AF9C93BD0E4B31C849D33A8D52C24D23
              9B2464DDB13CECBD80FD16B8E0E1B85C8C2CAA0EA96933FF006DFEE45F7D7628
              8A2E3566767103A95A50FF00DB7FBB17DF5AFF00D09A53F65FF762FBEBBCB148
              15225B67038FD1E69571B7C9DADBFD27CB1EC8EDD9713EC4EFABBA98DD1E0996
              41254CCD2D73DA2CD8A216323597C6EEC1BB5867C9748BA50AEA9DB91EFDC4EC
              37EAC787B5DB47B820109DE92B5ABE4B06C466D34C0B596FA0D181701CB21CD7
              0B1726E77ABAD75D306AAAE492FD507619F55980F1C4F7AAC8235A4513261343
              0DCDB2E2782BC64CD60B37BCEF3DAAB48D86D877F6A19F36F2B4E2E1306B8865
              A6ABBABCD1F596CC84A9A36073AC5DD51B80CFBD335098DBB879F9A716D984A0
              5AD5D70233F1549535642B0A996370C8792A59A89CE786C473391CB9AA92A1AC
              7EA692D535E2CF171F19154BA469ED9620E47DC53B9D0AC7C5B030B6FDE1DFA4
              955F4EE6B9D1482C41B1F711E616724D17055C8599A2B2ED7E8CB5ACD543D14A
              6F3420037FF51870048DFC0FE2B94D5521C4705E6AE693752554730C9AEEB0E2
              D383C7879059B3A60ECFA67572AF61C6026E1A03E2273E8C9B0693BCB482DECD
              93BD31DD20D4546C88E769FCD90EB8DF1C960FF66CBBF813B52CDB4D054A2993
              15A396C4AD1C50C442F424C51321424C54B291595C70489AC6734F15C7048BAC
              691A4455BAF56AB1031A757D3BD09C123EAFEE4EF459282A45B445171941C48B
              8D5232612C2A5695030A95A5522591692A8D889EFF00D1693E01736D6BAC3050
              CCE06CE6C5B20FEF386CDFC5C9EB5A5F6A778E361E2E01732F49EFFF00E3E5E6
              E8FF00F203EE4FA8D7238B451E2ACE923C6FC020690DD59B059A7B7C97424612
              64129B950C11ED3EE7D5665CCFC7B94C4604AF699B68C73B9F8F050C92C619D5
              9534AA8217AB9D1F624071B03BD5C4B510C925C1052D4591DA4E26B0EC837233
              54B5055CD56868A036E85AD9AA7AAD91B16C01D2BC0DA99E09B02DBF55BCCE38
              D97BAD3A099135B245B471B3DCE71739D7C9C49DF7C3BD2BE8AAB7C6E2F8CD9D
              623117188DE3C0F72B38ABE59D8D323CBB964DC0F01828724D194A34C82482E0
              1EE3EEF7AA6AFA3B14DB041D53DDE6ABF4CC21B89FC545194654E8E85A8151D3
              5046D763B21D0BBB07547F6909D353AA8BA06877ACD1B2EED6F54FB42E79E8A0
              FF0085947098DBBD8D4E7AA925A495BB84AFFEE3B5EF591D7CD0E2544F2B7BA8
              9E5022290A0E628990A1262A5948ABAE38246D6239A76AF38247D622A4D10AD7
              58BC58A806CD01B93B511C123E8039276A2382CCA916D122A328288A2E32A919
              B09615334A81854AD2A88654EB71FF000EEE563E0415CDBD248BE8E97918CFFB
              8DFB574ED628F6A170E208F62E7DA4A9FE5145247BDF139A3EB01D5FEE013EA3
              5C8E110E6AC6398EC9DF8AAC69C51D11F685BA66322513023B96F4F334C631CA
              E10A16919D97169C9D88EDF8F7244D05C320BE63C55B51C8DB8DACB7DAD74BEE
              8F153C4EB269D1A2192B668F6BE6EE1BC0D955544A388F1084748872D24A729D
              9ADE85CD24CD0D249C813C720ADB444ADE89B6B9BE3C3337095E46DF6626E6FC
              F937794CD4D6000190161DD92946332E2194EC9B0B2A7D31CD59C2EEAFB7C152
              E9396E559CCBEA1FFD1532D4B29E337946DFB5336AC4979E6B7EB1DECB0F72A8
              D4583A2A061386D97CA7B09B34FF002B5A5586A49DA25DFA44BBF98DFDEB9E47
              6AE43EDD44F2B6BA85E526088E428398A22428399CA5948ADAE760923580E69D
              2B4E0927580A9EA6885ABAC5E2C5421A3409C93AD09C12468239275A1C967D4B
              916F1145C6505122E3568C98430A98150314A0AA248EBDB7611C973BA57EC4B2
              4678ED37BF31E2BA1CCEC173CD698CC52895A3238F31BC20713916BEE88F93D5
              BF6459927CEB3859C7AEDEE75F0E1654B03D760D69D0EDAEA61B16E91BD789C7
              89F5A327707580ED00EE5C69CD2C7104104120822C41181041C882B68B339C42
              DDC578E8F6858AF60C54FD159534640A252DC1E3B1C3DE8B89A1D9107B16C22B
              AD4E8E69DD6ECC148D491B9880CFDA87338BDA31B4EF60E64A9DBA319C09ED25
              151C16C0003B132B88D2869F63138BDDEB1F70E4ACE9DF72868E3256F21D8091
              12959633D5D82AED1F4EEA89D9137391C1B7E1BDCEEE6827B956D456125745F4
              73A17A267CA641D695B68C1FA2C38979E6EB0B721FBC52721E380CDAC350D8A9
              C471E1702260E000B7B1A15BEA5C16602922B2AFE535236716B3AADE67E93BDD
              E2BA56838361807259B6745685C39CA17B97A5CA17B94B624692B9073225E507
              3152CA456D69C12569F29CAB5D824BD3C92E65A17162F2EBD56033E81DC9D687
              2491A08E49D684E0B3EA548B785171A0A228B8CAA32610D2A50A0695202A9088
              E529775868F6D85313D57D5B70402399D0D598242C77A84E7C0AAED77D52F945
              EA29C032E6F60FF540FA4DFDFE5F4BB7365D65D177B9097F476977427624B96E
              E3BC2A4CA6ACE65092D36CAC6C41C08E208DC55C523C1CD3FE9DD5EA7AE1B60E
              C4B61699801DAC2C04ADFA432C731CF2487A4F40D4D263247B4C1FEAC7D78FBD
              C05DBFC402DE135D4E79E30E8E801C94EDD18EE0A9E934A01BECAE69B4D8FD21
              E2B64A0CE694668DDBA2DDC16FF936D9AF66D3D8663C555556991FA57ECC5294
              60BA9318E4619512358305415F5575353327A976CD3C4F90EF207547D671EAB7
              BC84E5A0352A38BE72ACB6578C4463185BCDC4FE70F2F57EB2C6525D0E9C78EB
              9951A97AA867227A86DA018B5A703311961FABE277E43794D9ACDA72D78633D7
              77AC47D11F6A134EEB3626384ED3F22FDCDFB4F240E81D185EEB9B9B9B92733C
              CAC5B3A1219352F46E4EB60325D1A0C02A7D0F4A2368015BB1458327BA89C57A
              4A8DE52B03479424A54F2142CA5228ADAD381499A777A70AD3824DD3850B9948
              5E58BCBAC5603368239275A138246D067109D680ACFA94CB988A2A328188A298
              E4CCD8535CA4050ED2A5055126CE424ED44DD45204C0A2AE86E0A4AD37A26F72
              1742AA8D5256C09148E6AC9A581D761B7239782B8A0D6E19480B4F11923B48E8
              E07725CACD13C15260D1753D0505462628893F499789DCC9E8C807BEE833A8D4
              44DC3AA072124647F7464A5C9685C38A8F6A56E4F7F89F7AAB2690CC750E8FF4
              EA7BE48BFF00C91106AEE8F87131B5E46F95EE7F8B6E1A7BC24F74D31FA6FF00
              123C969F2473BD6BBBEB127CD014874ABD6C8636EC4403837D56440060EC02CD
              097EBB4C4F51813B0DFD169C7BDDF678A869B4593B95FE8DD0FC424D8E80743E
              872E230B05D0F4368E11816086D1D481B9057D4D1A86C61B004534A8230A5054
              88DCB944F2BD2546F4022390A165729E428594A432BAB0A4ED38536D6BB049DA
              68A23CCB28AFF18AC5E5D78B410C5A10E49CE85D8244D0EFCAF872398E49CB47
              C992CD94C6089C8A6155B0BD191BD0430C695234A19AE52072762A27BAF1CA30
              E5E9298A88656AADA9895AB90B2B1163172AE9D545452A6B9E155D3D322CA152
              6A41C10AFA11C1334B4A867D227602FF00C8470534746382B7148A78E91162A0
              1A6A4E4ADA96994D0532B18214AC0F69615651354513110D4844AD5B5D461CBC
              DA480DCB946E2BC2E51BDE803591C8299EA5964414D224D8D203AD7A50D30E4C
              B5B2E094B4B4B8A712FA155758A3D993F5727F23BEC5E2D289B437EB4521A7D2
              150C3802F32379B65EB8B761247F0AB2D1952993D30683DA89956C1D687A925B
              7C6E383BF85C7C1C782E7DA32AD4CD6A383B43D4332363952F51D55D59433ACC
              6D170C954CD9155B2653B664EC9A2C03D7BB682132D84A9D8A828BD68E2A1E95
              617A2C0F1E10D244882E5A945800490281D4CAC485A16A630014CA5653A27656
              C02560691C4886356A0ADB6916226695B6D283A45A9952B0092F5A1910C66519
              95161412F914324AA07CAA07CC958E892595033CABC96755F5350829206D213A
              5F8A94D44F1C0DCE57B59D81C6CE3DC2E7B911A46A937FA1CD05D24AFAC78EAC
              778E1BEF711F38F1D80ECFF13B82D211149D23A87E4A8BF402C46AC5D0729AC9
              18702D70041041071041C0823785C3B5E3545F412192205D4AF3D57666227FD3
              7F2E0EEC071CFB9AD2689AF696BC0735C2C5AE00820E6083984A4ACA8CB859F3
              DD0E905794D5E38ABCD63F459899285E1B724F4127ABD8C7E63B0DFB4244AFA3
              A9A536A88648FF00788BB0F63C5DA7C573CA0D1D319A636C558896D5F348F0E9
              4E68A6695E6A2995A0E62A96C2A9278D2FCD6C34BF3453150E02AD6C2AD270D3
              0B3F2C734E9850E3F2A0B3E5493FF2BAF7F2C734530A1BCD485A9A90948E98E6
              BCFCAFCD2A614377CA02D7E541291D31CD79F95D3A61486EF95AF0D5A50FCAFC
              D7874B734A98A86E356B535694BF2B2D4E964530A435BAAD46EAB4A874AAD0E9
              4E69F0B0D0697D58434B5838A5B7693E687974973470817D515DCD53D657F343
              D1453D4BB669E29253FB8D240ED764DEF213C6AEFA29924B3EB9FD1B73E86220
              BCF273F26F636FDA15A812E490AFAA7AB32E919B65B76C2C3F3B36E1BF61B7CD
              E46EDD7B9DC0F7ED1F44C863645134359180D6B46E03CCF35941451C31B63898
              D631A2CD6B4580FC79A216C95184A5662C58B151262C58B100628AA7D4776158
              B1007CDFAD7FE7E7ED67FE36A05AB162C1F33AA3C8DC2D962C48662F562C4018
              BD5E2C401B2F178B10062F17AB10078BC5EAC401E05AAC5880352B472F562606
              8E5941FE620FFEE8BFE6162C42E64B3E9CD11F9967623162C5B9CC62C58B1006
              2C58B1007FFFD9}
            Stretch = True
          end
          object Button2: TButton
            Left = 168
            Top = 10
            Width = 153
            Height = 76
            Caption = 'Buscar Listagem'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = Button2Click
          end
          object Button3: TButton
            Left = 7
            Top = 10
            Width = 155
            Height = 76
            Caption = 'Pedir Autoriza'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = Button3Click
          end
          object Edit1: TEdit
            Left = 327
            Top = 53
            Width = 162
            Height = 31
            Alignment = taCenter
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = 'delphi20anos'
          end
        end
        object PageControl2: TPageControl
          AlignWithMargins = True
          Left = 3
          Top = 103
          Width = 707
          Height = 400
          ActivePage = TabSheet4
          Align = alClient
          TabOrder = 1
          object TabSheet4: TTabSheet
            Caption = 'Credenciais'
            ImageIndex = 2
            DesignSize = (
              699
              372)
            object LabeledEdit1: TLabeledEdit
              Left = 20
              Top = 48
              Width = 533
              Height = 21
              EditLabel.Width = 45
              EditLabel.Height = 13
              EditLabel.Caption = 'Client ID:'
              TabOrder = 0
            end
            object LabeledEdit2: TLabeledEdit
              Left = 20
              Top = 105
              Width = 533
              Height = 21
              EditLabel.Width = 65
              EditLabel.Height = 13
              EditLabel.Caption = 'Client Secret:'
              TabOrder = 1
            end
            object LinkLabel1: TLinkLabel
              Left = 20
              Top = 149
              Width = 122
              Height = 19
              Anchors = [akTop, akRight]
              Caption = 
                '<a href="https://instagram.com/developer/">Instragram Developers' +
                '</a>'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              UseVisualStyle = True
              OnLinkClick = LinkLabel1LinkClick
            end
          end
          object JSON: TTabSheet
            Caption = 'JSON'
            ImageIndex = 1
            object Memo1: TMemo
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 693
              Height = 366
              Align = alClient
              Color = clBlack
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -21
              Font.Name = 'Consolas'
              Font.Style = []
              Lines.Strings = (
                'Memo1')
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
            end
          end
          object Informações: TTabSheet
            Caption = 'Informa'#231#245'es'
            ImageIndex = 2
            DesignSize = (
              699
              372)
            object Label1: TLabel
              Left = 16
              Top = 16
              Width = 63
              Height = 23
              Caption = 'Label1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label2: TLabel
              Left = 16
              Top = 61
              Width = 38
              Height = 13
              Caption = 'TEXTO:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 323
              Top = 61
              Width = 34
              Height = 13
              Caption = 'LIKES:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Memo3: TMemo
              Left = 16
              Top = 80
              Width = 301
              Height = 257
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              Lines.Strings = (
                'Memo3')
              ParentFont = False
              TabOrder = 0
            end
            object LinkLabel2: TLinkLabel
              Left = 393
              Top = 16
              Width = 60
              Height = 19
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = 'LinkLabel2'
              TabOrder = 1
              UseVisualStyle = True
              OnLinkClick = LinkLabel2LinkClick
            end
            object Memo4: TMemo
              Left = 323
              Top = 80
              Width = 301
              Height = 257
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -19
              Font.Name = 'Tahoma'
              Font.Style = []
              Lines.Strings = (
                'Memo4')
              ParentFont = False
              TabOrder = 2
            end
          end
        end
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 547
    Width = 731
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Caption = 'Panel5'
    ShowCaption = False
    TabOrder = 1
    object LinkLabel3: TLinkLabel
      Left = 12
      Top = 11
      Width = 94
      Height = 17
      Caption = 
        '<a href="http://eugostododelphi.blogspot.com.br">Eu Gosto do Del' +
        'phi</a>'
      TabOrder = 0
    end
  end
end
