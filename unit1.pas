unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList, ExtCtrls;

type
             TMyThread = class(TThread)
    private
      fStatusText : string;
      procedure ShowStatus;
      procedure movePlayerUp;
    protected
      procedure Execute; override;
    public
      Constructor Create(CreateSuspended : boolean);
    end;

  { TForm1 }

  TForm1 = class(TForm)
    Iplayer: TImage;
    Llives: TLabel;
    Lscore: TLabel;
    Swall1: TShape;
    Swall10: TShape;
    Swall11: TShape;
    Swall12: TShape;
    Swall13: TShape;
    Swall14: TShape;
    Swall15: TShape;
    Swall16: TShape;
    Swall17: TShape;
    Swall158: TShape;
    Swall19: TShape;
    Swall2: TShape;
    Swall20: TShape;
    Swall21: TShape;
    Swall22: TShape;
    Swall23: TShape;
    Swall24: TShape;
    Swall25: TShape;
    Swall26: TShape;
    Swall27: TShape;
    Swall28: TShape;
    Swall29: TShape;
    Swall3: TShape;
    Swall30: TShape;
    Swall31: TShape;
    Swall32: TShape;
    Swall33: TShape;
    Swall34: TShape;
    Swall35: TShape;
    Swall36: TShape;
    Swall37: TShape;
    Swall38: TShape;
    Swall39: TShape;
    Swall4: TShape;
    Swall40: TShape;
    Swall41: TShape;
    Swall42: TShape;
    Swall43: TShape;
    Swall5: TShape;
    Swall6: TShape;
    Swall7: TShape;
    Swall8: TShape;
    Swall9: TShape;
    TmainTimer: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LlivesClick(Sender: TObject);
    procedure LscoreClick(Sender: TObject);
    procedure TmainTimerTimer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1; Iplayer : TImage;  direction : String;            MyThread : TMyThread;

implementation

{$R *.lfm}

                       constructor TMyThread.Create(CreateSuspended : boolean);
  begin
    inherited Create(CreateSuspended); // because this is black box in OOP and can reset inherited to the opposite again...
    FreeOnTerminate := True;  // better code...
  end;

  procedure TMyThread.ShowStatus;
  // this method is executed by the mainthread and can therefore access all GUI elements.
  begin
    Form1.Caption := fStatusText;
  end;

  procedure TMyThread.movePlayerUp;
  begin
   Iplayer.Top:=Iplayer.Top-10;
  end;

  procedure TMyThread.Execute;
  var
    newStatus : string;
  begin
    fStatusText := 'TMyThread Starting...';
    Synchronize(@Showstatus);
    fStatusText := 'TMyThread Running...';
    while (not Terminated) do
      begin
        If direction = 'U' then begin
                                      Synchronize(@movePlayerUp);
                                               end;

        if NewStatus <> fStatusText then
          begin
            fStatusText := newStatus;
            Synchronize(@Showstatus);
          end;
      end;
  end;

{ TForm1 }

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
begin
  Form1.Caption:=inttostr(Iplayer.Left);
  If key = 38 then begin
    direction := 'U';
  end;
  If key = 40 then begin
    direction := 'D';
  end;
   If key = 37 then begin
    direction := 'L';
  end;
   If key = 39 then begin
    direction := 'R';
  end;

end;

procedure TForm1.LlivesClick(Sender: TObject);
begin

end;

procedure TForm1.LscoreClick(Sender: TObject);
begin

end;

procedure TForm1.TmainTimerTimer(Sender: TObject);
begin
         If direction = 'U' then begin Iplayer.Top:=Iplayer.Top-3; Iplayer.Picture.LoadFromFile('Pacman270.png'); end;
         If direction = 'D' then begin Iplayer.Top:=Iplayer.Top+3; Iplayer.Picture.LoadFromFile('Pacman90.png'); end;
         If direction = 'L' then begin Iplayer.Left:=Iplayer.Left-3; Iplayer.Picture.LoadFromFile('Pacman180.png'); end;
         If direction = 'R' then begin Iplayer.Left:=Iplayer.Left+3;Iplayer.Picture.LoadFromFile('Pacman0.png');  end;
end;

         begin

                               // MyThread := TMyThread.Create(false);


           end.
end.

