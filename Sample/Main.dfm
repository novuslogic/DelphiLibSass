object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'DelphiLibSass Sample'
  ClientHeight = 362
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 739
    Height = 362
    ActivePage = TSConvertFileToCss
    Align = alClient
    TabOrder = 0
    object TSConvertFileToCss: TTabSheet
      Caption = 'ConvertFileToCss Example'
      object memoCCS1: TMemo
        Left = 0
        Top = 39
        Width = 731
        Height = 295
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
      end
      object btnsasstocss1: TButton
        Left = 3
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Load SCSS'
        TabOrder = 1
        OnClick = btnsasstocss1Click
      end
    end
    object ConvertToCss: TTabSheet
      Caption = 'ConvertToCss Example'
      ImageIndex = 1
      object btnsasstocss2: TButton
        Left = 3
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Load SCSS'
        TabOrder = 0
        OnClick = btnsasstocss2Click
      end
      object memoSCSS: TMemo
        Left = 3
        Top = 34
        Width = 320
        Height = 279
        TabOrder = 1
      end
      object btnConvertCSS: TButton
        Left = 327
        Top = 136
        Width = 75
        Height = 25
        Caption = 'Convert CSS'
        TabOrder = 2
        OnClick = btnConvertCSSClick
      end
      object memoCCS2: TMemo
        Left = 406
        Top = 34
        Width = 320
        Height = 279
        TabOrder = 3
      end
    end
  end
  object SaSSOpenDialog: TOpenDialog
    DefaultExt = '*.scss'
    Left = 360
    Top = 8
  end
end
