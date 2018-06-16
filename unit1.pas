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
    Image1: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  Form1: TForm1; Image1 : TImage;  direction : String;            MyThread : TMyThread;

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
   Image1.Top:=Image1.Top-10;
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
  Form1.Caption:=inttostr(key);
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
         begin

                                MyThread := TMyThread.Create(false);
           end.
end.

