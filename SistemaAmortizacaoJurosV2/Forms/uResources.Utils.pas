unit uResources.Utils;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList;

type
  TFResourcesUtils = class(TForm)
    Il32: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FResourcesUtils: TFResourcesUtils;

implementation

{$R *.dfm}

end.
