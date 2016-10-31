inherited UserForm: TUserForm
  Caption = 'User'
  OnDestroy = FormDestroy
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    inherited tabEdit: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 27
      ExplicitWidth = 647
      ExplicitHeight = 327
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 36
        Height = 13
        Caption = 'User ID'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 27
        Height = 13
        Caption = 'Name'
        FocusControl = DBEdit2
      end
      object Label3: TLabel
        Left = 8
        Top = 88
        Width = 28
        Height = 13
        Caption = 'E-Mail'
        FocusControl = DBEdit3
      end
      object Label4: TLabel
        Left = 8
        Top = 128
        Width = 30
        Height = 13
        Caption = 'Phone'
        FocusControl = DBEdit4
      end
      object Label5: TLabel
        Left = 8
        Top = 168
        Width = 55
        Height = 13
        Caption = 'Login Name'
        FocusControl = DBEdit5
      end
      object Label6: TLabel
        Left = 8
        Top = 208
        Width = 46
        Height = 13
        Caption = 'Password'
        FocusControl = DBEdit6
      end
      object Label7: TLabel
        Left = 8
        Top = 248
        Width = 46
        Height = 13
        Caption = 'Is Admin?'
      end
      object DBEdit1: TDBEdit
        Left = 8
        Top = 24
        Width = 134
        Height = 21
        Color = clSkyBlue
        DataField = 'USER_ID'
        DataSource = datControl
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 8
        Top = 64
        Width = 524
        Height = 21
        DataField = 'NAME'
        DataSource = datControl
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 8
        Top = 104
        Width = 524
        Height = 21
        DataField = 'EMAIL'
        DataSource = datControl
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 8
        Top = 144
        Width = 264
        Height = 21
        DataField = 'PHONE'
        DataSource = datControl
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 8
        Top = 184
        Width = 134
        Height = 21
        DataField = 'LOGIN'
        DataSource = datControl
        TabOrder = 4
      end
      object DBEdit6: TDBEdit
        Left = 8
        Top = 224
        Width = 134
        Height = 21
        DataField = 'PASSW'
        DataSource = datControl
        TabOrder = 5
      end
      object DBComboBox1: TDBComboBox
        Left = 8
        Top = 264
        Width = 134
        Height = 21
        Style = csDropDownList
        DataField = 'ISADMIN'
        DataSource = datControl
        ItemHeight = 13
        Items.Strings = (
          'YES'
          'NO')
        TabOrder = 6
      end
    end
    inherited tabSearch: TTabSheet
      inherited DBGridSearch: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'USER_ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NAME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMAIL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PHONE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LOGIN'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PASSW'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ISADMIN'
            Visible = True
          end>
      end
    end
  end
  inherited ActionList: TActionList
    inherited DataSetFirst1: TDataSetFirst
      Enabled = False
      DataSource = nil
    end
    inherited DataSetPrior1: TDataSetPrior
      Enabled = False
      DataSource = nil
    end
    inherited DataSetNext1: TDataSetNext
      Enabled = False
      DataSource = nil
    end
    inherited DataSetLast1: TDataSetLast
      Enabled = False
      DataSource = nil
    end
    inherited DataSetInsert1: TDataSetInsert
      Enabled = False
      DataSource = nil
    end
    inherited DataSetDelete1: TDataSetDelete
      Enabled = False
      DataSource = nil
    end
    inherited DataSetEdit1: TDataSetEdit
      Enabled = False
      DataSource = nil
    end
    inherited DataSetPost1: TDataSetPost
      Enabled = False
      DataSource = nil
    end
    inherited DataSetCancel1: TDataSetCancel
      Enabled = False
      DataSource = nil
    end
    inherited DataSetRefresh1: TDataSetRefresh
      Enabled = False
      DataSource = nil
    end
  end
  inherited datControl: TDataSource
    DataSet = UserDM.cdsControl
  end
end
