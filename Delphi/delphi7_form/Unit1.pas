unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, ExtCtrls;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    ed_from: TLabeledEdit;
    ed_to: TLabeledEdit;
    ed_send: TMemo;
    Label1: TLabel;
    Button1: TButton;
    ed_apikey: TLabeledEdit;
    ed_response: TMemo;
    ed_request: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var s: string;
begin

s := 'http://smspilot.ru/api.php?';
s := s + 'send='    + IdHTTP1.URL.ParamsEncode(ed_send.Lines.Text);
s := s + '&to='     + IdHTTP1.URL.ParamsEncode(ed_to.Text);
s := s + '&from='   + IdHTTP1.URL.ParamsEncode(ed_from.Text);
s := s + '&apikey=' + IdHTTP1.URL.ParamsEncode(ed_apikey.Text);
s := s + '&charset=windows-1251';

ed_request.Text := s;
s := IdHTTP1.Get( s );
ed_response.Lines.Text := StringReplace(s,#13,#13#10, [rfReplaceAll]);

end;

end.
