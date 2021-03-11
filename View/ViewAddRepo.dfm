object WindowAddRepo: TWindowAddRepo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Adicionar Reposit'#243'rio'
  ClientHeight = 303
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  DesignSize = (
    341
    303)
  PixelsPerInch = 96
  TextHeight = 13
  object LblName: TLabel
    Left = 8
    Top = 148
    Width = 38
    Height = 16
    Caption = 'Nome:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblPath: TLabel
    Left = 8
    Top = 96
    Width = 55
    Height = 16
    Caption = 'Caminho:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LblLink: TLabel
    Left = 8
    Top = 47
    Width = 113
    Height = 16
    Caption = 'Link do Reposit'#243'rio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BtnSave: TSpeedButton
    Left = 239
    Top = 262
    Width = 97
    Height = 34
    Action = ActAdd
    Anchors = [akRight, akBottom]
    ExplicitTop = 224
  end
  object BtnDiscard: TSpeedButton
    Left = 136
    Top = 262
    Width = 97
    Height = 34
    Action = ActCancel
    Anchors = [akRight, akBottom]
    ExplicitTop = 224
  end
  object BtnDir: TSpeedButton
    Left = 306
    Top = 118
    Width = 27
    Height = 24
    Cursor = crHandPoint
    Action = ActDir
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
  end
  object LblDescription: TLabel
    Left = 8
    Top = 202
    Width = 60
    Height = 16
    Caption = 'Descri'#231#227'o:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object TxtPath: TEdit
    Left = 8
    Top = 118
    Width = 298
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 300
    ParentFont = False
    TabOrder = 0
    OnChange = TxtChange
    OnKeyDown = TxtPathKeyDown
  end
  object TxtName: TEdit
    Left = 8
    Top = 170
    Width = 326
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 30
    ParentFont = False
    TabOrder = 1
    OnChange = TxtChange
  end
  object CheckCloneRepo: TCheckBox
    Left = 8
    Top = 273
    Width = 122
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Clonar Reposit'#243'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    ExplicitTop = 225
  end
  object TxtDescription: TEdit
    Left = 8
    Top = 224
    Width = 326
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    TabOrder = 2
    OnChange = TxtChange
  end
  object TxtLink: TComboBox
    Left = 8
    Top = 69
    Width = 325
    Height = 21
    TabOrder = 4
    Items.Strings = (
      'https://github.com/'
      'https://gitlab.com/'
      'https://bitbucket.org/')
  end
  object CheckActive: TCheckBox
    Left = 8
    Top = 8
    Width = 50
    Height = 23
    Caption = 'Ativo'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 5
  end
  object Images: TImageList
    BlendColor = clWhite
    BkColor = clWhite
    Left = 216
    Top = 159
    Bitmap = {
      494C010101000800040010001000FFFFFF00FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000006500000088000000880000
      0088000000880000008800000088000000880000008800000088000000880000
      0088000000820000001100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000A800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000001C0000007600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000F30000000E000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000009000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000BA00000061000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000005D00000033000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008800000091000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000B00000084000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008800000075000000200000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000008D000000050000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000880000001A000000760000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000450000004B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008800000000000000910000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000020000008C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000088000000000000005B0000
      0063000000440000004400000044000000440000004400000044000000440000
      0044000000440000004400000044000000A40000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008800000000000000030000
      003F000000440000004400000044000000440000004400000044000000440000
      0044000000440000005D0000008F0000002A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000002200000065000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008800000000000000000000
      000000000000000000000000006D000000890000008800000088000000880000
      0088000000880000008B00000022000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000008B00000000000000000000
      0000000000000000003400000074000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000006300000088000000880000
      0088000000880000007C00000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object Actions: TActionList
    Images = Images
    Left = 168
    Top = 159
    object ActDir: TAction
      ImageIndex = 0
      OnExecute = ActDirExecute
      OnHint = ActDirHint
    end
    object ActAdd: TAction
      Caption = 'Adicionar (Ctrl+S)'
      Enabled = False
      ShortCut = 16467
      OnExecute = ActAddExecute
    end
    object ActCancel: TAction
      Caption = 'Cancelar (Esc)'
      OnExecute = ActCancelExecute
    end
    object ActEsc: TAction
      ShortCut = 27
      OnExecute = ActEscExecute
    end
  end
  object OpenFile: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 120
    Top = 159
  end
end
