object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'DelphiLibSass Sample'
  ClientHeight = 362
  ClientWidth = 679
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
    Width = 679
    Height = 362
    ActivePage = TSConvertFileToCss
    Align = alClient
    TabOrder = 0
    object TSConvertFileToCss: TTabSheet
      Caption = 'ConvertFileToCss'
      object memoCCS: TMemo
        Left = 7
        Top = 34
        Width = 657
        Height = 295
        TabOrder = 0
      end
      object btnsasstocss1: TButton
        Left = 5
        Top = 3
        Width = 75
        Height = 25
        Caption = 'Load SCSS'
        TabOrder = 1
        OnClick = btnsasstocss1Click
      end
    end
  end
  object SaSSOpenDialog: TOpenDialog
    DefaultExt = '*.scss'
    Left = 152
  end
end
