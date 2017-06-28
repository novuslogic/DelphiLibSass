object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'DelphiLibSass Sample'
  ClientHeight = 283
  ClientWidth = 582
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
  object btnLibVersion: TButton
    Left = 8
    Top = 16
    Width = 75
    Height = 25
    Caption = 'LibVersion'
    TabOrder = 0
    OnClick = btnLibVersionClick
  end
  object Button1: TButton
    Left = 96
    Top = 16
    Width = 97
    Height = 25
    Caption = 'language_version'
    TabOrder = 1
    OnClick = Button1Click
  end
  object btnsasstocss1: TButton
    Left = 208
    Top = 16
    Width = 75
    Height = 25
    Caption = 'sass to css 1'
    TabOrder = 2
    OnClick = btnsasstocss1Click
  end
  object SaSSOpenDialog: TOpenDialog
    Left = 368
    Top = 144
  end
end
